Class {
	#name : #PhaROSSystemLauncher,
	#superclass : #Object,
	#instVars : [
		'masterProcess',
		'turtleProcess',
		'gmappingProcess'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-Util'
}

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher class >> instance [
	^ instance ifNil: [
		instance := super new.	
	]
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher class >> new [
	self error: 'This is a singleton object, use instance instead of new'.
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> rosMsg: aCommand [ 
	
	
	^ self rosMsg: { aCommand } tmpFile:  aCommand .
	
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> rosMsg: anArrayOfArguments tmpFile: aTempFileName [
	| rosmsg outstream errstream  return |
	
	
	outstream := StandardFileStream forceNewFileNamed: '/tmp/',aTempFileName,'.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_',aTempFileName,'.tmp'.
	
	rosmsg  :=  ExternalUnixOSProcess 
							forkAndExec: '/opt/ros/fuerte/bin/rosmsg'   
							arguments: anArrayOfArguments 
							environment:  nil 
							descriptors: { FileStream stdin . outstream . errstream } .  
		
	[ rosmsg isComplete not ] whileTrue: [
		(Delay forMilliseconds: 100) wait.
	].
	
	rosmsg succeeded ifTrue: [
		return := outstream reset; upToEnd.
		outstream close.
		errstream close.
	] ifFalse: [
		Error signal: 'Error discovering type. Is this process running in a ROS environment?', ( errstream reset; upToEnd).
		outstream close.
		errstream close.
	].

	^ return.

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> rosMsg: aCommand with: aTypeId [
	
	
	^ self rosMsg: { aCommand . aTypeId } tmpFile: (aTypeId copyReplaceAll: '/' with:'_').
	
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> rosMsgMd5: aTypeId [

		^ self rosMsg: 'md5' with: aTypeId. 

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> rosMsgShow: aTypeId [

	^  self rosMsg: 'show' with: aTypeId. 
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> roslaunch: aConfigurationFile [
| roslaunch |

	roslaunch := ExternalUnixOSProcess 
					forkAndExec: '/opt/ros/fuerte/bin/roslaunch'   
					arguments: { aConfigurationFile  } 
					environment:  nil 
					descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
	roslaunch spin: 20.
	
	^ roslaunch.

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> rosrun: anArrayOfArguments [
	| process | 
	process :=  ExternalUnixOSProcess 
							forkAndExec: '/opt/ros/fuerte/bin/rosrun'   
							arguments: anArrayOfArguments
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
	process spin: 20.
	^ process. 
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> shutdownGMapping [
	gmappingProcess  ifNotNil: [
		gmappingProcess finalize.
		gmappingProcess  := nil.
	].

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> shutdownMaster [
	masterProcess ifNotNil: [
		gmappingProcess finalize.
		masterProcess := nil.
	].

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> shutdownTurtle [
	turtleProcess ifNotNil: [
		turtleProcess finalize.
		turtleProcess := nil.
	].

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> startUpGMapping [
	gmappingProcess ifNil: [
		gmappingProcess :=  ExternalUnixOSProcess 
							forkAndExec: '/opt/ros/fuerte/bin/rosrun'   
							arguments: { 'gmapping' . 'slam_gmapping' } 
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		gmappingProcess spin: 4.
	].
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> startUpMaster [
	" Remember that the environment variables must be setted before run this! "
	masterProcess ifNil: [
		masterProcess := ExternalUnixOSProcess 
					forkAndExec: '/opt/ros/fuerte/bin/roscore'   
					arguments: {  } 
					environment:  nil 
					descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		masterProcess spin: 20.
	].
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> startUpTurtle [
	turtleProcess ifNil: [
		turtleProcess :=  ExternalUnixOSProcess 
							forkAndExec: '/opt/ros/fuerte/bin/rosrun'   
							arguments: { 'turtlesim' . 'turtlesim_node' } 
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		turtleProcess spin: 20.
	].
]
