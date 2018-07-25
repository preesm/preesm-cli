#!/bin/bash

DIR=$(cd $(dirname $0) && pwd)
${DIR}/commandLinePreesm.sh "/opt/preesm/" "/opt/preesm-projects/preesm-tuto/" "Codegen.workflow" "03-parasobel_4core.scenario"
