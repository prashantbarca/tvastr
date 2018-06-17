#FROM ubuntu:16.04
FROM ruby:2.5
# get necessary packages
RUN apt-get update && apt-get install -y git build-essential scons swig python-dev python-pip

#install hammer libraries 
RUN git clone https://github.com/UpstandingHackers/hammer/ /home/hammer
RUN cd /home/hammer && scons install
RUN cd /home/hammer && scons install bindings=python
ADD . /home/tvastr
RUN cd /home/tvastr && bundle install  && gem build tvastr.gemspec && gem install tvastr-0.1.0.gem

ENTRYPOINT bash
