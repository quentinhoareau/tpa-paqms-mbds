FROM node:latest

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
COPY . .
EXPOSE 5004

RUN npx prisma generate
CMD [ "npm", "run", "start" ]