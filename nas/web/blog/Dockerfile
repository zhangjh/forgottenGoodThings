FROM njhxzhangjh/web_base:1.0
WORKDIR ./

## hello-blog
RUN git clone git@github.com:zhangjh/hello-blog.git /root/web/hello-blog && chmod -R 777 /root/web/hello-blog
RUN cd /root/web/hello-blog && npm i && npm run start 
