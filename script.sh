#!/bin/bash

if [ -z ${PLUGIN_WEBHOOK+x} ]; then
    if [ -z ${TEAMS_WEBHOOK+x} ]; then
        echo "Need to set teams_webhook URL"
        exit 1
    else
        WEBHOOK="$TEAMS_WEBHOOK"
    fi
else
    WEBHOOK="$PLUGIN_WEBHOOK"
fi

if [ "$DRONE_TAG" = "" ]; then
    PROJECT_VERSION="$DRONE_COMMIT_SHA"
else
    PROJECT_VERSION="$DRONE_TAG"
fi
DATE='+%d.%m.%Y %H:%M'
datestr=$(date --date=@${DRONE_BUILD_FINISHED} "${DATE}")

cp /tmp/basic_card.json /tmp/card_to_send.json
sed -i "s/TEMPLATE_BUILD_URL/${DRONE_BUILD_LINK//\//\\/}/" /tmp/card_to_send.json
sed -i "s;TEMPLATE_PROJECT_NAME;${DRONE_REPO};" /tmp/card_to_send.json
sed -i "s;TEMPLATE_PROJECT_BRANCH;${DRONE_BRANCH};" /tmp/card_to_send.json
sed -i "s/TEMPLATE_PROJECT_VERSION/${PROJECT_VERSION}/" /tmp/card_to_send.json
COMMIT_MSG_ESCAPED=$(echo ${DRONE_COMMIT_MESSAGE} |sed "s/;/\;/g")
sed -i "s;TEMPLATE_COMMIT_MESSAGE;${COMMIT_MSG_ESCAPED};" /tmp/card_to_send.json

sed -i "s;TEMPLATE_COMMIT_URL;${DRONE_COMMIT_LINK};" /tmp/card_to_send.json

sed -i "s/TEMPLATE_AUTHOR/${DRONE_COMMIT_AUTHOR}/" /tmp/card_to_send.json
sed -i "s/TEMPLATE_FULLNAME/${DRONE_COMMIT_AUTHOR_NAME}/" /tmp/card_to_send.json
sed -i "s/TEMPLATE_FINISHED/${datestr}/" /tmp/card_to_send.json
sed -i "s;TEMPLATE_IMAGE_AUTHOR;${DRONE_COMMIT_AUTHOR_AVATAR};" /tmp/card_to_send.json

if [ "$DRONE_BUILD_STATUS" = "failure" ]
then
    sed -i 's/TEMPLATE_STATUS_ICON/\&#x274C; Failed /' /tmp/card_to_send.json
    sed -i 's/TEMPLATE_COLOR/c60000/' /tmp/card_to_send.json
else
    sed -i 's/TEMPLATE_STATUS_ICON/\&#x2714; Successful /' /tmp/card_to_send.json
    sed -i 's/TEMPLATE_COLOR/00c61e/' /tmp/card_to_send.json

fi

sed -i "s/TEMPLATE_TITLE/$PLUGIN_TITLE/" /tmp/card_to_send.json


cat /tmp/card_to_send.json



curl -H "Content-Type: application/json" -X POST -d @/tmp/card_to_send.json "$WEBHOOK"
