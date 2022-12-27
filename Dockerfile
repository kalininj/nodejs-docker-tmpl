# Base stage
# ---------------------------------------
FROM node:16.15.0-alpine AS base

# This get shared across later stages
WORKDIR /node
RUN chown node:node /node
USER node

# Development stage
# ---------------------------------------
FROM base AS development

USER root
RUN \
  apk add curl 
USER node
RUN echo 'alias ll="ls -als"' >> ~/.profile

ENV NODE_ENV=development
ENV alias ll="ls -als"
ENV SERVER_PORT=3000
ENV PATH /node/node_modules/.bin:$PATH
EXPOSE $SERVER_PORT 9229

COPY --chown=node:node package*.json ./
RUN \
  npm ci

WORKDIR /node/app  

CMD ["npx", "nodemon", "bin/www" ]

# Test stage
# ---------------------------------------
FROM base AS test

ENV NODE_ENV=development
ENV SERVER_PORT=3000

COPY --chown=node:node package*.json ./

RUN \
  npm ci --no-optional && \
  npm cache clean --force

COPY --chown=node:node . .

# RUN \
#   npm run test && \
#   npm run lint

# Production stage
# ---------------------------------------
FROM base AS production

ENV NODE_ENV=production
ENV SERVER_PORT=3000

COPY --chown=node:node package*.json ./

RUN \
  npm ci --no-optional && \
  npm cache clean --force

COPY --chown=node:node ./src ./src  
COPY --chown=node:node ./bin ./bin  

EXPOSE $SERVER_PORT

CMD [ "node", "./bin/www" ]
