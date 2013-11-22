Class {
	#name : #PhaROSSystemLauncher,
	#superclass : #Object,
	#instVars : [
		'masterProcess',
		'turtleProcess',
		'gmappingProcess'
	],
	#classInstVars : [
		'instance',
		'distro'
	],
	#category : #'PhaROS-Util'
}

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher class >> distro: aDistroSymbol [
	distro := aDistroSymbol
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher class >> fuerte [
	^'/opt/ros/fuerte/bin/'
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher class >> groovy [
	^'/opt/ros/groovy/bin/'
]

{ #category : #'as yet unclassified' }
PhaROSSystemLauncher class >> initialize [
	super initialize.
	distro := #groovy.
]

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
PhaROSSystemLauncher class >> path: aCommand [
	^ (distro value: self) , '/', aCommand 
]

{ #category : #types }
PhaROSSystemLauncher >> deployType: aTypeName definedAs: aCompositeType at: aPackage [
	
	| outstream |
	outstream := StandardFileStream forceNewFileNamed:( self typeFileName: aTypeName for: aPackage).
	outstream ascii.
	outstream nextPutAll: aCompositeType stringDefinition.
	outstream flush.
	outstream close.
	self halt: 'Ensure that the CMakeLists.txt and package.xml files are suited for the compilation of the type, then press proceed '.
	aPackage make.
	
	PhaROSTypeBrowser instance definition: aPackage packageName, '/', aTypeName.
]

{ #category : #types }
PhaROSSystemLauncher >> rosMsg: aCommand [ 
	
	
	^ self rosMsg: { aCommand } tmpFile:  aCommand .
	
]

{ #category : #types }
PhaROSSystemLauncher >> rosMsg: anArrayOfArguments tmpFile: aTempFileName [
	| rosmsg outstream errstream  return |
	
	
	outstream := StandardFileStream forceNewFileNamed: '/tmp/',aTempFileName,'.tmp'.
	errstream := StandardFileStream forceNewFileNamed: '/tmp/error_',aTempFileName,'.tmp'.
	
	rosmsg  :=  ExternalUnixOSProcess 
							forkAndExec: (PhaROSSystemLauncher path: 'rosmsg' )  
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

{ #category : #types }
PhaROSSystemLauncher >> rosMsg: aCommand with: aTypeId [
	
	
	^ self rosMsg: { aCommand . aTypeId } tmpFile: (aTypeId copyReplaceAll: '/' with:'_').
	
]

{ #category : #types }
PhaROSSystemLauncher >> rosMsgMd5: aTypeId [

		^ self rosMsg: 'md5' with: aTypeId. 

]

{ #category : #types }
PhaROSSystemLauncher >> rosMsgShow: aTypeId [

	^  self rosMsg: 'show' with: aTypeId. 
]

{ #category : #launching }
PhaROSSystemLauncher >> roslaunch: aConfigurationFile [
| roslaunch |

	roslaunch := ExternalUnixOSProcess 
					forkAndExec:  (PhaROSSystemLauncher path:'roslaunch'  ) 
					arguments: { aConfigurationFile  } 
					environment:  nil 
					descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
	roslaunch spin: 50.
	
	^ roslaunch.

]

{ #category : #launching }
PhaROSSystemLauncher >> rosrun: anArrayOfArguments [
	| process | 
	process :=  ExternalUnixOSProcess 
							forkAndExec:  (PhaROSSystemLauncher path:'rosrun')  
							arguments: anArrayOfArguments
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
	process spin: 20.
	^ process. 
]

{ #category : #launching }
PhaROSSystemLauncher >> rosservice: anArrayOfArguments [
	| process | 
	process :=  ExternalUnixOSProcess 
							forkAndExec:  (PhaROSSystemLauncher path:'rosservice')  
							arguments: anArrayOfArguments
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
	process spin: 20.
	^ process. 
]

{ #category : #launching }
PhaROSSystemLauncher >> rosserviceCall: anArrayOfArguments [
	^ self rosservice: {'call'}, anArrayOfArguments.
]

{ #category : #deprecated }
PhaROSSystemLauncher >> shutdownGMapping [
	gmappingProcess  ifNotNil: [
		gmappingProcess finalize.
		gmappingProcess  := nil.
	].

]

{ #category : #deprecated }
PhaROSSystemLauncher >> shutdownMaster [
	masterProcess ifNotNil: [
		gmappingProcess finalize.
		masterProcess := nil.
	].

]

{ #category : #deprecated }
PhaROSSystemLauncher >> shutdownTurtle [
	turtleProcess ifNotNil: [
		turtleProcess finalize.
		turtleProcess := nil.
	].

]

{ #category : #deprecated }
PhaROSSystemLauncher >> startUpGMapping [
	gmappingProcess ifNil: [
		gmappingProcess :=  ExternalUnixOSProcess 
							forkAndExec:  (PhaROSSystemLauncher path:'rosrun')   
							arguments: { 'gmapping' . 'slam_gmapping' } 
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		gmappingProcess spin: 4.
	].
]

{ #category : #deprecated }
PhaROSSystemLauncher >> startUpMaster [
	" Remember that the environment variables must be setted before run this! "
	masterProcess ifNil: [
		masterProcess := ExternalUnixOSProcess 
					forkAndExec:  (PhaROSSystemLauncher path:'roscore' )  
					arguments: {  } 
					environment:  nil 
					descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		masterProcess spin: 20.
	].
]

{ #category : #deprecated }
PhaROSSystemLauncher >> startUpTurtle [
	turtleProcess ifNil: [
		turtleProcess :=  ExternalUnixOSProcess 
							forkAndExec:  (PhaROSSystemLauncher path:'rosrun'   )
							arguments: { 'turtlesim' . 'turtlesim_node' } 
							environment:  nil 
							descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
		turtleProcess spin: 20.
	].
]

{ #category : #environment }
PhaROSSystemLauncher >> typeFileName: aTypeName  for: aPackage [ 
	^ aPackage msg, '/', aTypeName ,'.msg'.
]
