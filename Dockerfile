FROM node:16-alpine AS build

# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./app/package*.json ./

#RUN npm install
# If you are building your code for production
RUN npm ci --only=production

# Bundle app source
COPY ./app ./


FROM node:16-alpine
USER node
WORKDIR /app
COPY --from=build /app /app

EXPOSE 3000
CMD [ "node", "app.js" ]
