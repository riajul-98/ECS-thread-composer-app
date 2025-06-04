FROM node:24-alpine AS build

WORKDIR /app

COPY ./ECS-app/ .

RUN yarn install && yarn build

FROM node:24-alpine

WORKDIR /app

COPY --from=build /app/build ./build

RUN yarn global add serve

EXPOSE 3000

CMD [ "serve", "-s", "build" ]