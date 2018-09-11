FROM node:latest

MAINTAINER Nick Engmann <cyengmann@gmail.com>

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# create workspace directory
WORKDIR /workspace

# copy package.json and package-lock.json
COPY package*.json /workspace/

# copy everything in directory to workspace directory
COPY . /workspace/

# add packages
RUN yarn add package.json

# expose port 3000 so we can see our beautiful application 🎉
EXPOSE 3000

CMD ["yarn","web"]
#CMD ["yarn","server"]