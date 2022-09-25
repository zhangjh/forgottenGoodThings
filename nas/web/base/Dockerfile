FROM ubuntu
WORKDIR ./

SHELL ["/bin/bash", "-c", "-i"]
RUN apt-get update && apt-get install bash vim wget curl git -y
RUN git clone http://github.com/creationix/nvm.git /root/.nvm && chmod -R 777 /root/.nvm/
RUN /root/.nvm/install.sh && . /root/.bashrc && nvm install v10.24.1
RUN npm i hexo gulp -g

#RUN mkdir /root/.ssh/
# 宿主机ssh
#COPY ssh/* /root/.ssh/
#RUN chmod 600 /root/.ssh/*
#RUN echo "Host remotehost\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
