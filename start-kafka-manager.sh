#!/bin/sh

if [[ $KM_USERNAME != ''  && $KM_PASSWORD != '' ]]; then
    sed -i.bak '/^basicAuthentication/d' /kafka-manager-${KM_VERSION}/conf/application.conf
    echo 'basicAuthentication.enabled=true' >> /kafka-manager-${KM_VERSION}/conf/application.conf
    echo "basicAuthentication.username=${KM_USERNAME}" >> /kafka-manager-${KM_VERSION}/conf/application.conf
    echo "basicAuthentication.password=${KM_PASSWORD}" >> /kafka-manager-${KM_VERSION}/conf/application.conf
    echo 'basicAuthentication.realm="Kafka-Manager"' >> /kafka-manager-${KM_VERSION}/conf/application.conf
fi

rm -f /kafka-manager-${KM_VERSION}/RUNNING_PID
mkdir -p /var/log/kafka-manager

exec ./bin/kafka-manager -Dconfig.file=${KM_CONFIGFILE} "${KM_ARGS}" "${@}" >>/var/log/kafa-manager/run.log 2>&1
