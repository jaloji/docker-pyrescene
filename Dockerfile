FROM alpine:3.14

RUN apk update
RUN apk add --no-cache python3 unrar unzip wget ca-certificates py3-setuptools chromaprint

# Leech pyrescene
RUN mkdir /app
WORKDIR /app
RUN wget https://github.com/srrDB/pyrescene/archive/refs/heads/master.zip
RUN unzip master.zip
RUN cd pyrescene-master && python3 setup.py install

# Cleanup
RUN rm -R master.zip pyrescene-master

# Create user
ENV UID=1000
ENV GID=1000

RUN addgroup -S appgroup && adduser -S app -G appgroup

RUN mkdir -p /scan /srr
WORKDIR /scan/
# Run as user
USER app

# Do this
CMD pyrescene.py --recursive --output=/srr /scan/