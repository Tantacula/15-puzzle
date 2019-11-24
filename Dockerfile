FROM node:lts-alpine
RUN mkdir -p /nuxt-app
WORKDIR /nuxt-app
COPY . /nuxt-app
RUN npm install \
    && npm run build
EXPOSE 3000
ENV NUXT_PORT=3000
ENV NUXT_HOST=0.0.0.0
CMD ["npm", "start"]