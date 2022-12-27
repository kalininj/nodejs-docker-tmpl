# Dockerised Node.js template with typescript support

This is a set of good defaults and best practices when working with Node.js and Docker.

* Proper shutdown - Graceful shutdown of Node.js using [stoppable](https://github.com/hunterloftis/stoppable).
* Security - Node runs as the user `node` rather than `root`.
* Multi stage builds - Single Dockerfile for dev/test and prod images.
* Testability - Separate test image for testing in a CI environment.

## Getting started

1. Clone this repo
2. Run `make build-dev` followed by `make start` to build and run the application
3. Visit http://localhost:3000 in your browser

## License

[MIT](LICENSE)
