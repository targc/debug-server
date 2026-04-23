# debug-server

Simple HTTP server that responds with the status code from the URL path.

## Usage

```
GET /:statusCode
```

Returns `{"status": <statusCode>}` with that HTTP status code.

## Install & Run (Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/targc/debug-server/refs/heads/main/run-background.sh | sudo bash
```

Installs bun, clones the repo to `/opt/debug-server`, and sets up a systemd service that starts on boot.
