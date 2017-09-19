FROM node:6

RUN mkdir -p /srv/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /srv/app/
RUN npm install

# Bundle app source
COPY . /srv/app

EXPOSE 8080
CMD [ "npm", "start" ]