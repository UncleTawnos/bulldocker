#!/bin/bash

while read line
do
    name=`echo "${line}" | awk '{print $1}'`
    url=`echo "${line}" | awk '{print $2}'`
    wget ${url} -O ${name} \
    && unzip ${name} -d /usr/src/wordpress/wp-content/plugins/ \
    && rm ${name}

done < plugins.list