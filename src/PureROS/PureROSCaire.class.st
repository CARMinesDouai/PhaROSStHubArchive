Class {
	#name : #PureROSCaire,
	#superclass : #PhaROSPackage,
	#instVars : [
		'process'
	],
	#category : #'PureROS-Package'
}

{ #category : #'as yet unclassified' }
PureROSCaire class >> author [
	^ 'ZhiYan'
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> cmake [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(caire)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS geometry_msgs message_generation message_runtime roscpp rospy std_msgs)

## System dependencies are found with CMake"s conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

#######################################
## Declare ROS messages and services ##
#######################################

## Generate messages in the "msg" folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the "srv" folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   geometry_msgs#   std_msgs
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES caire
#  CATKIN_DEPENDS geometry_msgs message_generation message_runtime roscpp rospy std_msgs
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
  ${catkin_INCLUDE_DIRS}
)

## Declare a cpp library
# add_library(caire
#   src/${PROJECT_NAME}/caire.cpp
# )

## Declare a cpp executable
# add_executable(caire_node src/caire_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(caire_node caire_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(caire_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS caire caire_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_caire.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
 '
	
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> configuration [
	^ PhaROSPackageDependency pureROSPackage: self package packageName.
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> dependencies [ 
	^ super dependencies , { 
		PhaROSPackageDependency pureros.
		PhaROSPackageDependency mapFuser .
	}
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> description [
	^' Caire - Exploration - Multirobots '
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> packageName [ 
	^ 'caire'
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> xml [
		^ '<?xml version="1.0"?>
<package>
  <name>caire</name>
  <version>0.1.0</version>
  <description> Caire - Exploration - Multirobots </description>

  <!-- One maintainer tag required, multiple allowed, one person per tag --> 
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="ZhiYan@todo.todo">ZhiYan</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but mutiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://ros.org/wiki/caire</url> -->


  <!-- Author tags are optional, mutiple are allowed, one per tag -->
  <!-- Authors do not have to be maintianers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  <author >ZhiYan</author>


  <!-- The *_depend tags are used to specify dependencies -->
  <!-- Dependencies can be catkin packages or system dependencies -->
  <!-- Examples: -->
  <!-- Use build_depend for packages you need at compile time: -->
  <!--   <build_depend>message_generation</build_depend> -->
  <!-- Use buildtool_depend for build tool packages: -->
  <!--   <buildtool_depend>catkin</buildtool_depend> -->
  <!-- Use run_depend for packages you need at runtime: -->
  <!--   <run_depend>message_runtime</run_depend> -->
  <!-- Use test_depend for packages you need only for testing: -->
  <!--   <test_depend>gtest</test_depend> -->
  <buildtool_depend>catkin</buildtool_depend>
  <build_depend>geometry_msgs</build_depend>
  <build_depend>roscpp</build_depend>
  <build_depend>rospy</build_depend>
  <build_depend>std_msgs</build_depend>
  <build_depend>message_generation</build_depend>
  <run_depend>geometry_msgs</run_depend>
  <run_depend>roscpp</run_depend>
  <run_depend>rospy</run_depend>
  <run_depend>std_msgs</run_depend>
  <run_depend>message_runtime</run_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- You can specify that this package is a metapackage here: -->
    <!-- <metapackage/> -->

    <!-- Other tools can request additional information be placed here -->

  </export>
</package>'
	
]

{ #category : #'as yet unclassified' }
PureROSCaire >> buildController [ 
	| ctroler |
	ctroler :=  PhaROSHandleController home.
	ctroler nodelets use: CaireNodelet as: #caire.
	
]

{ #category : #'as yet unclassified' }
PureROSCaire >> rvizFile [
	^ self path, '/src/single_robot.rviz'

]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptExplorationMaster [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec gmapping.
		spec moveBase.
		spec exploreNode.
		spec rviz.
	].

]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptMapFusion [
	| mapFusor out |  
	
	
	mapFusor := self controller nodelets caire mapFuser.
	out := self controller nodelets caire defaultOutput. 
	
	mapFusor on: #FusedMapUpdate do: [: updatedMap | 
		out send: [ :m | updatedMap intoOccupancyGrid: m ].
	].

		" Sensor processor "
	self clock tickAt: 1 hz on: ({
		 ((self controller node buildConnectionFor: '/p3dx0/map') typedAs: 'nav_msgs/OccupancyGrid'; adapted: CaireMap ).
		 ((self controller node buildConnectionFor: '/p3dx1/map') typedAs: 'nav_msgs/OccupancyGrid'; adapted: CaireMap ).
	} asSensors infinityTolerance;
	  for: [
		: maps |
		" Model feeding "
		 mapFusor registerMaps: maps. 
	 ]; yourself
	 ).
	



]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptMappingForExploration [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompaiTF.
		spec odometry.
		
		spec gmapping.
		spec moveBase.

		spec compressor.
		
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
	].

]
