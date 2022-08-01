FROM centos:latest
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install openssh-server  -y
RUN yum install passwd -y
RUN useradd tayyab && \
	echo "Mcse2012" | passwd tayyab --stdin
RUN mkdir /home/tayyab/.ssh
COPY container-key /home/tayyab/.ssh/authorized_keys
RUN chown -R tayyab:tayyab /home/tayyab && \
	chmod 400 /home/tayyab/.ssh/authorized_keys
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "root:Mcse2012" | chpasswd
RUN ssh-keygen -A
CMD ["/usr/sbin/sshd", "-D" ]
