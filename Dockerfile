# Stage 1: Build Angular app
FROM node:14 as builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# Stage 2: Setup Nginx
FROM nginx:alpine

# Setup Nginx
COPY --from=builder /app/app /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
