To run from docker index:

```shell
First run:
docker run -d \
            --name fixate_mongodb \
             -p 27017 -p 28017 \
             -v="/var/mongodb/data:/var/mongodb/data:rw" \
              -d "fixate/mongodb:0.0.3"
# Start up:
docker start fixate_mongodb
# Get the IP:
IP=`$(docker inspect -format='{{ .NetworkSettings.IPAddress }}' $CONTAINER )
```
