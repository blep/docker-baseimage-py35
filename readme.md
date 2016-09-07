# phusion/baseimage with python 3.5 pip/pytest

This image is based on phusion/baseimage. It already has python 3.5.1, but it is missing pip...

It provides:
- Python pip
- Python pytest

# Installing pip...

The current Dockerfile use get-pip.py as it was found to be the solution with the smallest footprint (Image size went from 225MB to 237MB).


# Alternative solution tried to install pip

## apt-get python3-pip

```
RUN apt-get install -qy python3-pip
```

Image size goes from 225MB to 535MB! Drags g++ and many other huge dependencies (this propably avoid tones of stackoverflow question, but having a -minimal package would have been nice)

## apt-get python3-setuptools + easy_install3 pip

```
RUN apt-get install -y python3-setuptools
```
Image size goes from 225MB -> 266.7MB

```
RUN easy_install3 pip
```
Image size goes from 266.7MB -> 272.9MB
