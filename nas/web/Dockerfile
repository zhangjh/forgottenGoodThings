FROM ubuntu
WORKDIR ./

SHELL ["/bin/bash", "-c", "-i"]
RUN apt-get update && apt-get install bash vim wget curl -y && apt-get -y install git
RUN git clone http://github.com/creationix/nvm.git /root/.nvm && chmod -R 777 /root/.nvm/
RUN /root/.nvm/install.sh && . /root/.bashrc && nvm install v10.24.1
RUN npm i hexo gulp -g

RUN mkdir /root/.ssh/
# 宿主机ssh
COPY ssh/* /root/.ssh/
RUN ls -al /root/.ssh
RUN chmod 600 /root/.ssh/* && chmod 644 /root/.ssh/id_rsa.pub
RUN echo "Host remotehost\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

##favlink
RUN git clone git@github.com:zhangjh/favlinks.git /root/web/favlinks && chmod -R 777 /root/web/favlinks
#RUN cd /root/web/favlinks && npm i && npm run start &

## comment
RUN git clone git@github.com:zhangjh/comment.git /root/web/comment && chmod -R 777 /root/web/comment
RUN cd /root/web/comment && npm i && npm run start &

## hello-blog
RUN git clone git@github.com:zhangjh/hello-blog.git /root/web/hello-blog && chmod -R 777 /root/web/hello-blog
RUN cd /root/web/hello-blog && npm i && npm run start 
