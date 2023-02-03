# Base stage
# ---------------------------------------
FROM node:18-bullseye-slim AS base

# This get shared across later stages
WORKDIR /node
RUN chown node:node /node
USER node

# Development stage
# ---------------------------------------
FROM base AS development

USER root
RUN \
  apt-get -yq update && \
  apt-get -yq install curl 
USER node
RUN echo 'alias ll="ls -als"' >> ~/.profile

ENV NODE_ENV=development
ENV SHOW_DOCS=true
ENV SERVER_PORT=3000
ENV PATH /node/node_modules/.bin:$PATH
EXPOSE $SERVER_PORT 9229

COPY --chown=node:node package*.json ./
RUN \
  npm ci

# WORKDIR /node/app

CMD ["node", "--watch", "--inspect=0.0.0.0:9229", "app/server.js" ]

# Test stage
# ---------------------------------------
FROM base AS test

ENV NODE_ENV=development
ENV SERVER_PORT=3000

COPY --chown=node:node package*.json ./

RUN \
  npm ci --no-optional

COPY --chown=node:node ./__tests__ ./__tests__
COPY --chown=node:node ./app ./app

RUN \
  npm run test

# Production stage
# ---------------------------------------
FROM base as preproduction

ENV NODE_ENV=production
ENV SERVER_PORT=3000

COPY --chown=node:node package*.json ./

RUN \
  npm ci --no-optional --production

COPY --chown=node:node ./app ./app

# ---------------------------------------
FROM gcr.io/distroless/nodejs:18 as production

WORKDIR /node

ENV NODE_ENV=production
ENV SERVER_PORT=3000

COPY --from=preproduction /node/node_modules ./node_modules
COPY --from=preproduction /node/app .
COPY --from=preproduction /node/package.json .

EXPOSE $SERVER_PORT

CMD ["server.js" ]