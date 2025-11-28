# HTMIN

A “framework in a box” based on [htmx](https://htmx.org/) and [NGINX](https://nginx.org/), all batteries included. The framework aims to provide a minimal and efficient way to create modern web applications with minimal overhead and no setup required.

## Features
- **Dynamic Content Loading:** htmx to easily fetch and update parts of the web page without full page reloads.
- **Lightweight Configuration:** Comprehensive NGINX setup for serving static files and handling requests.
- **Minimal Dependencies:** [Tailwind CSS](https://tailwindcss.com/) and [Alpine.js](https://alpinejs.dev/) for rapid UI development.
- **Included CI/CD:** Opinionated integration and deployment scripts that guarantee consistent and reliable updates, and best performance in production (unimplemented!).

## Usage

> [!NOTE]
> The docker image is not publicly hosted yet. You will have to build it yourself.

WIP but usable for experimentation as is. Run a container and mount your files in NGINX´s default root directory:
```shell
docker run -p <YOUR_PORT>:80 -v .:/usr/share/nginx/html:ro dGilli/htmin
```

See the `example/` directory for an quick starter and more usage guidelines.

## Building the image

Checkout the makefile or run `make help` for all predefined commands.

## Testing

[Playwright](https://playwright.dev/) is used to run End-to-end tests and guarantee behaviour. Run `make test` to execute all tests.

If you want the example app to keep running after tests complete (for development), run:
```
make test keep_alive=true
```

