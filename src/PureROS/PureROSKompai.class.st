Class {
	#name : #PureROSKompai,
	#superclass : #PhaROSPackage,
	#instVars : [
		'robotName',
		'process',
		'kompaiAbsolutePoseTopic'
	],
	#category : #'PureROS-Package'
}

{ #category : #'as yet unclassified' }
PureROSKompai class >> author [
	^ 'SantiagoBragagnolo'
	
]

{ #category : #'as yet unclassified' }
PureROSKompai class >> cmake [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(kompai)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS geometry_msgs message_generation message_runtime roscpp rospy std_msgs)

## System dependencies are found with CMake"s conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/groovy/api/catkin/html/user_guide/setup_dot_py.html
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
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
   INCLUDE_DIRS include
#  LIBRARIES kompai
#  CATKIN_DEPENDS geometry_msgs message_generation message_runtime roscpp rospy std_msgs
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(include
  ${catkin_INCLUDE_DIRS}
)

## Declare a cpp library
# add_library(kompai
#   src/${PROJECT_NAME}/kompai.cpp
# )

## Declare a cpp executable
# add_executable(kompai_node src/kompai_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(kompai_node kompai_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(kompai_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/groovy/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS kompai kompai_node
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
# catkin_add_gtest(${PROJECT_NAME}-test test/test_kompai.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
 '
	
]

{ #category : #'as yet unclassified' }
PureROSKompai class >> description [
	^'Kompai package. PureNG wrapper for ROS'
]

{ #category : #'as yet unclassified' }
PureROSKompai class >> packageName [ 
	^ 'kompai'
]

{ #category : #'as yet unclassified' }
PureROSKompai class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
PureROSKompai class >> xml [
		^ '<?xml version="1.0"?>
<package>
  <name>kompai</name>
  <version>0.1.0</version>
  <description>Kompai package. PureNG wrapper for ROS</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag --> 
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="SantiagoBragagnolo@todo.todo">SantiagoBragagnolo</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but mutiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://ros.org/wiki/kompai</url> -->


  <!-- Author tags are optional, mutiple are allowed, one per tag -->
  <!-- Authors do not have to be maintianers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  <author >SantiagoBragagnolo</author>


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

{ #category : #private }
PureROSKompai >> build: aRobotName [
	| rbl |
	
	rbl :=  PhaROSHandleController home.
	rbl nodelets use: PureROSKompaiNodelet as: #kompai.
	rbl nodelets kompai initialize: aRobotName. 
	
	^ rbl .
]

{ #category : #private }
PureROSKompai >> buildController [ 
	^ self build: robotName.
	
]

{ #category : #private }
PureROSKompai >> kompaiAbsolutePose: aPose [
	self kompaiAbsolutePoseTopic send: [ : msg | msg pose: aPose asGeometry_msgsPose ].
]

{ #category : #private }
PureROSKompai >> kompaiAbsolutePoseTopic [
	^ kompaiAbsolutePoseTopic ifNil: [
		kompaiAbsolutePoseTopic := controller node topicPublisher: '/kompai/map/pose' typedAs: 'geometry_msgs/PoseStamped'.	
	]
]

{ #category : #scripts }
PureROSKompai >> scriptKompai1 [
	robotName := #kompai1.
	self controller.		

]

{ #category : #scripts }
PureROSKompai >> scriptKompai2 [
	robotName := #kompai2.
	self controller.		

]

{ #category : #scripts }
PureROSKompai >> scriptLaunchKompai1 [
	
	process := PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai1.
	].
	

]

{ #category : #scripts }
PureROSKompai >> scriptLaunchKompai2 [
	
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai2.
	].
	

]