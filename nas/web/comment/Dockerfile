FROM njhxzhangjh/web_base:1.0
WORKDIR ./

## comment
RUN git clone git@github.com:zhangjh/comment.git /root/web/comment && chmod -R 777 /root/web/comment
RUN cd /root/web/comment && npm i && npm run start &
