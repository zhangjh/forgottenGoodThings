FROM njhxzhangjh/web_base:1.0
WORKDIR ./

##favlink
RUN git clone git@github.com:zhangjh/favlinks.git /root/web/favlinks && chmod -R 777 /root/web/favlinks
COPY ./conf/ /root/web/favlinks/conf
RUN ls -al /root/web/favlinks
RUN cd /root/web/favlinks && npm i && npm run start &
