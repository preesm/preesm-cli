# Preesm CLI Wrappers

This repository holds files to call Preesm from the command line. 
The main script is [commandLinePreesm.sh](commandLinePreesm.sh) and consists in calling 
the Eclipse distribution with proper application, workspace, arguments, etc.
The batch file wraps the call to bash script using a local Cygwin installation (automatically installed).

## Instructions

Both the batch and bash scripts expect the same arguments, in the following order :

  1) ```PREESMDIR``` : The absolute path to the Preesm distribution to use;
  2) ```APPDIR``` : The absolute path to the Preesm project;
  3) ```WORKFLOW``` : The filename of the workflow to execute;
  4) ```SCENARIO``` : The filename of the scenario to use when executing the workflow;

In order for Preesm to find the workflow and scenario files, they must be located respectively in the folder ```<project folder>/Workflows``` and ```<project folder>/Scenarios``` (case matters). The bash script checks their existence at start.

## Sample calls

[preesm-test.sh](preesm-test.sh) and [preesm-test.bat](preesm-test.bat) present basic use of the Preesm CLI Wrappers.

### Windows

```
call .\commandLinePreesm.bat "E:\preesm_CLI\preesm-2.13.0" "E:\preesm_CLI\preesm-tuto" "Codegen.workflow" "03-parasobel_4core.scenario"
```

### Unix

```
./commandLinePreesm.sh "/tmp/preesm_CLI/preesm-2.13.0" "/tmp/preesm_CLI/preesm-tuto/" "Codegen.workflow" "03-parasobel_4core.scenario"
```
