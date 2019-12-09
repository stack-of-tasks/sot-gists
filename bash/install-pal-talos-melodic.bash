#!/bin/bash

# Robotpkg Helpers dependencies
sudo apt install python3-notify2 python3-lark-parser

# Super build dependencies
sudo apt install python3-vcstool python-catkin-tools 


# ROS dependencies
sudo apt install ros-melodic-four-wheel-steering-msgs ros-melodic-four-wheel-steering-controller ros-melodic-moveit-ros-planning-interface ros-melodic-tf2-bullet
sudo apt install ros-melodic-twist-mux

# Create the json file
echo '{"arch_dist_files": "arch_distfiles",
 "archives": "archives",
 "ramfs_mnt_pt": "test_bionic", 
 "repo_robotpkg_wip": "git://git.openrobots.org/robots/robotpkg/robotpkg-wip", 
 "repo_robotpkg_main": "git://git.openrobots.org/robots/robotpkg.git",
 "robotpkg_mng_root": "/integration_tests", 
 "rc_pkgs":
 {},
 "ssh_git_openrobots": false,
 "targetpkgs": ["pinocchio","py-pinocchio","eigen-quadprog","simple-humanoid-description", "parametric-curves","talos-data"]
}' > /tmp/arch_test_bionic_catkin.json

# Install robotpkg-helpers
mkdir -p $HOME/devel-src/SoT/SoT_ws_18_04/others
cd $HOME/devel-src/SoT/SoT_ws_18_04/others
git clone https://github.com/olivier-stasse/robotpkg_helpers.git
cd ./robotpkg_helpers/tools
./rpkgh_build_arch_rc.py /tmp/arch_test_bionic_catkin.json

source $HOME/bin/setup-opt-testrobotpkgarg.sh -p /integration_tests/test_bionic/install -r
source $HOME/bin/setup-opt-testrobotpkgarg.sh -p $HOME/devel-src/PAL/install -r
#
mkdir -p $HOME/devel-src/PAL
cd $HOME/devel-src/PAL
if [ -f ../rosinstall/melodic/talos_tutorials_melodic.rosinstall ]; then
    /usr/bin/rosinstall src /opt/ros/melodic  ../rosinstall/melodic/talos_tutorials_melodic.rosinstall
fi

# Install $HOME/devel-src/PAL
catkin config --install -w $HOME/devel-src/PAL
catkin build

# Build $HOME/devel-src/SoT_ws_bionic
mkdir -p $HOME/devel-src/sot_bionic_ws/src
cd $HOME/devel-src/sot_bionic_ws
local_cmake_args="--cmake-args -DCMAKE_BUILD_TYPE=DEBUG "
local_cmake_args="${local_cmake_args} -DPYTHON_STANDARD_LAYOUT:BOOL=ON "
local_cmake_args="${local_cmake_args} -DPYTHON_DEB_LAYOUT:BOOL=OFF"
local_cmake_args="${local_cmake_args} -DSETUPTOOLS_DEB_LAYOUT:BOOL=OFF"
catkin config --install -w $HOME/devel-src/sot_bionic_ws ${local_cmake_args}

echo 'repositories:
  others/robotpkg_helpers:
    type: git
    url: https://github.com/olivier-stasse/robotpkg_helpers.git
    version: master
  src/dynamic-graph:
    type: git
    url: https://github.com/stack-of-tasks/dynamic-graph.git
    version: cmake-export
  src/dynamic-graph-python:
    type: git
    url: git@github.com:stack-of-tasks/dynamic-graph-python.git
    version: cmake-export
  src/dynamic_graph_bridge:
    type: git
    url: https://github.com/stack-of-tasks/dynamic_graph_bridge.git
    version: cmake-export
  src/dynamic_graph_bridge_msgs:
    type: git
    url: git@github.com:stack-of-tasks/dynamic_graph_bridge_msgs.git
    version: master
  src/jrl-walkgen:
    type: git
    url: git@github.com:stack-of-tasks/jrl-walkgen.git
    version: cmake-export
  src/roscontrol_sot:
    type: git
    url: git@github.com:stack-of-tasks/roscontrol_sot.git
    version: cmake-export
  src/sot-core:
    type: git
    url: https://github.com/stack-of-tasks/sot-core.git
    version: cmake-export
  src/sot-dynamic-pinocchio:
    type: git
    url: git@github.com:stack-of-tasks/sot-dynamic-pinocchio.git
    version: cmake-export
  src/sot-pattern-generator:
    type: git
    url: https://github.com/stack-of-tasks/sot-pattern-generator.git
    version: cmake-export
  src/sot-talos:
    type: git
    url: https://github.com/stack-of-tasks/sot-talos.git
    version: cmake-export
  src/sot-talos-balance:
    type: git
    url: git@gepgitlab.laas.fr:loco-3d/sot-talos-balance.git
    version: cmake-export
  src/sot-tools:
    type: git
    url: https://github.com/stack-of-tasks/sot-tools.git
    version: cmake-export
  src/sot-torque-control:
    type: git
    url: git@github.com:stack-of-tasks/sot-torque-control.git
    version: cmake-export
  src/talos_data:
    type: git
    url: git@github.com:stack-of-tasks/talos_data.git
    version: cmake-export
  src/talos_metapkg_ros_control_sot:
    type: git
    url: https://github.com/stack-of-tasks/talos_metapkg_roscontrol_sot.git
    version: pal
  src/tsid:
    type: git
    url: https://github.com/olivier-stasse/tsid.git
    version: cmake-export
' > ./sot_talos.repos

vcs import --recursive < ./sot_talos.repos

