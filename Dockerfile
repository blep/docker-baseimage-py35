# docker build -tpy35 py35
# docker run py35 dpkg --get-selections | grep -v deinstall > packages.txt
# 
# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
# See https://github.com/phusion/baseimage-docker for more details
FROM phusion/baseimage:0.9.19

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install python 3.5
# baseimage-docker already come with python 3.5.1+, doesn't seem to be upgradable to 3.5.2 using apt-get...
# install pytest
# python3-pip not found if no update
#RUN apt-get update

# install pip using get-pip.py (smallest image: 225MB -> 237MB)
# https://bootstrap.pypa.io/get-pip.py
COPY get-pip.py /tmp/get-pip.py
RUN python3 /tmp/get-pip.py

## ALTERNATIVE get pip: => 535MB

# why does python3-pip depends on g++ ???
# image size goes from 225MB to 535MB!
# => install setuptools then pip via setuptools to minimize image size
# RUN apt-get install -qy python3-pip

## ALTERNATIVE get pip: => 274.8MB

# python3-setuptools: 225MB -> 266.7MB
#RUN apt-get install -y python3-setuptools
# easy_install3 pip: 266.7MB -> 272.9MB
#RUN easy_install3 pip

# install common python dependencies
# pip3 install pytest==3.0.2: 272.9MB -> 274.8MB
#RUN pip3 install pytest==3.0.2

## ALTERNATIVE get pip

RUN pip install pytest==3.0.2


# RUN apt-get install clang-3.8

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

