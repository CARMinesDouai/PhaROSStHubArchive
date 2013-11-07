Class {
	#name : #ROBRobotXMLRPCClientMock,
	#superclass : #ROBRobotXMLRPCClient,
	#instVars : [
		'arrivedCounter',
		'path',
		'currentIdIndex',
		'hasError'
	],
	#category : #'RoboShop-XMLRPC'
}

{ #category : #'public api' }
ROBRobotXMLRPCClientMock >> goToNextId [
	currentIdIndex < path size ifTrue: [ currentIdIndex := currentIdIndex + 1 ].
	self log: '-> goToNextId  = ', (path at: currentIdIndex) asString.
	^path at: currentIdIndex
	
	
]

{ #category : #convenient }
ROBRobotXMLRPCClientMock >> hasError [
	 ^ hasError
]

{ #category : #'initialize-release' }
ROBRobotXMLRPCClientMock >> hasError: aBoolean [
	hasError := aBoolean.
]

{ #category : #convenient }
ROBRobotXMLRPCClientMock >> hasFinished [
	self log: '-> robot has finished : ', (currentIdIndex = path size) printString.
	^ currentIdIndex = path size
]

{ #category : #'initialize-release' }
ROBRobotXMLRPCClientMock >> initialize [
	super initialize.
	hasError := false.
	arrivedCounter := 0.
	
]

{ #category : #'public api' }
ROBRobotXMLRPCClientMock >> initializeRobotPathWithStargazerIds: collectionOfIds [ 
	path := collectionOfIds asArray.
	currentIdIndex := 0.
	self log: '-> initializeRobotPathWithStargazerIds: ', collectionOfIds printString
]

{ #category : #convenient }
ROBRobotXMLRPCClientMock >> isRobotArrived [
	|result|
	arrivedCounter := arrivedCounter + 1.
	arrivedCounter < 2 
		ifTrue: [ result := false ]
		ifFalse: [  
			arrivedCounter := 0.
			result := true
		].
	self log: '-> isRobotArrived : ', result printString.
	^result
]

{ #category : #logging }
ROBRobotXMLRPCClientMock >> log: aString [
	Transcript cr; show: aString
]

{ #category : #'public api' }
ROBRobotXMLRPCClientMock >> parking [
	self log: '-> Parking (Going to mark 1)'.
	
	
]

{ #category : #'public api' }
ROBRobotXMLRPCClientMock >> retry [
	
	self log: '-> Retry  = ', (path at: currentIdIndex) asString.
	^path at: currentIdIndex
	
	
]

{ #category : #'robot communication' }
ROBRobotXMLRPCClientMock >> robotProxy [
	^self
]
