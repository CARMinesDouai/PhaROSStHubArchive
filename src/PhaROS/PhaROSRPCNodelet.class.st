Class {
	#name : #PhaROSRPCNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'ids',
		'path',
		'currentId',
		'currentGoal'
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
PhaROSRPCNodelet >> configure [
		XMLRPCService atPort: self port  
					serve: {
						#test -> {self -> #test } .
						#initPathWithStargazerIds: -> { self -> #initPathWithStargazerIds: } . 
						#goToNextId -> { self -> #goToNextId } .
						#status -> { self -> #status } .
						#currentLandmarkId -> { self -> #currentLandmarkId } .  
						#currentPosition -> { self -> #currentPosition } .  
					} asXMLRPCHttpModule 
					at:'/rpc' .
	

	
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> currentLandmarkId [
	self flag: #pathNilInOtherPlace.
	path ifNil: [ self error: 'There is no path configured '].
		
	^ currentId > path size ifTrue: [
		path := nil.	
		82
	] ifFalse: [
		currentId = 0 ifTrue: [ 82 ] ifFalse: [ path at: currentId .]
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> currentPosition [ 
	self flag: #uncomment.
	^ 1 @ 1.
	
	"^ self nodelets movebase client currentPosition position x @ self nodelets movebase client currentPosition position y." 
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> goToNextId [ 	
	| landmark |
	currentId := currentId + 1.
	landmark := self currentLandmarkId.
	self flag: #uncomment.
	currentGoal := self nodelets robulab goToEntityID: landmark.
	
	^ landmark.
	




]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> initPathWithStargazerIds: aCollection [
	ids := aCollection.
	self assert: aCollection size > 1 description: 'collection should not be empty'.
	self makeAPath.
	^ true.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> makeAPath [
	path := ids asOrderedCollection .
	currentId := 0.
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
PhaROSRPCNodelet >> status [
	
	 self flag: #cleanThisMess.
		
	 currentGoal  ifNotNil: [ 
	
		({ Actionlib_msgsGoalStatus recalled . 
		   Actionlib_msgsGoalStatus recalling .  
		   Actionlib_msgsGoalStatus preempted . 
		   Actionlib_msgsGoalStatus preempting  } includes: currentGoal status) ifTrue: [
			^ PhaROSRPCNodelet moving.	
		].
	
		Actionlib_msgsGoalStatus succeeded = currentGoal status ifTrue: [
			currentId = 82 ifTrue: [
				^	PhaROSRPCNodelet finished.
			].
			^ PhaROSRPCNodelet arrived.
			
		].
		Actionlib_msgsGoalStatus pending = currentGoal status ifTrue: [
			^ PhaROSRPCNodelet waiting.
		].
	
	       ^ PhaROSRPCNodelet error.	
	
	].
	^PhaROSRPCNodelet waiting 
	
	
]

{ #category : #service }
PhaROSRPCNodelet >> stop [
	XMLRPCService stop: self port.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodelet >> test [
	^ 1.
]
