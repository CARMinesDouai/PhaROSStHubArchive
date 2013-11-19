Class {
	#name : #ROBRobotXMLRPCClient,
	#superclass : #Object,
	#classVars : [
		'AllowedProxy'
	],
	#category : #'RoboShop-XMLRPC'
}

{ #category : #'robot control' }
ROBRobotXMLRPCClient >> acquireRobot [
	AllowedProxy := self.
	"AllowedProxy isNil ifTrue: [ 
		AllowedProxy := self.
		^AllowedProxy
	] ifFalse: [ self error: 'Only one proxy to the robot is allowed' ]"
]

{ #category : #constants }
ROBRobotXMLRPCClient >> arrivedConstant [
"this robot status means that it is arrived and stopped on a stargazer id"
	^ 1 
]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> currentLandmarkId [
	
	^self robotProxy  invokeMethod: #currentLandmarkId
	

]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> currentPosition [
	|dic |
	"return the currentPosition of the robot as a dictionary containing x and y"
	[dic := self robotProxy  invokeMethod: #currentPosition.
		^ (dic at:#x ) @ (dic at:#y)
	] on: Error do: [ 
		^ 0.0@0.0 
	]
]

{ #category : #constants }
ROBRobotXMLRPCClient >> errorConstant [
	^ 4
]

{ #category : #constants }
ROBRobotXMLRPCClient >> finishedConstant [
"this robot status means that it has finished the whole path including returning home"
	^ 5
]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> goToNextId [
	"return the id to which the robot is going"
	^self robotProxy  invokeMethod: #goToNextId
	

]

{ #category : #convenient }
ROBRobotXMLRPCClient >> hasError [
 	^ self robotStatus = self errorConstant
]

{ #category : #convenient }
ROBRobotXMLRPCClient >> hasFinished [
 	^ self robotStatus = self finishedConstant
]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> initializeRobotPathWithStargazerIds: collectionOfIds [ 
	
	^self robotProxy  invokeMethod: #initPathWithStargazerIds: withArgs: {collectionOfIds asArray} 
	

]

{ #category : #'robot control' }
ROBRobotXMLRPCClient >> isAllowedToControlRobot [
	^ AllowedProxy = self
]

{ #category : #convenient }
ROBRobotXMLRPCClient >> isRobotArrived [
 	^ self robotStatus = self arrivedConstant
]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> mapHash [
	"return a constant code (cf. constants protocol) that describes the robot status"
	"use convenient methods instead"
	^self robotProxy  invokeMethod: #mapHash
	

]

{ #category : #constants }
ROBRobotXMLRPCClient >> movingConstant [
"this robot status means that it is moving to a stargazerId or home"
	^ 3
]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> parking [
	"return the id to which the robot is going"
	^self robotProxy  invokeMethod: #parking
	

]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> recordPose [
	| pose |
	pose := self robotProxy  invokeMethod: #recordPose.
	^ ROBUniquePose point: (pose at: #point) orientation: (pose at: #orientation) id: (pose at:#id).
]

{ #category : #'robot control' }
ROBRobotXMLRPCClient >> releaseRobot [
	AllowedProxy = self ifTrue: [ 
		AllowedProxy := nil ]
]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> retry [
	"retry last goal. return the id to which the robot is going"
	^self robotProxy  invokeMethod: #retry
	

]

{ #category : #invoke }
ROBRobotXMLRPCClient >> robotName [
	^ #Dan
]

{ #category : #'robot communication' }
ROBRobotXMLRPCClient >> robotProxy [
	
	^XMLRPCProxy withUrl:  'http://127.0.0.1:9090/rpc'.

]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> robotStatus [
	"return a constant code (cf. constants protocol) that describes the robot status"
	"use convenient methods instead"
	^self robotProxy  invokeMethod: #status
	

]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> setIn: aLocation [
	"return the id to which the robot is going"
	^self robotProxy  invokeMethod: #setIn: withArgs: {aLocation id}
	

]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> setInZero [
	"return the id to which the robot is going"
	^self robotProxy  invokeMethod: #setInZero
	

]

{ #category : #'public api' }
ROBRobotXMLRPCClient >> stop [
	"return the id to which the robot is going"
	^self robotProxy  invokeMethod: #stop
	

]

{ #category : #constants }
ROBRobotXMLRPCClient >> waitingConstant [
	^ 2
]
