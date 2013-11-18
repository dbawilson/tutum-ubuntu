FROM ubuntu:quantal
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server && mkdir -p /var/run/sshd && echo 'root:changeme' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]