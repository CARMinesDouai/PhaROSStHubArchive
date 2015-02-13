Class {
	#name : #IronMinesPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'masterUrl',
		'master',
		'process'
	],
	#category : #IronMines
}

{ #category : #'as yet unclassified' }
IronMinesPackage class >> author [
	^ 'MaxMattone'
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> cmake [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(ironmines)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  message_generation
  message_runtime
  roscpp
  rospy
  std_msgs
)

## System dependencies are found with CMake"s conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend and a run_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn"t empty the following dependencies might have been
##     pulled in transitively but can be declared for certainty nonetheless:
##     * add a build_depend tag for "message_generation"
##     * add a run_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)

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

## Generate actions in the "action" folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
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
#  LIBRARIES ironmines
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
# add_library(ironmines
#   src/${PROJECT_NAME}/ironmines.cpp
# )

## Declare a cpp executable
# add_executable(ironmines_node src/ironmines_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(ironmines_node ironmines_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(ironmines_node
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
# install(TARGETS ironmines ironmines_node
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
# catkin_add_gtest(${PROJECT_NAME}-test test/test_ironmines.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
 '
	
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> configuration [
	^ PhaROSPackageDependency ironMinesPackage: 'IronMines' .
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> dependencies [ 
	^ super dependencies, { 
		PhaROSPackageDependency tf 
	}.
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> description [
	^' Robot project for Cup du France du robotique'.
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> ironMinesPackage: aPackageName [ 
	^ self new 
			    packageName: aPackageName;
			     url: 'ftp://maxmattone.no-ip.biz/ironmines';
			     needsCredentials; 
			     yourself.
	 
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> packageName [ 
	^ 'ironmines'
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
IronMinesPackage class >> xml [
		^ '<?xml version="1.0"?>
<package>
  <name>ironmines</name>
  <version>0.1.0</version>
  <description> Robot project for Cup du France du robotique</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag --> 
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="MaxMattone@todo.todo">MaxMattone</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but mutiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://ros.org/wiki/ironmines</url> -->


  <!-- Author tags are optional, mutiple are allowed, one per tag -->
  <!-- Authors do not have to be maintianers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  <author >MaxMattone</author>


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
  <build_depend>message_generation</build_depend>
  <build_depend>roscpp</build_depend>
  <build_depend>rospy</build_depend>
  <build_depend>std_msgs</build_depend>
  <run_depend>geometry_msgs</run_depend>
  <run_depend>message_runtime</run_depend>
  <run_depend>roscpp</run_depend>
  <run_depend>rospy</run_depend>
  <run_depend>std_msgs</run_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- You can specify that this package is a metapackage here: -->
    <!-- <metapackage/> -->

    <!-- Other tools can request additional information be placed here -->

  </export>
</package>'
	
]

{ #category : #private }
IronMinesPackage >> buildController [ 
	| ctrl |
		ctrl := PhaROSHandleController home.
		ctrl nodelets use: PhaROSTransformationNodelet as: #transformation.
		ctrl nodelets use: KobukiNodelet  as: #kobuki.
		"ctrl nodelets use: IMArduinoNodelet  as: #arduino"
		^ ctrl
]

{ #category : #scripts }
IronMinesPackage >> launchKobuki [
	process := PhaROSSystemLauncher instance roslaunchForTests: '<launch>
 	 	<node pkg="nodelet" type="nodelet" name="mobile_base_nodelet_manager" args="manager"/>
  		<node pkg="nodelet" type="nodelet" name="mobile_base" args="load kobuki_node/KobukiNodelet mobile_base_nodelet_manager">
    			<rosparam file="$(find kobuki_node)/param/base.yaml" command="load"/>
    			<remap from="mobile_base/odom" to="odom"/>
    			<remap from="mobile_base/joint_states" to="joint_states"/>
  		</node>
  
  		<node pkg="diagnostic_aggregator" type="aggregator_node" name="diagnostic_aggregator" >
    			<rosparam command="load" file="$(find kobuki_node)/param/diagnostics.yaml" />
  		</node>
		
		<node pkg="rosserial_python" type="serial_node.py" name="ardui1" >
    			<param name="~port" value="/dev/ttyACM0" />
   			<param name="~baud" value="57600" />
  		</node>
		
		<node pkg="rosserial_python" type="serial_node.py" name="ardui2" >
    			<param name="~port" value="/dev/ttyACM1" />
   			<param name="~baud" value="57600" />
  		</node>
	</launch>'
]

{ #category : #scripts }
IronMinesPackage >> masterURL [
	^  'http://localhost:11311'
]

{ #category : #scripts }
IronMinesPackage >> scriptKobuki [
	| kob |
	masterUrl := self masterURL.
	PhaROSManifest cleanUp.
	master := PhaROSMaster url: masterUrl.
	self launchKobuki.
	kob := self controller nodelets kobuki kobuki .

]

{ #category : #scripts }
IronMinesPackage >> scriptKobukiDroite [
	| kob |
	masterUrl := self masterURL.
	PhaROSManifest cleanUp.
	master := PhaROSMaster url: masterUrl.
	self launchKobuki.
	kob := self controller nodelets kobuki kobuki .
	kob := Kobuki allInstances last.
	kob resetOdom.
	kob demarrer.
	kob carte: Kobuki carteDepartDroite.
	kob changeEtat: (EtatFactory createWaitingNext: EtatFactory createParcoursDemoDroit2 )

]

{ #category : #scripts }
IronMinesPackage >> scriptKobukiGauche [
	| kob |
	masterUrl := self masterURL.
	PhaROSManifest cleanUp.
	master := PhaROSMaster url: masterUrl.
	self launchKobuki.
	kob := self controller nodelets kobuki kobuki .
	kob := Kobuki allInstances last.
	kob resetOdom.
	kob demarrer.
	kob carte: Kobuki carteDepartGuauche.
	kob changeEtat: (EtatFactory createWaitingNext: EtatFactory createParcoursDemoGauche2  )

]

{ #category : #scripts }
IronMinesPackage >> scriptSomething [
 	| led |
	led := self controller nodelets arduino led.
	led on.
	led off.
	
	self halt.
	PhaROSManifest cleanUp .
]

{ #category : #scripts }
IronMinesPackage >> scriptTest [
	| kob |
	masterUrl := self masterURL.
	master := PhaROSMaster url: masterUrl.
	kob := self controller nodelets kobuki kobukiSansSonar.


]
