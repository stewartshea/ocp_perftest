##OCP Infrastucture Performance Benchmark Container
##Thanks to https://github.com/t0t0/docker-phoronix for the initial work
#Base Image
FROM    alpine:3.4

# File Author / Maintainer
MAINTAINER info@arctiq.ca shea.stewart@arctiq.ca


#Add repositories
RUN apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository  http://dl-cdn.alpinelinux.org/alpine/edge/community  docker

#Install deps
RUN apk add --no-cache nodejs make gcc g++ libtool linux-headers perl pcre-dev php5 php5-sockets php5-gd php5-dom php5-zip php5-json php5-sqlite3

RUN apk add --no-cache python autoconf
RUN apk add --no-cache popt libaio


# Download  & extract Phoronix package
RUN wget http://www.phoronix-test-suite.com/download.php?file=phoronix-test-suite-6.6.1 -O phoronix-test-suite-6.6.1.tar.gz
RUN tar xzf phoronix-test-suite-6.6.1.tar.gz
RUN rm -f phoronix-test-suite-6.6.1.tar.gz
RUN cd phoronix-test-suite && ./install-sh

# Install tests
## Disk
RUN phoronix-test-suite install pts/iozone
RUN phoronix-test-suite install pts/disk
## CPU
#RUN phoronix-test-suite install pts/c-ray
## Memory
#RUN phoronix-test-suite install pts/stream
## Services
#RUN phoronix-test-suite install pts/apache
#RUN phoronix-test-suite install pts/redis


# Copy custom scripts
COPY scripts/ .

#Copy Phoronix Config Files
COPY config/phoronix-test-suite.xml /etc/

# Check working directory
CMD chmod +x run.sh

# Execute benchmark script
ENTRYPOINT ["sh", "run.sh"]
EXPOSE 80
