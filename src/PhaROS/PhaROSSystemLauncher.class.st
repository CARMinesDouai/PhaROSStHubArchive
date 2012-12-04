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
	#category : #'PhaROS-Kernel'
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
PhaROSSystemLauncher >> rosMsgShow: aTypeId [
	| rosmsg outstream errstream tmp return |
	
	tmp := aTypeId copyReplaceAll: '/' with:'_' .
	outstream := StandardFileStream forceNewFileNamed: '/tmp/',tmp,'.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_',tmp,'.tmp'.
	
	rosmsg  :=  ExternalUnixOSProcess 
							forkAndExec: '/opt/ros/fuerte/bin/rosmsg'   
							arguments: { 'show' . aTypeId } 
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
PhaROSSystemLauncher >> shutdownGMapping [
	gmappingProcess  ifNotNil: [
		gmappingProcess  sigterm.
		self spin: 5. 
		gmappingProcess  sigkill.
		gmappingProcess  := nil.
	].

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> shutdownMaster [
	masterProcess ifNotNil: [
		masterProcess sigterm.
		self spin: 5.
		masterProcess sigkill.
		masterProcess := nil.
	].

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> shutdownTurtle [
	turtleProcess ifNotNil: [
		turtleProcess sigterm.
		self spin: 5. 
		turtleProcess sigkill.
		turtleProcess := nil.
	].

]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> spin: times [
	times timesRepeat: [
		(times * 100) timesRepeat: [].
		(Delay forMilliseconds: 100) wait.
	]

	
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher >> startUpGMapping [
	gmappingProcess ifNil: [
		gmappingProcess :=  ExternalUnixOSProcess 
							forkAndExec: '/opt/ros/fuerte/bin/rosrun'   
							arguments: { 'gmapping' . 'slam_gmapping' } 
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		self spin: 4.
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
		self spin: 10.
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
		self spin: 4.
	].
]
