#!/usr/bin/env bash
#
# Monitor Running Containers in Clean Fashion
#

watch -d 'docker container ls --format "table {{.Image}}\t{{.Names}}\t{{.Ports}}"'
