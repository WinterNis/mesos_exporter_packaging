#!/bin/bash
userdel -r mesos_exporter
rm -rf /var/log/mesos_exporter
rm -rf /var/run/mesos_exporter.pid
