# BigBoat Dashboard UI

A Dashboard UI for the BigBoat ecosystem

## Development

### Run development server

`npm start`

### Build Dockerfile

Before you can create a Docker image you first need to create a minified version of the application.
The following will create a bundle in the build folder:

`npm run build`

After that you can create a Docker image.

`docker build -t bigboat-ui .`

Run the resulting image.

`docker run --rm --name bigboat-ui -p 8080:80 bigboat-ui`