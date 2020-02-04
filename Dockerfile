FROM alpine

RUN apk -Uuv add --no-cache curl ca-certificates bash

ADD script.sh /bin/script.sh
ADD basic_card.json /tmp

RUN chmod +x /bin/script.sh

ENTRYPOINT /bin/script.sh
