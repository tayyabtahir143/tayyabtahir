FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y postfix rsyslog && postconf -e relayhost=tayyabtahir-com.mail.protection.outlook.com && postconf -e mynetworks="127.0.0.0/8 192.168.0.0/16 10.0.0.0/8 172.16.0.0/12 122.129.80.16/29"



EXPOSE 25



CMD ["sh", "-c", "service rsyslog start ; service postfix start ; tail -F /var/log/mail.log"]
