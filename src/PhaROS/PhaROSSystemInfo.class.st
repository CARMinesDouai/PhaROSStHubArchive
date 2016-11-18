"
I am a facade of ROS commands.
"
Class {
	#name : #PhaROSSystemInfo,
	#superclass : #Object,
	#instVars : [
		'distro',
		'path',
		'masterProcess'
	],
	#classVars : [
		'Instance'
	],
	#category : #'PhaROS-Util'
}

{ #category : #distro }
PhaROSSystemInfo class >> fuerte [
	^'/opt/ros/fuerte/bin/'
]

{ #category : #distro }
PhaROSSystemInfo class >> groovy [
	^'/opt/ros/groovy/bin/'
]

{ #category : #distro }
PhaROSSystemInfo class >> hydro [
	^ '/opt/ros/hydro/bin/'
]

{ #category : #distro }
PhaROSSystemInfo class >> indigo [
	^'/opt/ros/indigo/bin/'
]

{ #category : #initialization }
PhaROSSystemInfo class >> initialize [
	self instance distro
]

{ #category : #accessing }
PhaROSSystemInfo class >> instance [

	^ Instance ifNil: [ Instance := super new ]
]

{ #category : #'instance creation' }
PhaROSSystemInfo class >> new [

	self error: 'Please, use instance instead.'
]

{ #category : #services }
PhaROSSystemInfo >> argsOfService: aService [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: '/opt/ros/indigo/bin/rosservice args ', aService.
	^ lst subStrings: String lf.
]

{ #category : #topics }
PhaROSSystemInfo >> bandwidthUsedBy: aTopicName [

	^ OSProcess thisOSProcess waitForCommandOutput: ('/opt/ros/indigo/bin/rostopic bw ', aTopicName).
	
]

{ #category : #services }
PhaROSSystemInfo >> callService: aService withArgs: args [

	^ OSProcess thisOSProcess command: '/opt/ros/indigo/bin/rosservice call ', aService, ' ', args.
	
]

{ #category : #nodes }
PhaROSSystemInfo >> cleanup [

	^ OSProcess thisOSProcess waitForCommand: '/opt/ros/indigo/bin/rosnode cleanup'.
	
]

{ #category : #parameters }
PhaROSSystemInfo >> deleteParameter: aParam [

	^ OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosparam delete ', aParam.
	
]

{ #category : #accessing }
PhaROSSystemInfo >> distro [

	 ^ distro ifNil:  [ distro := self distroFromSystem ].
]

{ #category : #accessing }
PhaROSSystemInfo >> distroFromSystem [
	| distroFromSystem |
	distroFromSystem := OSProcess thisOSProcess waitForCommandOutput: 'rosversion -d'.
	distroFromSystem ifEmpty: [ ^nil ].
	^(distroFromSystem substrings: String lf) first
]

{ #category : #services }
PhaROSSystemInfo >> findServicesFor: aMsgType [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosservice find ', aMsgType).
	^ lst subStrings: String lf.
	
]

{ #category : #topics }
PhaROSSystemInfo >> findTopicsFor: aTopicType [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rostopic find ', aTopicType).
	^ lst subStrings: String lf.
	
]

{ #category : #parameters }
PhaROSSystemInfo >> getParameter: aParam [

	^ OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosparam get ', aParam.
	
]

{ #category : #nodes }
PhaROSSystemInfo >> infoOfNode: aNodeName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosnode info ', aNodeName).
	
]

{ #category : #services }
PhaROSSystemInfo >> infoOfService: aServiceName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosservice info ', aServiceName).
	
]

{ #category : #topics }
PhaROSSystemInfo >> infoOfTopic: aTopicName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rostopic info ', aTopicName).
	
]

{ #category : #nodes }
PhaROSSystemInfo >> killNode: aNodeName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosnode kill ', aNodeName).
	
]

{ #category : #run }
PhaROSSystemInfo >> launchExternalROSMaster [
	masterProcess ifNil: [  
		masterProcess := ExternalUnixOSProcess forkAndExec: PhaROSSystemInfo instance rospath,'roscore'.
		500 milliSeconds wait ]


]

{ #category : #parameters }
PhaROSSystemInfo >> loadParametersFromFile: aFileName [

	^ OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosparam load ', aFileName.
	
]

{ #category : #messages }
PhaROSSystemInfo >> md5OfMessage: aMessageName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosmsg md5 ', aMessageName).
	
]

{ #category : #messages }
PhaROSSystemInfo >> messageList [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosmsg list'.
	^ lst subStrings: String lf.
]

{ #category : #messages }
PhaROSSystemInfo >> messageListOfPackage: aPackageName [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosmsg package ', aPackageName.
	^ lst subStrings: String lf.
]

{ #category : #nodes }
PhaROSSystemInfo >> nodeList [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosnode list'.
	^ lst subStrings: String lf.
]

{ #category : #nodes }
PhaROSSystemInfo >> nodeListOnMachine: aHostname [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosnode machine ', aHostname).
	^ lst subStrings: String lf.
]

{ #category : #messages }
PhaROSSystemInfo >> packagesContainingMessage: aMessageName [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosmsg packages ', aMessageName.
	^ lst subStrings: String lf.
]

{ #category : #parameters }
PhaROSSystemInfo >> parameterList [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosparam list'.
	^ lst subStrings: String lf.
]

{ #category : #nodes }
PhaROSSystemInfo >> pingAllNodes [

	^ self pingAllNodesTrace subStrings: String lf.
]

{ #category : #nodes }
PhaROSSystemInfo >> pingAllNodesTrace [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosnode ping -a').
	^ lst
]

{ #category : #nodes }
PhaROSSystemInfo >> pingNode: aNodeName [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosnode ping -c 1 ', aNodeName).
	^ lst subStrings: String lf.
]

{ #category : #topics }
PhaROSSystemInfo >> printMessageOf: aTopicName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rostopic echo -n 1 ', aTopicName).
	
]

{ #category : #topics }
PhaROSSystemInfo >> publish: data type: topicType onTopic: aTopic [

	^OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rostopic pub ',aTopic, ' ', topicType, ' ', data).
]

{ #category : #topics }
PhaROSSystemInfo >> publishingRateOf: aTopicName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rostopic hz ', aTopicName).
	
]

{ #category : #accessing }
PhaROSSystemInfo >> rospath [

	^ path ifNil: [ path := self class perform: self distro asSymbol ]
]

{ #category : #run }
PhaROSSystemInfo >> run: node from: package [

	^ OSProcess thisOSProcess command: (self rospath,'rosrun ', package, ' ', node).
	
]

{ #category : #parameters }
PhaROSSystemInfo >> saveParametersInFile: aFileName [

	^ OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosparam dump ', aFileName.
	
]

{ #category : #services }
PhaROSSystemInfo >> serviceList [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosservice list'.
	^ lst subStrings: String lf.
]

{ #category : #parameters }
PhaROSSystemInfo >> setParameter: aParam toValue: aValue [

	^ OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosparam set ', aParam, ' ', aValue.
	
]

{ #category : #messages }
PhaROSSystemInfo >> showMessage: aMessageName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosmsg show ', aMessageName).
	
]

{ #category : #messages }
PhaROSSystemInfo >> sourceCodeContainingMessage: aMessageName [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: self rospath,'rosmsg users ', aMessageName.
	^ lst subStrings: String lf.
]

{ #category : #run }
PhaROSSystemInfo >> stopExternalROSMaster [
	masterProcess ifNotNil: [  
		masterProcess sigint.
		masterProcess := nil ]


]

{ #category : #topics }
PhaROSSystemInfo >> topicList [

	|lst|
	lst := OSProcess thisOSProcess waitForCommandOutput: (self rospath,'/rostopic list').
	^ lst substrings: String lf.
	
]

{ #category : #services }
PhaROSSystemInfo >> typeOfService: aServiceName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosservice type ', aServiceName).
	
]

{ #category : #topics }
PhaROSSystemInfo >> typeOfTopic: aTopicName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rostopic type ', aTopicName).
	
]

{ #category : #services }
PhaROSSystemInfo >> uriOfService: aServiceName [

	^ OSProcess thisOSProcess waitForCommandOutput: (self rospath,'rosservice uri ', aServiceName).
	
]
