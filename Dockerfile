FROM centos:7.3.1611
MAINTAINER Toni Schmidbauer <toni@stderr.at>

COPY puppetlabs-release-el-7.noarch.rpm /tmp/

RUN yum -y localinstall /tmp/puppetlabs-release-el-7.noarch.rpm \
 && yum -y install puppet ruby-devel make gcc

COPY Gemfile /tmp/

RUN gem install --no-ri --no-rdoc bundler \
 && cd /tmp && bundle install --system 

RUN useradd -u 1000 vagrant

USER vagrant
