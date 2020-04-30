FROM node:alpine
#start build step
WORKDIR '/app'
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build
#end build step /app/build working dir
#start prod step
FROM nginx
EXPOSE 80
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html
#stop prod step