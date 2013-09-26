Class {
	#name : #PureROSRobulab,
	#superclass : #PhaROSPackage,
	#instVars : [
		'experiment',
		'controller',
		'tfpose',
		'kompaiAbsolutePoseTopic',
		'process',
		'lastPoseSettedStamp',
		'checked',
		'lastId'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PureROSRobulab class >> author [
	^ Author fullName
	
]

{ #category : #'as yet unclassified' }
PureROSRobulab class >> cmake [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(pharos)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS geometry_msgs roscpp rospy std_msgs message_generation)

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
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES pharos
#  CATKIN_DEPENDS geometry_msgs roscpp rospy std_msgs
#  DEPENDS system_lib
   CATKIN_DEPENDS message_runtime
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
# add_library(pharos
#   src/${PROJECT_NAME}/pharos.cpp
# )

## Declare a cpp executable
# add_executable(pharos_node src/pharos_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(pharos_node pharos_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(pharos_node
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
# install(TARGETS pharos pharos_node
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
# catkin_add_gtest(${PROJECT_NAME}-test test/test_pharos.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)




 '
	
]

{ #category : #accessing }
PureROSRobulab class >> description [
	^' pharos package'
]

{ #category : #'as yet unclassified' }
PureROSRobulab class >> packageName [ 
	^ 'pharos'
]

{ #category : #'as yet unclassified' }
PureROSRobulab class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
PureROSRobulab class >> xml [
		^ '<?xml version="1.0"?>
<package>
  <name>pharos</name>
  <version>0.1.0</version>
  <description> pharos package</description>

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
  <!-- <url type="website">http://ros.org/wiki/pharos</url> -->


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
  <run_depend>geometry_msgs</run_depend>
  <run_depend>roscpp</run_depend>
  <run_depend>rospy</run_depend>
  <run_depend>std_msgs</run_depend>


  <build_depend>message_generation</build_depend>
  <run_depend>message_runtime</run_depend>

  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- You can specify that this package is a metapackage here: -->
    <!-- <metapackage/> -->

    <!-- Other tools can request additional information be placed here -->

  </export>
</package>
 '
	
]

{ #category : #scripts }
PureROSRobulab >> configureEnvironment: aStarGazer [
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
PureROSRobulab >> kompaiAbsolutePose: aPose [
	self kompaiAbsolutePoseTopic send: [ : msg | msg pose: aPose asGeometry_msgsPose ].
]

{ #category : #private }
PureROSRobulab >> kompaiAbsolutePoseTopic [
	^ kompaiAbsolutePoseTopic ifNil: [ 
		kompaiAbsolutePoseTopic := controller node topicPublisher: '/kompai/map/pose' typedAs: 'geometry_msgs/PoseStamped'.	
	]
]

{ #category : #scripts }
PureROSRobulab >> scriptAmcl [

	| bot |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	bot inspect.
]

{ #category : #scripts }
PureROSRobulab >> scriptBaselinkAbsolutePose [
	controller := PhaROSHandleController transformation.
	(controller nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame) for: [: p | self kompaiAbsolutePose: p ]. 
	
]

{ #category : #scripts }
PureROSRobulab >> scriptKompai1 [
	controller := PhaROSHandleController kompai1.
		

]

{ #category : #scripts }
PureROSRobulab >> scriptKompai2 [

	controller := PhaROSHandleController kompai2.
	
"	
	controller nodelets kompai inspect.
"
]

{ #category : #scripts }
PureROSRobulab >> scriptLandmarkAutoNavigation [

	| bot goals |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	experiment controller nodelets localizer filein: 'map-landmarks-inner.st'.
	experiment controller nodelets localizer transformations.
	
	self setupPoseTracker.
	

	goals := OrderedCollection new. 	
	1 to: 20 do: [: i | 
		goals add: 608; add: 82; add: 18; add: 2.
	].
	
	bot goToArray: goals shuffle asArray.



]

{ #category : #scripts }
PureROSRobulab >> scriptLandmarkNavigation [

	| bot |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	bot rpc.
	
	experiment controller nodelets localizer filein: 'map-landmarks-inner.st'.
	experiment controller nodelets localizer transformations.
	

	self setupPoseTracker.
	"self setupPoseRecognizer."
	bot inspect.
	




]

{ #category : #scripts }
PureROSRobulab >> scriptLandmarksRecognition [

	| bot |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	experiment controller nodelets stargazer mergeWithPose: bot defaultPose.
	
	2 seconds asDuration asDelay wait.
	
	experiment controller nodelets localizer learn:( experiment controller nodelets stargazer absoluteLandmarks ) .
	
	"self nodelets localizer explore."
	
	2 seconds asDuration asDelay wait.
	experiment controller nodelets localizer map.
	experiment controller nodelets localizer mapPoints.
	experiment controller nodelets localizer transformations.
	2 seconds asDuration asDelay wait.
	
	bot inspect.
	
]

{ #category : #scripts }
PureROSRobulab >> scriptLaunch [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompai2.
		spec mapServer: '/home/viki/map/map.yaml'.
		spec amcl.
		spec moveBase.
		spec velocitySmoother.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/kompai/tf' to: '/tf' named: 'tf_relay'.
		spec rviz.
	].
	

]

{ #category : #scripts }
PureROSRobulab >> scriptMapBuilding [

	| bot |
	experiment := PureROSGmappings robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	bot inspect.
]

{ #category : #scripts }
PureROSRobulab >> scriptOdometry [

	| bot |
	controller := PhaROSHandleController robulab2.
	controller nodelets odometer transformToOdometry: controller nodelets robulab  poseStamped.
	
	

]

{ #category : #scripts }
PureROSRobulab >> scriptSetUpMapBuildingStargazer [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer default.
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting markMode - Map', String lf.
	sg markMode: 'Map'.
	stream nextPutAll: 'Setting RefID - 82', String lf.
	sg refID: '82'.
	stream nextPutAll: 'Setting IdNum- 4', String lf.
	sg idNum: 4.
	stream nextPutAll: 'Starting map building', String lf.
	
	sg startMapBuilding.
	
	
	stream nextPutAll: 'Please, move robot around, staying under each landmark and in between each pair for someseconds ', String lf.
	sg whenMapIsDone: [
		self quit.
		
	].	 
	
	





]

{ #category : #scripts }
PureROSRobulab >> scriptSetUpMapStargazer [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer default.
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting markMode - Map', String lf.
	sg markMode: 'Map'.
	stream nextPutAll: 'Setting RefID - 82', String lf.
	sg refID: '82'.
	stream nextPutAll: 'Setting IdNum- 4', String lf.
	sg idNum: 4.
	stream nextPutAll: 'Starting', String lf.
	sg startMeasurements 
	
	self quit.
]

{ #category : #scripts }
PureROSRobulab >> scriptSetUpStandAloneStargazer [

	| sg  stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.

	sg := StarGazer default.
	
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
PureROSRobulab >> scriptStargazer [

	controller := PhaROSHandleController stargazer.	
	tfpose := controller nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame.
	controller nodelets stargazer broadcastLandmarks: { 2 . 82 . 608 . 18 . 0 . 8192 }.
	controller nodelets stargazer mergeWithPose: tfpose.	
	

]

{ #category : #scripts }
PureROSRobulab >> scriptStargazerConfiguration [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer default.
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
PureROSRobulab >> scriptTf [
	controller := PhaROSHandleController robulab2.
	controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	controller nodelets pose2tf express: controller nodelets robulab poseStamped as: PureROSRobulabNodelet baseLinkFrame childOf: PureROSRobulabNodelet baseLinkParentFrame.

	
]

{ #category : #private }
PureROSRobulab >> setPoseWith: lmk [
	| entity pose |
		lastPoseSettedStamp := DateAndTime now.
		entity := (experiment controller nodelets localizer entity: lmk landmark).
		
		self halt.
		pose := entity center.
		pose orientation: ( PhaROS2DOrientation z:(( PhaROSPose fromGeometry_msgsPose: lmk pose) orientation as2DOrientation z + (Float pi / 2))).
		
		
		experiment controller nodelets initialpose initialPose:  pose.
]

{ #category : #private }
PureROSRobulab >> setupPoseRecognizer [

	lastPoseSettedStamp := DateAndTime now - 1 minute.
	experiment controller  nodelets sgevents whenLandmark: [ : lmk |  
		lastId = lmk landmark ifTrue: [
			checked := checked + 1.	
		] ifFalse: [
			checked := 0.
		].
		lastId := lmk landmark.
		(DateAndTime now - lastPoseSettedStamp ) asSeconds > 20 and: [ 
			checked > 5 and: [
				 (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d < 0.3 
			]	
		]
	] do: [ : lmk | 
	self setPoseWith: lmk.
	].
	
	
]

{ #category : #private }
PureROSRobulab >> setupPoseTracker [
	experiment controller  nodelets sgevents whenLandmark: [ : lmk |  
		| entity |
		entity := (experiment controller nodelets localizer entity: lmk landmark).
		(entity annotation: #measureStamp) isNil or: [
			( DateAndTime now - (entity annotation: #measureStamp)) asSeconds > 10 or: [ 
				(entity annotation: #lastPose ) position module2d > (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d 
			]
		].
	] do: [ : lmk | 
		| entity |
		entity := (experiment controller nodelets localizer entity: lmk landmark).
		entity annotate:#lastPose with: (experiment controller  nodelets transformation frame:'/base_link' ) pose.
		entity annotate:#measureStamp with: DateAndTime now.
	].
	
	
]
