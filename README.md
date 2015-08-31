# Experimental Docker Container for the Linked Data Platform Javascript
implimentation

Dockerfile provisions mongodb and [LDPjs](https://github.com/spadgett/LDPjs)
based on the phusion/baseimage so mongodb can run as a service on the same
container.

Example from IBM devworks of how to use the [Linked Data Platform](http://www.ibm.com/developerworks/library/wa-data-integration-at-scale-OSLC-and-the-linked-data-platform/index.html)

The W3C specification can be found [here](http://www.w3.org/TR/ldp/)

To build:

```shell
docker build .
```

To run from docker index:


```shell
First run:
docker run -d \
            --name ldpjs \
             -p 27017:27017 -p 28017:28017 \
             -v="data:/var/mongodb/data:rw" \
              -d "ldpjs"
# Start up:
docker start ldpjs
```
