FROM jrottenberg/ffmpeg:3.3


ARG TAG=0.3.1
ARG FILE_NAME=sorry-gen.tar.gz
ARG DL_ADDRESS="https://github.com/Hentioe/sorry-generator/releases/download/$TAG/$FILE_NAME"
ARG REMOTE_RES=https://dl.bluerain.io/res.zip
ARG DIST_DIR=/data/dist


WORKDIR /data


RUN apt-get install -y wget ttf-wqy-microhei \
    && mkdir -p $DIST_DIR \
    && wget $DL_ADDRESS -O "/data/$FILE_NAME" \
    && (cd /data && tar -zxvf $FILE_NAME) \
    && ln -s /data/sorry-gen /usr/bin/sorry-gen \
    && rm "/data/$FILE_NAME" \
    && apt-get purge -y wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/apt/lists/partial/*


EXPOSE 8080


ENTRYPOINT ["sorry-gen"]
