# Bash scripts for SoT

## A script to chain catkin workspaces `setup-opt-testrobotpkgarg.sh`

To add a workspace:
`./setup-opt-testrobotpkgarg.sh -p /opt/openrobots`

This script updates the following environment variables:
`PATH, PYTHONPATH, LD_LIBRARY_PATH, PKG_CONFIG_PATH, CMAKE_PREFIX_PATH, ROS_PACKAGE_PATH`


## Install a catkin workspace for the SoT `install-sot-pattern-generator.sh`

The script install-sot-pattern-generator.sh does the following step:
 * It installs the package necessary to have the robotpkg_helpers
 * It builds a minimal local space with the PAL Talos packages
 * It creates a catkin workspace in `~/devel-src/sot_pg_ws`
 * It pulls a set of repositories to prepare your workspace.
 
To build your workspace:

`cd ~/devel-src/sot_pg_ws`
`catkin build`

