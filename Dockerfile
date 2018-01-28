FROM alpine

WORKDIR /tmp

ENV source_url http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz

RUN apk update && \
  apk add build-base
RUN wget ${source_url}
RUN tar xzf udpxy* && \
  rm -f *.tar.gz && \
  cd udpxy* && \
  make && \
  make install

WORKDIR /tmp
RUN rm -rf udpxy* && \
  apk del build-base

ENTRYPOINT ["/usr/local/bin/udpxy", "-B", "2M", "-p", "1234"]

EXPOSE 1234
