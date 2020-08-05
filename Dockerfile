FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#/app/build <-- stuff we care about

#Let us now start the second phase for the running
#Blocks end at the start of a next FROM statement
#We need not explicitly stop the previous block
FROM nginx
EXPOSE 80
#copy from the builder phase, the folder you want to copy and where
COPY --from=builder /app/build /usr/share/nginx/html

