FROM python:3.12-slim

ARG PORT=8050

WORKDIR /app

# Install uv
RUN pip install uv

# Copy only the files needed for installation first
COPY pyproject.toml uv.lock ./

# Install dependencies from lockfile
RUN python -m venv .venv && \
    uv pip sync --frozen

# Now copy the rest of the application
COPY . .

# Expose the port for SSE transport
EXPOSE ${PORT}

# Command to run the MCP server
CMD ["uv", "run", "--frozen", "src/solscan_mcp_server/server.py"] 