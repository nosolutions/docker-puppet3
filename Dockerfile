FROM centos:7.3.1611
MAINTAINER Toni Schmidbauer <toni@stderr.at>

COPY puppetlabs-release-el-7.noarch.rpm /tmp/

RUN yum -y -q localinstall /tmp/puppetlabs-release-el-7.noarch.rpm \
 && yum -y -q install puppet ruby-devel make gcc git \
 && yum clean all

COPY Gemfile /tmp/

RUN gem install --no-ri --no-rdoc bundler \
 && cd /tmp && bundle install --system

RUN useradd -u 1000 vagrant

USER vagrant

RUN git clone https://github.com/garethr/puppet-module-skeleton /tmp/skeleton \
 && cd /tmp/skeleton \
 && ./install.sh
