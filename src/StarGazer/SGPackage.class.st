Class {
	#name : #SGPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'poseStampedSgOut',
		'process'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGPackage class >> author [
	^'SantiagoBragagnolo'
]

{ #category : #'as yet unclassified' }
SGPackage class >> cmake [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(stargazer)

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
 add_message_files(
   FILES
   SGLandMark.msg
 )

## Generate services in the "srv" folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate added messages and services with any dependencies listed here
 generate_messages(
   DEPENDENCIES
   geometry_msgs
   std_msgs
 )


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
#  LIBRARIES stargazer
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
# add_library(stargazer
#   src/${PROJECT_NAME}/stargazer.cpp
# )

## Declare a cpp executable
# add_executable(stargazer_node src/stargazer_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(stargazer_node stargazer_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(stargazer_node
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
# install(TARGETS stargazer stargazer_node
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
# catkin_add_gtest(${PROJECT_NAME}-test test/test_stargazer.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
 '
	
]

{ #category : #'as yet unclassified' }
SGPackage class >> description [
	^ 'Stargazer ROS package'
]

{ #category : #'as yet unclassified' }
SGPackage class >> packageName [ 
	^ 'stargazer'
]

{ #category : #'as yet unclassified' }
SGPackage class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
SGPackage class >> xml [
		^ '<?xml version="1.0"?>
<package>
  <name>stargazer</name>
  <version>0.1.0</version>
  <description>Stargazer ROS package</description>

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
  <!-- <url type="website">http://ros.org/wiki/stargazer</url> -->


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
SGPackage >> buildController [ 
	| ctrl | 
	ctrl :=  PhaROSHandleController  home.
	ctrl nodelets use: SGROSStarGazerNodelet  as: #stargazer.
	ctrl nodelets use: PhaROSTransformationNodelet  as: #transformation.
	^ ctrl. 
]

{ #category : #private }
SGPackage >> configureEnvironment: aStarGazer [
	| stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Setting HeightFix - yes ', String lf.

	aStarGazer heightFix: 'yes'.
	stream nextPutAll: 'Setting MarkHeight - 1200 ', String lf.
	aStarGazer markHeight: '1200'.
	stream nextPutAll: 'Setting MarkType- HLD1-S ', String lf.
	aStarGazer markType: 'HLD1-S'.
	


]

{ #category : #private }
SGPackage >> poseStampedSg [
	
	^(controller node buildConnectionFor: '/stargazer/pose') 
		 typedAs: PureROSRobulabNodelet poseStampedTopicType ;
		 adapted: #pose \> PhaROSPose  ;
	  	 connect.
]

{ #category : #private }
SGPackage >> poseStampedSg: aPose withFrame: aFrameID [

	self poseStampedSgOut send: [
		: msg | 
		aPose intoGeometry_msgs_Pose: msg pose.
		msg header frame_id: aFrameID.
	]
]

{ #category : #private }
SGPackage >> poseStampedSgOut [
	
	^ poseStampedSgOut ifNil: [
		poseStampedSgOut := controller node topicPublisher: '/stargazer/pose'  typedAs: PureROSRobulabNodelet poseStampedTopicType 
	].

]

{ #category : #scripts }
SGPackage >> scriptAbsoluteLandmark [
	| tfPseudoTopic |
.	
	tfPseudoTopic := self controller nodelets transformation between: '/base_link' 
														   and: '/map'.
	
	self controller nodelets stargazer mergeWithPose: tfPseudoTopic.

]

{ #category : #'scripts-configuration' }
SGPackage >> scriptConfiguration [

	| sg stream |
	
 
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer configureInstance.
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	stream nextPutAll: String lf, String lf, ' --------------------------------- ', String lf. 
	stream nextPutAll: ' Version=', sg version asString, String lf .
	stream nextPutAll: ' BaudRate=', sg baudRate asString, String lf .
	stream nextPutAll: ' --------------------------------- ', String lf. 
	stream nextPutAll: ' HeightFix=', sg heightFix asString, String lf .
	stream nextPutAll: ' MarkHeight=', sg markHeight asString, String lf .
	stream nextPutAll: ' MarkType=', sg markType asString, String lf .
	stream nextPutAll: ' --------------------------------- ', String lf. 
	stream nextPutAll: ' MarkMode=', sg markMode asString, String lf .
	stream nextPutAll: ' RefID=', sg refID asString, String lf .
	stream nextPutAll: ' IdNum=', sg idNum asString, String lf .
	stream nextPutAll: ' --------------------------------- ', String lf. 
	

	
	stream nextPutAll: 'Starting', String lf.
	sg startMeasurements .
	
	self quit.
]

{ #category : #scripts }
SGPackage >> scriptLaunchStargazer [
	
	process := PhaROSSystemLauncher  instance launch: [: spec | 
		spec stargazer.
	].
	

]

{ #category : #'scripts-configuration' }
SGPackage >> scriptMapBuildingMode [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer mapBuilding.
	
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	

	sg startMapBuilding.
	
	
	stream nextPutAll: 'Please, move robot around, staying under each landmark and in between each pair for someseconds ', String lf.
	sg mode whenMapIsDone: [
		stream nextPutAll: 'Map is builded! You can start map-mode-based localization', String lf.
		self halt.
		self quit.
		
	].	 
	
	


]

{ #category : #scripts }
SGPackage >> scriptPose [

	self controller nodelets stargazer landmarks for: [
		: lmk |
		| pose | 
		pose := self controller nodelets stargazer  landmarkToPose: lmk.
		self poseStampedSg: pose withFrame: '/base_link'.
	].

	
	

]

{ #category : #'scripts-configuration' }
SGPackage >> scriptSetUpMap [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer configureInstance.
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting markMode - Map', String lf.
	sg markMode: 'Map'.
	stream nextPutAll: 'Setting RefID - 82', String lf.
	sg refID: '96'.
	stream nextPutAll: 'Setting IdNum- 4', String lf.
	sg idNum: 4.
	stream nextPutAll: 'Starting', String lf.
	sg startMeasurements .
	
	self quit.
]

{ #category : #'scripts-configuration' }
SGPackage >> scriptSetUpMapBuilding [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer configureInstance.
	
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting markMode - Map', String lf.
	sg markMode: 'Map'.
	stream nextPutAll: 'Setting RefID - 96', String lf.
	sg refID: '96'.
	stream nextPutAll: 'Setting IdNum- 6', String lf.
	sg idNum: 6.
	
	
	self quit.
	



]

{ #category : #'scripts-configuration' }
SGPackage >> scriptSetUpStandAlone [

	| sg  stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.

	sg := StarGazer configureInstance.
	
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting starGazer mark mode to Alone', String lf.
	sg markMode: 'Alone'.
	
	stream nextPutAll: 'Starting starGazer', String lf.
	sg startMeasurements .
 	5 seconds asDelay wait.
	self quit.
]

{ #category : #scripts }
SGPackage >> scriptStartMeasures [		
	self controller nodelets stargazer broadcastLandmarks: { 2 . 96 . 608 . 18 . 0 . 8192 . 80 . 112 . 965 . 32 . 576 }.

]

{ #category : #scripts }
SGPackage >> scriptTf [
	self controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	self controller nodelets pose2tf express: self poseStampedSg as: '/base_link'childOf: '/odom'.

	


]
