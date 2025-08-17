# syntax=docker/dockerfile:1

# Use slim Python base
FROM python:3.11-slim AS base

# Install curl (needed for uv installation)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install uv (fast Python package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Create app directory
WORKDIR /app

# Copy dependency file (pyproject.toml + uv.lock if exists)
COPY pyproject.toml ./
COPY uv.lock* ./

# Install dependencies (no dev deps, no cache)
RUN uv sync --no-dev --frozen

# Copy app code
COPY . .

# Expose FastAPI port
EXPOSE 8080

# Run using uv + uvicorn
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
