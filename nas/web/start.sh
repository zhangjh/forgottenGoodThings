#!/bin/bash
## 每次需要重启docker时运行，参数传递docker service名，如mongo、favlinks、comment、blog
docker-compose pull $1
docker-compose up -d $1
