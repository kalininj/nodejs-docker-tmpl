# Dockerised Node.js template with typescript support

This is a set of good defaults and best practices when working with Node.js and Docker.

* Multi stage builds - Single Dockerfile for dev/test and prod images.
* bullseye slim 18 for dev, distroless 18 for prod
* setup for vscode debug and chrome inspect
* openAPI(in yaml) for validating endpoints input params and responses
* e2e testing setup, docker test build
* docker comands setup in make file
* Testability - Separate test image for testing in a CI environment.

## Getting started

1. Clone this repo
2. Run `make dev-start-log` to build and run the application
3. Visit http://localhost:3000 in your browser

## License

[MIT](LICENSE)
