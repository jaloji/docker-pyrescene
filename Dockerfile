#Error in setup.py install pyrescene with python version > 3.9 and alpine > 3.15 use python > 3.9
#Unrar deleted in alpine > 3.14 we need to compile it

FROM alpine:3.15

RUN apk update && apk add --no-cache python3 unzip wget ca-certificates py3-setuptools chromaprint build-base zlib-dev \
  && mkdir /app

WORKDIR /app

# Download, install pyrescene, build unrar, and clean up build dependencies
RUN wget https://github.com/srrDB/pyrescene/archive/refs/heads/master.zip && \
    unzip master.zip && \
    cd pyrescene-master && \
	python3 setup.py install && \
	cd .. && \
    rm -rf master.zip pyrescene-master && \
    wget https://www.rarlab.com/rar/unrarsrc-7.1.2.tar.gz && \
    tar xzf unrarsrc-7.1.2.tar.gz && \
    cd unrar && \
    make && \
    make install && \
    cd .. && \
    # Clean up build dependencies \
    apk del --purge build-base zlib-dev && \
    rm -rf /var/cache/apk/* /app/unrarsrc-7.1.2.tar.gz /app/unrar

# Create user
ENV UID=1000
ENV GID=1000

RUN addgroup -S appgroup -g "$GID" && adduser -S app -G appgroup -u "$UID"

RUN mkdir -p /scan /srr
WORKDIR /scan/
# Run as user
USER app

# Do this
CMD pyrescene.py --best -yro /srr /scan/
