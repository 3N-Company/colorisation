#FROM python:3.8
#
#ADD . .
#
#WORKDIR .
#RUN apt-get update && apt-get install -y ca-certificates wget
##RUN pip install --no-cache-dir -r requirements.txt
#RUN wget https://colorizers.s3.us-east-2.amazonaws.com/colorization_release_v2-9b330a0b.pth -o colorization_release_v2-9b330a0b.pth
#EXPOSE 2020
#
#RUN mkdir -p /imgs/colorised
##RUN
#
##CMD ["gunicorn", "-w", "1","-b","0.0.0.0:2020", "demo_release:app" , "--timeout", "180"]


FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && apt-get --yes install git \
  && apt-get --yes install wget



ADD . .

WORKDIR /
RUN mkdir -p /imgs/colorised

RUN wget https://colorizers.s3.us-east-2.amazonaws.com/colorization_release_v2-9b330a0b.pth -O colorization_release_v2-9b330a0b.pth
EXPOSE 2020

RUN pip install --no-cache-dir -r requirements.txt

CMD ["gunicorn", "-w", "1","-b","0.0.0.0:2020", "demo_release:app" , "--timeout", "180"]
#- '-c'
#- |
