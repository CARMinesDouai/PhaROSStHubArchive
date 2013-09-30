Class {
	#name : #PhaROSEsug,
	#superclass : #PhaROSPackage,
	#instVars : [
		'controller',
		'launch'
	],
	#category : #'PhaROS-PackageManager'
}

{ #category : #'as yet unclassified' }
PhaROSEsug class >> author [
	^ 'SantiagoBragagnolo'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> cmake [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(esug)

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
#  LIBRARIES esug
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
# add_library(esug
#   src/${PROJECT_NAME}/esug.cpp
# )

## Declare a cpp executable
# add_executable(esug_node src/esug_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(esug_node esug_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(esug_node
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
# install(TARGETS esug esug_node
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
# catkin_add_gtest(${PROJECT_NAME}-test test/test_esug.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
 '
	
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> description [
	^' ESUG example package'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> packageName [ 
	^ 'esug'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> xml [
		^ '<?xml version="1.0"?>
<package>
  <name>esug</name>
  <version>0.1.0</version>
  <description> ESUG example package</description>

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
  <!-- <url type="website">http://ros.org/wiki/esug</url> -->


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
PhaROSEsug >> colorIsNotPath: aColor [
^ true "
	^ aColor isNil or: [aColor r = 69 and: [ aColor g = 86 and: [ aColor b = 255 ]]]."
]

{ #category : #private }
PhaROSEsug >> drawPharo [

^ [ : handler |
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt:0.0 and: -0.3.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 1.3.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 0.8 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.65.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 0.8 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 1.3.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 0.3.
	].
]

{ #category : #private }
PhaROSEsug >> make: aHandler moveBasedOn: anOtherHandler [



1 to: 1000 by: 1 do: [ :i |
		(anOtherHandler pose notNil and: [ aHandler pose notNil ]) ifTrue:[
			| trs linear angular |
			trs :=  anOtherHandler pose position - aHandler pose position.
			linear := trs module2d.
			angular :=4 * ( trs y arcTan: trs x).
			
			aHandler moveAt:  angular and: linear.
		 ].
		
		
		1 second asDelay wait.
		
	].
		
]

{ #category : #private }
PhaROSEsug >> make: aHandler pursuit: anOtherHandler [
	
	1 to: 4000 by: 1 do: [ :i |
		[
		"(anOtherHandler pose notNil and: [ aHandler pose notNil ]) ifTrue:["
			| trs linear angular |
			trs :=  controller nodelets transformation transformBetween: anOtherHandler  frame and: aHandler  frame.
			Transcript show: trs; cr.
			linear := (trs position module2d) * 0.5.
			angular :=4 * ( trs position y arcTan: trs position x).
			
			aHandler moveAt:  linear and: angular.
	"	 ]."
				
	] on: Error do: [ :e |  ].
	(Delay forMilliseconds: 100) wait.
].
		
]

{ #category : #private }
PhaROSEsug >> moveAround: handle [

		1 to: 1000 by: 1 do: [ :i | 
			| linear angular |
			linear := (Random seed: DateAndTime now asUnixTime)  next; next; nextInt:20 + ((Random seed: DateAndTime now asUnixTime)  next; nextInt:9) / 10.
	
			angular := (Random seed: DateAndTime now asUnixTime)  next;next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9) / 10.
	
			handle moveAt: linear and: angular. 	
			
			1 second asDelay wait.
		]
			
		
			
		
	
	
]

{ #category : #scripts }
PhaROSEsug >> scriptMorseTest [
	"comment stating purpose of message"

	| handler |
	
	" How to launch morse simulator ?
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	]."
	
	controller := PhaROSHandleController morse.
	
	handler := controller nodelets turtlesim defaultTurtleHandler.
	
	" message receiving test "
	" rostopic echo -n10 /atrv/pose "
	
	" message sending test "
	" rostopic pub -1 /atrv/motion geometry_msgs/Twist {linear: {x: .5}, angular: {z: .5}} "

]

{ #category : #scripts }
PhaROSEsug >> scriptTurtlesimPharo [
	|handler|
	
	"
		 The idea of this example is to show how to:
		
		1- spawn a roslaunch from the node. 
		2- create a  PhaROSHandleController, which is the entry point to ROS world.
		3- use a nodelet that was configured by the constructor. 
		4- create a turtle handler.
		5- easyly move the turtle around the ground.
	"
	
	
	"
		Launch message receives a block with a specification as parameter. To go deeper browse #PhaROSLaunchBuilder
	"
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].

	"
		A Controller is an object that build a base and unique node which represent the input and output of information between this image and ROS world
	"
	
	controller := PhaROSHandleController turtlesim.
	
	"
		In order to add behavior to a node we have the concept of Nodelet, (which is  similar to the ROS nodelet, because it runs without communication cost in between inner nodelets, 
		but also encourage to make small units of behavior, in order to be able to reuse, and since the code is all available in the same image is far easier to browse and understand the relation. 
		To know more about which nodelets we have, you can browse the category PhaROS-Nodelets, starting for PhaROSNodelet and PhaROSNodeletContainer.  .
		In this case, turtlesim constructor adds turtlesim nodelet into the nodelet repository. 
	"
	
	
	handler := controller nodelets turtlesim defaultTurtleHandler.
	handler algorithm: self drawPharo.
	
	"
		The block sent as algorithm to the Turtle handler it will be executed in other thread.
	"	 
	

]

{ #category : #scripts }
PhaROSEsug >> scriptTurtlesimPursuitTurtles [
	| handler handlerTurtle2 |
	
	"
		The idea of this example is to show how to:
		
		1- spawn a second turtle 
		2- spawn a related controller
		3- broadcast tf information related with the turtles
		4- consume tf information. 
		
	"
	
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].

	controller := PhaROSHandleController turtlesim.
	
	handler := controller nodelets turtlesim defaultTurtleHandler.
	
	
	
	" 
		This following method is based in a command, because services are not yet completely reificated. It spawns a turtle using rosservice command 
	"
	
	controller nodelets turtlesim spawnTurtle: 'turtle2'.
	handlerTurtle2 := controller nodelets turtlesim turtleHandleFor: 'turtle2'.
	
	"
		tf messages, one per each turtle-handler, rely on a PhaROSPoseToTFNodelet object, which is an excelent example to show how nice the nodelets are.  This nodelet, based on the Pose that the turtle inform, broadcast tf information in the proper frame. 
	"
	handler tf.
	handlerTurtle2 tf.
	
	
	
	"
		The algorithm of the first turtle is an easy turtle driver, that sends the turtle to different places applying linear and angular speed randomly. 
	"
	
	handler algorithm: [ : aHandle | self moveAround: aHandle ].
	
	"
		The algorithm of the second turtle is an example about how to use  pharos TF library in order to get distances and transformations. Based on that the second turtle will pursuit the firstone. 
		This example is based on the turtle_tf example. 
	"
	
	handlerTurtle2 algorithm: [self make: handlerTurtle2 pursuit: handler].
	
	 "
	controller nodelets transformation between: '/turtle2' and: '/turtle1' for: [ : p | Transcript show: p; cr. ]
	"


]
