FROM node:8.9.4-alpine

# -----------------------------------
# Environment variables
# -----------------------------------
ENV HUBOT_USER hubot
ENV HUBOT_NAME hubot
ENV HUBOT_SLACK_TOKEN false

# add non-privileges user
RUN adduser -D -h /opt/$HUBOT_USER $HUBOT_USER

# pre-install
ADD build/ /opt/hubot
WORKDIR /opt/hubot
RUN chown -R hubot:hubot *

USER $HUBOT_USER

# install
RUN npm install --production

EXPOSE 8080
VOLUME /opt/$HUBOT_USER/scripts
ENTRYPOINT [ "bin/hubot" ]
CMD [ "--name", "${HUBOT_NAME}", "--adapter", "slack" ]
