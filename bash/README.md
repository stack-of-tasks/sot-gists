# Bash scripts for SoT

## A script to chain catkin workspaces `setup-opt-testrobotpkgarg.sh`

To add a workspace:

`./setup-opt-testrobotpkgarg.sh -p /opt/openrobots`

This script updates the following environment variables:
`PATH, PYTHONPATH, LD_LIBRARY_PATH, PKG_CONFIG_PATH, CMAKE_PREFIX_PATH, ROS_PACKAGE_PATH`


## Install a catkin workspace for the SoT `install-sot-pattern-generator.sh`

The script install-sot-pattern-generator.sh does the following steps:
 * It installs the packages needed to have the robotpkg_helpers
 * It builds a minimal local space with the PAL Talos packages
 * It creates a catkin workspace in `~/devel-src/sot_pg_ws`
 * It pulls a set of repositories to prepare your workspace.

To build your workspace:

`cd ~/devel-src/sot_pg_ws`

`catkin build`

## Install two catkin workspace for Bionic SoT Talos `install-pal-talos-melodic.bash`

The script install-pal-talos-melodic.bash does the following steps:
 * It installs the packages needed to have the robotpkg_helpers
 * It builds a minimal local space with Gepetto packages in
 `/integration_tests/test_bionic`
 * It creates a catkin workspace in `~/devel-src/PAL`
 * It compiles the catkin packages inside this workspace.
 * It creates a catkin workspace in `~/devel-src/sot_bionic_ws`
 * It pulls a set of repositories to prepare your workspace.

 Note that in order to perform
 `catkin build`
 you need to prepare the chained workspace such that:
 `ROS_PACKAGE_PATH=/home/user/devel-src/SoT/SoT_ws_18_04/install/share:/home/user/devel-src/SoT/SoT_ws_18_04/install/stacks:/home/user/devel-src/PAL/install/share:/home/user/devel-src/PAL/install/stacks:/integration_tests/test_bionic/install/share:/integration_tests/test_bionic/install/stacks:/opt/ros/melodic/share`

 It is done typically by the following aliases:
 `alias test_bionic_env='source /home/ostasse/bin/setup-opt-testrobotpkgarg.sh -p /integration_tests/test_bionic/install -r'
 `alias test_pal_18_04_env='source /home/ostasse/bin/setup-opt-testrobotpkgarg.sh -p /home/ostasse/devel-src/PAL/install -r'
 `alias sot_bionic_env='source /home/ostasse/bin/setup-opt-testrobotpkgarg.sh -p /home/ostasse/devel-src/sot_bionic_ws/install -r'

 And then do:
 `test_bionic_env`
 `test_pal_18_04_env`
 `sot_bionic_env`
