#!/bin/bash

# Robotpkg Helpers dependencies
sudo python3-notify2 python3-lark-parser

# Super build dependencies
sudo apt-get install python3-vcstool python-catkin-tools 

# Read user input for path integration
echo "Path for integration:"
read path_for_integration

# Create the json file
echo '{"arch_dist_files": "arch_distfiles",
 "archives": "archives",
 "ramfs_mnt_pt": "pal_env_for_super_build_zhang", 
 "repo_robotpkg_wip": "git://git.openrobots.org/robots/robotpkg/robotpkg-wip", 
 "repo_robotpkg_main": "git://git.openrobots.org/robots/robotpkg.git",
 "robotpkg_mng_root": "'$path_for_integration'", 
 "rc_pkgs":
 {},
 "ssh_git_openrobots": false,
 "targetpkgs": ["talos-simulation","pinocchio","eigen-quadprog",
    "simple-humanoid-description", "parametric-curves","talos-data"]
}' > /tmp/arch_test_pal_env.json

# Install robotpkg-helpers
mkdir -p $HOME/devel-src/sot_pg_ws/others
cd $HOME/devel-src/sot_pg_ws/others
git clone https://github.com/olivier-stasse/robotpkg_helpers.git
cd ./robotpkg_helpers/tools
./rpkgh_build_arch_rc.py /tmp/arch_test_pal_env.json

export ROBOTPKG_BASE=$path_for_integration/pal_env_for_super_build_zhang/install
export PATH=$PATH:$ROBOTPKG_BASE/sbin:$ROBOTPKG_BASE/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROBOTPKG_BASE/lib:$ROBOTPKG_BASE/lib/plugin:$ROBOTPKG_BASE/lib64
export PYTHONPATH=$PYTHONPATH:$ROBOTPKG_BASE/lib/python2.7/site-packages:$ROBOTPKG_BASE/lib/python2.7/dist-packages
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$ROBOTPKG_BASE/lib/pkgconfig/
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$ROBOTPKG_BASE/share:$ROBOTPKG_BASE/stacks
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$ROBOTPKG_BASE

# Install the ide.
mkdir -p $HOME/devel-src/sot_pg_ws/src
cd $HOME/devel-src/sot_pg_ws
catkin init -w $HOME/devel-src/sot_pg_ws
catkin config --install -w $HOME/devel-src/sot_pg_ws
echo 'repositories:
  src/dynamic-graph:
    type: git
    url: https://github.com/stack-of-tasks/dynamic-graph.git
    version: cmake-export
  src/dynamic-graph-python:
    type: git
    url: https://github.com/stack-of-tasks/dynamic-graph-python.git
    version: cmake-export
  src/dynamic_graph_bridge:
    type: git
    url: https://github.com/stack-of-tasks/dynamic_graph_bridge.git
    version: cmake-export
  src/dynamic_graph_bridge_msgs:
    type: git
    url: https://github.com/stack-of-tasks/dynamic_graph_bridge_msgs.git
    version: master
  src/jrl-walkgen:
    type: git
    url: https://github.com/stack-of-tasks/jrl-walkgen.git
    version: cmake-export
  src/roscontrol_sot:
    type: git
    url: https://github.com/stack-of-tasks/roscontrol_sot.git
    version: cmake-export
  src/sot-core:
    type: git
    url: https://github.com/stack-of-tasks/sot-core.git
    version: cmake-export
  src/sot-dynamic-pinocchio:
    type: git
    url: https://github.com/stack-of-tasks/sot-dynamic-pinocchio.git
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
    url: https://gepgitlab.laas.fr/loco-3d/sot-talos-balance.git
    version: cmake-export
  src/sot-tools:
    type: git
    url: https://github.com/stack-of-tasks/sot-tools.git
    version: cmake-export
  src/talos_data:
    type: git
    url: https://github.com/stack-of-tasks/talos_data.git
    version: cmake-export
  src/talos_metapkg_ros_control_sot:
    type: git
    url: https://github.com/stack-of-tasks/talos_metapkg_roscontrol_sot.git
    version: pal
' > ./sot_pg.repos

vcs import --recursive < ./sot_pg.repos

export ROBOTPKG_BASE=/opt/openrobots
export PATH=$PATH:$ROBOTPKG_BASE/sbin:$ROBOTPKG_BASE/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROBOTPKG_BASE/lib:$ROBOTPKG_BASE/lib/plugin:$ROBOTPKG_BASE/lib64
export PYTHONPATH=$PYTHONPATH:$ROBOTPKG_BASE/lib/python2.7/site-packages:$ROBOTPKG_BASE/lib/python2.7/dist-packages
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$ROBOTPKG_BASE/lib/pkgconfig/
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$ROBOTPKG_BASE/share:$ROBOTPKG_BASE/stacks
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$ROBOTPKG_BASE




