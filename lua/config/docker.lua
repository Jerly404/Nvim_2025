local M = {}

-- Helper to get project root directory
local function get_project_root()
  local root = vim.fs.root(0, {
    "composer.json",
    "package.json",
    "pyproject.toml",
    "requirements.txt",
    "go.mod",
    "Cargo.toml",
    "Dockerfile",
    "docker-compose.yml",
    "compose.yaml",
    ".git",
  })
  return root or vim.uv.cwd()
end

-- Helper to get sanitized project name
local function get_project_name()
  local root = get_project_root()
  local name = vim.fn.fnamemodify(root, ":t"):lower():gsub("[^%w_%-]", "-")
  if name == "" or name == "." then
    name = "app"
  end
  return name
end

-- Templates definition
M.templates = {
  laravel = {
    name = "PHP / Laravel (PHP 8.3 FPM + Nginx + PostgreSQL + Redis)",
    detect = function(root)
      return vim.fn.filereadable(root .. "/artisan") == 1
        or (vim.fn.filereadable(root .. "/composer.json") == 1 and vim.fn.readfile(root .. "/composer.json"):find("laravel") ~= nil)
    end,
    files = {
      ["Dockerfile"] = [[FROM php:8.3-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    postgresql-dev \
    libzip-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip opcache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html

# Ensure proper permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true

EXPOSE 9000
CMD ["php-fpm"]
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-backend
    restart: unless-stopped
    working_dir: /var/www/html
    volumes:
      - ./:/var/www/html
    networks:
      - app-net

  web:
    image: nginx:alpine
    container_name: %s-nginx
    restart: unless-stopped
    ports:
      - "8000:80"
    volumes:
      - ./:/var/www/html
      - ./docker/nginx/conf.d:/etc/nginx/conf.d:ro
    depends_on:
      - app
    networks:
      - app-net

  db:
    image: postgres:16-alpine
    container_name: %s-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${DB_DATABASE:-laravel}
      POSTGRES_USER: ${DB_USERNAME:-postgres}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-secret}
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - app-net

  redis:
    image: redis:alpine
    container_name: %s-redis
    restart: unless-stopped
    ports:
      - "6379:6379"
    networks:
      - app-net

volumes:
  db_data:
    driver: local

networks:
  app-net:
    driver: bridge
]], name, name, name, name)
      end,
      ["docker/nginx/conf.d/default.conf"] = [[server {
    listen 80;
    index index.php index.html;
    server_name localhost;
    root /var/www/html/public;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}
]],
      [".dockerignore"] = [[.git
.gitignore
.env
.env.*
vendor
node_modules
npm-debug.log
yarn-error.log
storage/*.key
storage/logs/*
.phpunit.result.cache
.vscode
.idea
]],
    },
  },

  nodejs = {
    name = "Node.js (Express / Fastify / NestJS / Backend)",
    detect = function(root)
      if vim.fn.filereadable(root .. "/package.json") == 1 then
        local content = table.concat(vim.fn.readfile(root .. "/package.json"), " ")
        return not (content:find("react") or content:find("next") or content:find("vue"))
      end
      return false
    end,
    files = {
      ["Dockerfile"] = [[# 1. Base stage
FROM node:20-alpine AS base
WORKDIR /app

# 2. Dependencies stage
FROM base AS deps
COPY package*.json ./
RUN npm ci

# 3. Development / Build stage
FROM base AS runner
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Run as non-root user
USER node

EXPOSE 3000
CMD ["npm", "start"]
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-app
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - PORT=3000
    volumes:
      - ./:/app
      - /app/node_modules
    command: npm run dev
    networks:
      - app-net

networks:
  app-net:
    driver: bridge
]], name)
      end,
      [".dockerignore"] = [[node_modules
npm-debug.log
.git
.gitignore
.env
.env.*
dist
build
coverage
.vscode
.idea
]],
    },
  },

  react_vite = {
    name = "React / Vite / Vue (SPA with Nginx Alpine Multi-stage)",
    detect = function(root)
      if vim.fn.filereadable(root .. "/package.json") == 1 then
        local content = table.concat(vim.fn.readfile(root .. "/package.json"), " ")
        return (content:find("vite") or content:find("react") or content:find("vue")) and not content:find("next")
      end
      return false
    end,
    files = {
      ["Dockerfile"] = [[# 1. Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 2. Production stage (Nginx)
FROM nginx:alpine AS runner
COPY --from=builder /app/dist /usr/share/nginx/html
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
]],
      ["docker/nginx/default.conf"] = [[server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
        try_files $uri $uri/ /index.html;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-spa
    restart: unless-stopped
    ports:
      - "8080:80"
]], name)
      end,
      [".dockerignore"] = [[node_modules
dist
build
.git
.gitignore
.env
.env.*
.vscode
.idea
]],
    },
  },

  nextjs = {
    name = "Next.js (Standalone Multi-stage build)",
    detect = function(root)
      if vim.fn.filereadable(root .. "/package.json") == 1 then
        local content = table.concat(vim.fn.readfile(root .. "/package.json"), " ")
        return content:find("next") ~= nil
      end
      return false
    end,
    files = {
      ["Dockerfile"] = [[# 1. Install dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# 2. Rebuild source code
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# 3. Production runner
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-nextjs
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
]], name)
      end,
      [".dockerignore"] = [[node_modules
.next
.git
.gitignore
.env
.env.*
.vscode
.idea
]],
    },
  },

  python_fastapi = {
    name = "Python (FastAPI / Flask / Django)",
    detect = function(root)
      return vim.fn.filereadable(root .. "/requirements.txt") == 1
        or vim.fn.filereadable(root .. "/pyproject.toml") == 1
    end,
    files = {
      ["Dockerfile"] = [[FROM python:3.12-slim

# Prevent Python from writing .pyc and buffer stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Non-root user for security
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  api:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-api
    restart: unless-stopped
    ports:
      - "8000:8000"
    volumes:
      - ./:/app
    environment:
      - ENVIRONMENT=development
    networks:
      - app-net

networks:
  app-net:
    driver: bridge
]], name)
      end,
      [".dockerignore"] = [[__pycache__
*.pyc
*.pyo
*.pyd
.Python
env
venv
.venv
.git
.gitignore
.env
.env.*
.pytest_cache
.vscode
.idea
]],
    },
  },

  golang = {
    name = "Go (Golang Alpine Multi-stage)",
    detect = function(root)
      return vim.fn.filereadable(root .. "/go.mod") == 1
    end,
    files = {
      ["Dockerfile"] = [[# 1. Builder
FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/server .

# 2. Minimal runtime
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/server .

EXPOSE 8080
CMD ["./server"]
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-go
    restart: unless-stopped
    ports:
      - "8080:8080"
]], name)
      end,
      [".dockerignore"] = [[.git
.gitignore
.env
.env.*
vendor
bin
]],
    },
  },

  rust = {
    name = "Rust (Cargo Alpine Multi-stage)",
    detect = function(root)
      return vim.fn.filereadable(root .. "/Cargo.toml") == 1
    end,
    files = {
      ["Dockerfile"] = [[# 1. Builder
FROM rust:1.80-alpine AS builder
RUN apk add --no-cache musl-dev
WORKDIR /app
COPY . .
RUN cargo build --release

# 2. Runtime
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
# Note: change 'app' to your cargo binary name
COPY --from=builder /app/target/release/app /app/server

EXPOSE 8080
CMD ["/app/server"]
]],
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: %s-rust
    restart: unless-stopped
    ports:
      - "8080:8080"
]], name)
      end,
      [".dockerignore"] = [[target
.git
.gitignore
.env
.env.*
]],
    },
  },

  db_only_postgres = {
    name = "Database Only (PostgreSQL 16 + Redis + pgAdmin)",
    detect = function()
      return false
    end,
    files = {
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  postgres:
    image: postgres:16-alpine
    container_name: %s-postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${DB_DATABASE:-app_db}
      POSTGRES_USER: ${DB_USERNAME:-postgres}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-postgres}
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

  redis:
    image: redis:alpine
    container_name: %s-redis
    restart: unless-stopped
    ports:
      - "6379:6379"

  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: %s-pgadmin
    restart: unless-stopped
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@admin.com
      PGADMIN_DEFAULT_PASSWORD: admin
    ports:
      - "5050:80"
    depends_on:
      - postgres

volumes:
  pgdata:
    driver: local
]], name, name, name)
      end,
    },
  },

  db_only_mysql = {
    name = "Database Only (MySQL 8.0 + phpMyAdmin)",
    detect = function()
      return false
    end,
    files = {
      ["docker-compose.yml"] = function(name)
        return string.format([[services:
  mysql:
    image: mysql:8.0
    container_name: %s-mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD:-root}
      MYSQL_DATABASE: ${DB_DATABASE:-app_db}
      MYSQL_USER: ${DB_USERNAME:-app}
      MYSQL_PASSWORD: ${DB_PASSWORD:-secret}
    ports:
      - "3306:3306"
    volumes:
      - mysqldata:/var/lib/mysql

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: %s-phpmyadmin
    restart: unless-stopped
    environment:
      PMA_HOST: mysql
      PMA_PORT: 3306
    ports:
      - "8081:80"
    depends_on:
      - mysql

volumes:
  mysqldata:
    driver: local
]], name, name)
      end,
    },
  },
}

-- Detect likely project template
function M.detect_template()
  local root = get_project_root()
  for key, tmpl in pairs(M.templates) do
    if tmpl.detect and tmpl.detect(root) then
      return key
    end
  end
  return nil
end

-- Write template files to workspace
function M.apply_template(key)
  local tmpl = M.templates[key]
  if not tmpl then
    vim.notify("Plantilla Docker no encontrada: " .. tostring(key), vim.log.levels.ERROR, { title = "Docker" })
    return
  end

  local root = get_project_root()
  local app_name = get_project_name()
  local created = {}
  local skipped = {}

  for rel_path, content_gen in pairs(tmpl.files) do
    local full_path = root .. "/" .. rel_path
    local content = type(content_gen) == "function" and content_gen(app_name) or content_gen

    if vim.fn.filereadable(full_path) == 1 then
      table.insert(skipped, rel_path)
    else
      -- Create parent directory if needed
      local dir = vim.fn.fnamemodify(full_path, ":h")
      vim.fn.mkdir(dir, "p")

      local f = io.open(full_path, "w")
      if f then
        f:write(content)
        f:close()
        table.insert(created, rel_path)
      end
    end
  end

  local msg = ""
  if #created > 0 then
    msg = msg .. "󰄬 Creados: " .. table.concat(created, ", ") .. "\n"
  end
  if #skipped > 0 then
    msg = msg .. " Omitidos (ya existían): " .. table.concat(skipped, ", ")
  end

  vim.notify(msg, vim.log.levels.INFO, { title = "Docker Scaffold: " .. tmpl.name })

  -- Automatically open Dockerfile or compose file if created
  if vim.tbl_contains(created, "Dockerfile") then
    vim.cmd("edit " .. vim.fn.fnameescape(root .. "/Dockerfile"))
  elseif vim.tbl_contains(created, "docker-compose.yml") then
    vim.cmd("edit " .. vim.fn.fnameescape(root .. "/docker-compose.yml"))
  end
end

-- Interactive scaffold selector
function M.scaffold()
  local detected = M.detect_template()
  local items = {}

  for key, tmpl in pairs(M.templates) do
    local is_rec = (key == detected)
    local prefix = is_rec and "★ (Detectado) " or "  "
    table.insert(items, {
      key = key,
      label = prefix .. tmpl.name,
      recommended = is_rec,
    })
  end

  -- Sort: recommended first, then alphabetically
  table.sort(items, function(a, b)
    if a.recommended ~= b.recommended then
      return a.recommended
    end
    return a.label < b.label
  end)

  vim.ui.select(items, {
    prompt = "Selecciona plantilla Docker para el proyecto:",
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
      M.apply_template(choice.key)
    end
  end)
end

-- Build Docker Image interactively
function M.build_image()
  local root = get_project_root()
  local default_tag = get_project_name() .. ":latest"

  if vim.fn.filereadable(root .. "/Dockerfile") == 0 then
    vim.ui.select({ "Sí, crear plantilla", "No, cancelar" }, {
      prompt = "No se encontró Dockerfile en la raíz del proyecto. ¿Deseas crear uno primero?",
    }, function(choice)
      if choice and choice:find("Sí") then
        M.scaffold()
      end
    end)
    return
  end

  vim.ui.input({
    prompt = "Tag de la imagen Docker: ",
    default = default_tag,
  }, function(tag)
    if not tag or tag == "" then
      return
    end

    local cmd = string.format("docker build -t %s -f %s/Dockerfile %s", tag, root, root)
    if pcall(require, "snacks") then
      Snacks.terminal(cmd, {
        cwd = root,
        win = {
          position = "float",
          border = "rounded",
          width = 0.85,
          height = 0.8,
        },
        auto_close = false,
      })
    else
      vim.cmd("ToggleTerm direction=float")
      vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
    end
  end)
end

-- Open Lazydocker floating terminal
function M.lazydocker()
  if vim.fn.executable("lazydocker") ~= 1 then
    vim.notify(
      "lazydocker no se encuentra en el PATH. Instálalo con 'yay -S lazydocker' o 'curl -s https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash'",
      vim.log.levels.ERROR,
      { title = "Lazydocker" }
    )
    return
  end

  local root = get_project_root()
  if pcall(require, "snacks") then
    Snacks.terminal("lazydocker", {
      cwd = root,
      win = {
        position = "float",
        border = "rounded",
        width = 0.94,
        height = 0.92,
      },
    })
  else
    vim.cmd("ToggleTerm direction=float")
    vim.fn.chansend(vim.b.terminal_job_id, "lazydocker\n")
  end
end

-- Compose actions
function M.compose_up()
  local root = get_project_root()
  vim.notify("Ejecutando 'docker compose up -d'...", vim.log.levels.INFO, { title = "Docker Compose" })
  vim.system({ "docker", "compose", "up", "-d" }, { cwd = root }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify("󰄬 Contenedores levantados con éxito.", vim.log.levels.INFO, { title = "Docker Compose" })
      else
        vim.notify(
          "Error al levantar contenedores:\n" .. (obj.stderr ~= "" and obj.stderr or obj.stdout),
          vim.log.levels.ERROR,
          { title = "Docker Compose" }
        )
      end
    end)
  end)
end

function M.compose_down()
  local root = get_project_root()
  vim.notify("Ejecutando 'docker compose down'...", vim.log.levels.INFO, { title = "Docker Compose" })
  vim.system({ "docker", "compose", "down" }, { cwd = root }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify("󰄬 Contenedores detenidos y eliminados.", vim.log.levels.INFO, { title = "Docker Compose" })
      else
        vim.notify(
          "Error al detener contenedores:\n" .. (obj.stderr ~= "" and obj.stderr or obj.stdout),
          vim.log.levels.ERROR,
          { title = "Docker Compose" }
        )
      end
    end)
  end)
end

function M.compose_restart()
  local root = get_project_root()
  vim.notify("Reiniciando contenedores...", vim.log.levels.INFO, { title = "Docker Compose" })
  vim.system({ "docker", "compose", "restart" }, { cwd = root }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify("󰄬 Contenedores reiniciados.", vim.log.levels.INFO, { title = "Docker Compose" })
      else
        vim.notify("Error al reiniciar:\n" .. obj.stderr, vim.log.levels.ERROR, { title = "Docker Compose" })
      end
    end)
  end)
end

function M.compose_logs()
  local root = get_project_root()
  if pcall(require, "snacks") then
    Snacks.terminal("docker compose logs -f --tail=100", {
      cwd = root,
      win = {
        position = "float",
        border = "rounded",
        width = 0.9,
        height = 0.85,
      },
      auto_close = false,
    })
  end
end

function M.system_prune()
  vim.ui.select({ "Sí, limpiar contenedores e imágenes huérfanas", "Cancelar" }, {
    prompt = "¿Deseas ejecutar 'docker system prune -f'?",
  }, function(choice)
    if choice and choice:find("Sí") then
      vim.system({ "docker", "system", "prune", "-f" }, {}, function(obj)
        vim.schedule(function()
          if obj.code == 0 then
            vim.notify("󰄬 Sistema Docker limpiado:\n" .. obj.stdout, vim.log.levels.INFO, { title = "Docker Prune" })
          else
            vim.notify("Error en docker prune:\n" .. obj.stderr, vim.log.levels.ERROR, { title = "Docker Prune" })
          end
        end)
      end)
    end
  end)
end

-- Interactive Docker Action Hub
function M.menu()
  local actions = {
    { label = "󰡨  Abrir Lazydocker (Dashboard TUI)", fn = M.lazydocker },
    { label = "📦  Crear / Generar Plantilla Docker (Scaffold)", fn = M.scaffold },
    { label = "🔨  Construir Imagen Docker (Build)", fn = M.build_image },
    { label = "🚀  Docker Compose Up (-d)", fn = M.compose_up },
    { label = "🛑  Docker Compose Down", fn = M.compose_down },
    { label = "🔄  Docker Compose Restart", fn = M.compose_restart },
    { label = "📜  Docker Compose Logs (Live stream)", fn = M.compose_logs },
    { label = "🧹  Docker System Prune (Limpiar espacio)", fn = M.system_prune },
  }

  vim.ui.select(actions, {
    prompt = "🐳 Menú de Docker / Contenedores:",
    format_item = function(item)
      return item.label
    end,
  }, function(selected)
    if selected and selected.fn then
      selected.fn()
    end
  end)
end

return M
