FROM ubuntu
#Installing necessary softwares
RUN apt update -y
RUN apt install wget -y
#Configuring Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.21.0-rc.0/prometheus-2.21.0-rc.0.linux-amd64.tar.gz
RUN tar -xzf prometheus-2.21.0-rc.0.linux-amd64.tar.gz
RUN mv prometheus-2.21.0-rc.0.linux-amd64 prometheus
RUN mv prometheus /etc/
#Start the prometheus server
CMD /etc/prometheus/./prometheus 
--config.file=/etc/prometheus/prometheus.yml 
--storage.tsdb.path=/prometheus && tail -f /dev/null
