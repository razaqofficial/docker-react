# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
FROM node:alpine as build-stage

# set up work directory
WORKDIR '/app'

# install dependency and build project
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx
EXPOSE 80
COPY --from=build-stage /app/build /usr/share/nginx/html

