FROM cirrusci/flutter:stable

COPY . /app
WORKDIR /app
RUN [ "flutter", "pub", "get" ]
CMD [ "flutter", "run" ]
