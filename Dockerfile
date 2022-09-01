from alpine

ADD . /var/dev/
WORKDIR /var/dev/
RUN apk add --no-cache wget \
    && wget https://github.com/tindy2013/subconverter/releases/download/v0.6.4/subconverter_linux64.tar.gz \
    && tar -zxvf subconverter_linux64.tar.gz

ENTRYPOINT ["./subconverter/subconverter"]