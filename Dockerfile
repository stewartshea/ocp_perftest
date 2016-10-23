##OCP Infrastucture Performance Benchmark Container
##Thanks to https://github.com/t0t0/docker-phoronix for the initial work
#Base Image
FROM    alpine:3.4

# File Author / Maintainer
MAINTAINER info@arctiq.ca shea.stewart@arctiq.ca


#Add repositories
RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories;
RUN apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository  http://dl-cdn.alpinelinux.org/alpine/edge/community  docker

# Use dl-4, as the main repo is down (23.08.2016)
RUN apk add --no-cache nodejs make gcc g++ libtool linux-headers

RUN apk add --no-cache perl pcre-dev php5 php-dom php-zip php-json


# Install dependencies
#RUN apk update && apk add --no-cache make gcc g++ libtool linux-headers perl pcre-dev php php-dom php-zip php-json

# Download  & extract Phoronix package
RUN wget http://www.phoronix-test-suite.com/download.php?file=phoronix-test-suite-6.6.1 -O phoronix-test-suite-6.6.1.tar.gz
RUN tar xzf phoronix-test-suite-6.6.1.tar.gz
RUN rm -f phoronix-test-suite-6.6.1.tar.gz
RUN cd phoronix-test-suite && ./install-sh

# Install tests
## Disk
RUN phoronix-test-suite install pts/iozone
## CPU
#RUN phoronix-test-suite install pts/c-ray
## Memory
#RUN phoronix-test-suite install pts/stream
## Services
#RUN phoronix-test-suite install pts/apache
#RUN phoronix-test-suite install pts/redis


# Copy custom scripts
COPY scripts/ .

# Check working directory
CMD chmod +x run.sh

# Execute benchmark script
#ENTRYPOINT ["sh", "run.sh"]
ENTRYPOINT ["phoronix-test-suite"]
EXPOSE 80
