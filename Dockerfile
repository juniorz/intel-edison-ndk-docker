FROM ubuntu:trusty

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# From http://www.intel.com/support/edison/sb/CS-035382.htm
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    make automake gcc g++ build-essential gcc-multilib \
    # This is missing from the documentation
    python

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl unzip

# More download options at
# https://software.intel.com/en-us/iot/hardware/edison/downloads
RUN cd /tmp &&\
    curl -vvv http://downloadmirror.intel.com/25028/eng/edison-sdk-linux64-ww25.5-15.zip -O &&\
    echo "12ebb61e77eb0a2c330296380c5a4d9dceace322 *edison-sdk-linux64-ww25.5-15.zip" \
      | shasum -c &&\
    unzip edison-sdk-linux64-ww25.5-15.zip &&\
    /tmp/poky-edison-glibc-x86_64-edison-image-core2-32-toolchain-1.7.2.sh -d /edison-sdk -y

ENV PREFIX="/opt/edison"
VOLUME /opt/edison

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

