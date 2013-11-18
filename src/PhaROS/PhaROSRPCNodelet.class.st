Class {
	#name : #PhaROSRPCNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'ids',
		'path',
		'currentId',
		'currentGoal',
		'isError',
		'status'
	],
	#category : #'PhaROS-Nodelets-RPC'
}

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet class >> arrived [
	^ 1 
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet class >> error [
	^ 4.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet class >> finished [ 
	^ 5.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet class >> moving [
	^ 3
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet class >> waiting [
	^ 2
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> cancel [
	currentGoal ifNotNil: [
		currentGoal cancel.	
	].

	PureROSRobulabGoal allInstances do: #cancel.
	status := PhaROSRPCNodelet finished.
	currentGoal := nil.
	path := nil.
	
	
	^ true.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> configure [
	isError := 0.
	status := nil.
		XMLRPCService atPort: self port  
					serve: {
						#test -> {self -> #test } .
						#initPathWithStargazerIds: -> { self -> #initPathWithStargazerIds: } . 
						#goToNextId -> { self -> #goToNextId } .
						#status -> { self -> #status } .
						#currentLandmarkId -> { self -> #currentLandmarkId } .  
						#currentPosition -> { self -> #currentPosition } .  
						#parking -> { self -> #parking }.
						#cancel -> { self -> #cancel }.
 					} asXMLRPCHttpModule 
					at:'/rpc' .
	

	
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> currentLandmarkId [
	self flag: #pathNilInOtherPlace.
	path ifNil: [ ^ 1 ].
		
	^ currentId > path size ifTrue: [
		path := nil.	
		5.
	] ifFalse: [
		currentId = 0 ifTrue: [ 1 ] ifFalse: [ path at: currentId .]
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> currentPosition [ 
	self flag: #uncomment.
	^ 1 @ 1.
	
	"^ self nodelets movebase client currentPosition position x @ self nodelets movebase client currentPosition position y." 
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> go [
	| landmark |
	landmark := self currentLandmarkId.
	self flag: #uncomment.
	currentGoal := self nodelets robulab goToEntityID: landmark.
	
	^ landmark.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> goToNextId [ 	
	currentId := currentId + 1.
	^ self go.
	




]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> initPathWithStargazerIds: aCollection [
	ids := aCollection.
	aCollection size  = 0 ifTrue:[
		self log: 'ERROR: PhaROSRPCNodelet >> initPathWithStargazerIds:: Collection of IDS should not be empty'.
		self error: 'ERROR: PhaROSRPCNodelet >> initPathWithStargazerIds:: Collection of IDS should not be empty'.
	].
	self nodelets robulab relocalize.
	self makeAPath.
	^ true.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> makeAPath [

	currentId := 0.        
      path := ids asSet asOrderedCollection.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> parking [ 	
	currentGoal := self nodelets robulab goToEntityID: self parkingMark.
	^ self parkingMark .
	
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> parkingMark [
	^ 1.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> port [
	^ 9090
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> restart [
	XMLRPCService stop: self port.
	self configure.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> retry [ 	
	self go.
	^ true.
	




]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> status [
	| stat | 
	
	status ifNotNil:[ ^ status ].
	
	
	stat :=   self statusReal .
	
	
	stat = PhaROSRPCNodelet error ifTrue:[ 
		isError := isError + 1.
		isError > 2 ifTrue: [
			^ stat 	
		] ifFalse: [
			^ PhaROSRPCNodelet moving.
		]
	 ] ifFalse: [
		isError := 0. 
	].
	
	stat = PhaROSRPCNodelet arrived ifTrue: [ 
		currentGoal := nil.
		^ stat.	
	].
	
	^ stat.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> statusReal [
	
	 self flag: #cleanThisMess.
	
		
	 currentGoal  ifNotNil: [ 
	
		({ 
		  Actionlib_msgsGoalStatus active.
		  Actionlib_msgsGoalStatus recalled . 
		   Actionlib_msgsGoalStatus recalling .  
		   Actionlib_msgsGoalStatus preempted . 
		   Actionlib_msgsGoalStatus preempting  } includes: currentGoal status) ifTrue: [
			^ PhaROSRPCNodelet moving.	
		].
	
		Actionlib_msgsGoalStatus succeeded = currentGoal status ifTrue: [
			
			^ PhaROSRPCNodelet arrived.
			
		].
		Actionlib_msgsGoalStatus pending = currentGoal status ifTrue: [
			^ PhaROSRPCNodelet waiting.
		].
	
	       ^ PhaROSRPCNodelet arrived .	
	
	].
	path ifNil: [
		^PhaROSRPCNodelet finished. 
	] ifNotNil:[ 
		^ PhaROSRPCNodelet waiting.
	]
	
]

{ #category : #service }
PhaROSRPCNodelet >> stop [
	XMLRPCService stop: self port.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> test [
		^ 1.
]
