#!/bin/bash
useradd mesos_exporter
mkdir /var/log/mesos_exporter
chown -R mesos_exporter:mesos_exporter /var/log/mesos_exporter
