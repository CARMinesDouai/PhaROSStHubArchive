"
landmark navigation

	- all the cases need landmark recognition step based on laser.
	- the stargazer case just need to recognize the 0 landmark (according to default configurations: 82)
	
	AMCL 
	rosrun pharos headless amclbased.
	rosrun pharos headless launchkompai2.
	rosrun pharos headless launchstargazer.
	rosrun pharos headless landmarknavigation.
	
	Odometry+Stargazer
	rosrun pharos headless stargazerodometrybased.
	rosrun pharos headless launchkompai2.
	rosrun pharos headless launchstargazer.
	rosrun pharos headless landmarknavigation .
	
	
	
	StarGazer
	rosrun pharos headless stargazerbased.
	rosrun pharos headless launchkompai2. 
	rosrun pharos headless launchstargazer.
	rosrun pharos headless landmarknavigation .

"
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
		'lastId',
		'poseStampedSgOut'
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

{ #category : #private }
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

{ #category : #'scripts-launchers' }
PureROSRobulab >> mapFile [ 

	^ '/home/kompai1/map/map.yaml'
]

{ #category : #private }
PureROSRobulab >> poseStampedSg [
	
	^(controller node buildConnectionFor: '/stargazer/pose') 
		 typedAs: PureROSRobulabNodelet poseStampedTopicType ;
		 adapted: #pose \> PhaROSPose  ;
	  	 connect.
]

{ #category : #private }
PureROSRobulab >> poseStampedSg: aPose withFrame: aFrameID [

	self poseStampedSgOut send: [
		: msg | 
		aPose intoGeometry_msgs_Pose: msg pose.
		msg header frame_id: aFrameID.
	]
]

{ #category : #private }
PureROSRobulab >> poseStampedSgOut [
	
	^ poseStampedSgOut ifNil: [
		poseStampedSgOut := controller node topicPublisher: '/stargazer/pose'  typedAs: PureROSRobulabNodelet poseStampedTopicType 
	].

]

{ #category : #'scripts-navigation' }
PureROSRobulab >> scriptAmcl [

	| bot |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	bot inspect.
]

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptAmclBased [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompaiTF .
		spec kompaiOdometry .
		spec mapServer: self mapFile.
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

{ #category : #'scripts-transformers' }
PureROSRobulab >> scriptBaselinkAbsolutePose [
	controller := PhaROSHandleController transformation.
	(controller nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame) for: [: p | self kompaiAbsolutePose: p ]. 
	
]

{ #category : #'scripts-kompai' }
PureROSRobulab >> scriptKompai1 [
	controller := PhaROSHandleController kompai1.
		

]

{ #category : #'scripts-kompai' }
PureROSRobulab >> scriptKompai2 [

	controller := PhaROSHandleController kompai2.
	
"	
	controller nodelets kompai inspect.
"
]

{ #category : #'scripts-navigation' }
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

{ #category : #'scripts-navigation' }
PureROSRobulab >> scriptLandmarkNavigation [

	| bot |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	bot rpc.
	
	experiment controller nodelets localizer filein: 'map-landmarks-inner.st'.
	
	"experiment controller nodelets localizer filein: 'odometry-landmarks-inner.st'.
	"
	experiment controller nodelets localizer transformations.
	

	self setupPoseTracker.
	self setupPoseRecognizer.

	
	bot inspect.
	




]

{ #category : #'scripts-navigation' }
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

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptLaunchKompai1 [
	
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai1.
	].
	

]

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptLaunchKompai2 [
	
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai2.
	].
	

]

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptLaunchStargazer [
	
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec stargazer.
	].
	

]

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptMapBuilding [

	| bot |
	experiment := PureROSGmappings robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	bot inspect.
]

{ #category : #'scripts-transformers' }
PureROSRobulab >> scriptOdometry [

	| bot |
	controller := PhaROSHandleController robulab2.
	controller nodelets odometer transformToOdometry: controller nodelets robulab  poseStamped.
	
	

]

{ #category : #'scripts-stargazer-conf' }
PureROSRobulab >> scriptSetUpMapBuildingStargazer [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer mapBuilding.
	
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
	



]

{ #category : #'scripts-stargazer-conf' }
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
	sg startMeasurements .
	
	self quit.
]

{ #category : #'scripts-stargazer-conf' }
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

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptStagazerOdometryBased [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec mapServer: self mapFile.
		spec kompaiTF .
		spec kompaiOdometry .
		spec moveBase.
		spec velocitySmoother.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec staticZeroTFFrom: '/map'  to: '/odom'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/kompai/tf' to: '/tf' named: 'tf_relay'.
		spec rviz.
	].
	

]

{ #category : #'scripts-stargazer' }
PureROSRobulab >> scriptStandAloneMapBuildingStargazer [


	| bot stream|
	


	stream  := FileStream stdout.	
	controller := PhaROSHandleController robulab2.
	bot := controller nodelets robulab.
	lastPoseSettedStamp  := DateAndTime now - 10 minutes.
	stream nextPutAll: 'Remember that the robot should start this process located under the landmark 82', String lf.	
	stream nextPutAll: 'Starting pose merge process with direct odometry', String lf.
	
	2 seconds asDuration asDelay wait.
	
	stream nextPutAll: 'Starting landmark place recognition ', String lf.
	controller nodelets localizer learn:(  controller nodelets stargazer absoluteLandmarks ) .
	
	controller nodelets sgevents whenLandmark: [ : lmk | controller nodelets localizer scannedEntities size >= 4 ] doOnce: [ : lmk | 
		stream nextPutAll: 'Saving landmark map', String lf.
		controller nodelets localizer fileout: 'odometry-landmarks-inner.st'. 
		self quit. 
	]. 
	
	controller nodelets sgevents whenLandmark: [ : lmk | lmk landmark = 82 ] do: [ : lmk | 
		|now |
		now := DateAndTime now .
		(now - lastPoseSettedStamp ) asSeconds > 1 ifTrue: [
			controller nodelets initialpose initialPose:  (PhaROSPose fromGeometry_msgsPose:  lmk pose). 
			lastPoseSettedStamp := now.
		]
	]. 
	
	
	2 seconds asDuration asDelay wait.

	stream nextPutAll: 'Starting landmark TF broadcasting', String lf.
	controller nodelets localizer transformations.
	
	
	
]

{ #category : #'scripts-stargazer' }
PureROSRobulab >> scriptStargazer [

	controller := PhaROSHandleController stargazer.	
	tfpose := controller nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame.
	controller nodelets stargazer broadcastLandmarks: { 2 . 82 . 608 . 18 . 0" . 8192 . 80" }.
	controller nodelets stargazer mergeWithPose: tfpose.	
	

]

{ #category : #'scripts-stargazer-conf' }
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

{ #category : #'scripts-stargazer-conf' }
PureROSRobulab >> scriptStargazerMapBuildingMode [

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

{ #category : #'scripts-transformers-sg' }
PureROSRobulab >> scriptStargazerPose [

	controller := PhaROSHandleController stargazer.	
	
	controller nodelets stargazer landmarks for: [
		: lmk |
		self poseStampedSg: (PhaROSPose fromGeometry_msgsPose: lmk pose) withFrame: '/landmark82'.
	].

	
	

]

{ #category : #'scripts-transformers' }
PureROSRobulab >> scriptTf [
	controller := PhaROSHandleController robulab2.
	controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	controller nodelets pose2tf express: controller nodelets robulab poseStamped as: PureROSRobulabNodelet baseLinkFrame childOf: PureROSRobulabNodelet baseLinkParentFrame.

	
]

{ #category : #'scripts-transformers-sg' }
PureROSRobulab >> scriptTfSG [
	controller := PhaROSHandleController robulab2.
	controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	controller nodelets pose2tf express: self poseStampedSg as: PureROSRobulabNodelet baseLinkFrame childOf: '/landmark82'.

	


]

{ #category : #private }
PureROSRobulab >> setPoseWith: lmk [
	| entity pose lp |
		lastPoseSettedStamp := DateAndTime now.
		entity := (experiment controller nodelets localizer entity: lmk landmark).
		
		
		pose := entity center.
		
		lp := PhaROSPose fromGeometry_msgsPose: lmk pose.
		pose orientation: ( PhaROS2DOrientation z: lp orientation as2DOrientation z * -1).
		pose position: pose position + lp position.
		
		
		lp position module2d < 0.2 ifTrue: [
			experiment controller nodelets initialpose initialPose:  pose.
		] ifFalse: [
			experiment controller nodelets initialpose orientation: lp orientation as2DOrientation z* -1.
		]
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
		(DateAndTime now - lastPoseSettedStamp ) asSeconds > 4 and: [ 
			checked > 5 and: [
				 (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d < 1 
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
