# Etape 1: Construire l'application Angular
FROM node:latest as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build

# Etape 2: Servir l'application avec Nginx
FROM nginx:alpine


# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/app/dist/data-visualisation /usr/share/nginx/html