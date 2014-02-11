Class {
	#name : #DonatelloAlgorithms,
	#superclass : #Object,
	#instVars : [
		'algorithms'
	],
	#category : #DonatelloPackage
}

{ #category : #algorithms }
DonatelloAlgorithms >> algorithmFor: aCommand [
	
	^ algorithms at: aCommand lowercase ifAbsent: [ 
		self idleHandler.	
	 ]
	
]

{ #category : #algorithms }
DonatelloAlgorithms >> circularHandler [ 

^ [ : handler |
		handler forwardAt: 1.0.
		1 seconds asDelay wait.
		[  true ] whileTrue: [handler rotate: 1.0. 1 seconds asDelay wait.].
	].
]

{ #category : #algorithms }
DonatelloAlgorithms >> idleHandler [ 

^ [ : handler | 
		handler forwardAt: 0.0.
].
]

{ #category : #algorithms }
DonatelloAlgorithms >> initialize [
	algorithms := Dictionary new.
	

	algorithms at: 'random' put:self randomHandler.
	algorithms at: 'quiet' put:self idleHandler.
	algorithms at: 'circular' put:self circularHandler.
	algorithms at: 'pharo' put:self pharoHandler.
	algorithms at: 'pursuiter' put:self pursuiterHandler.
	
]

{ #category : #algorithms }
DonatelloAlgorithms >> list [
	^ algorithms keys
]

{ #category : #algorithms }
DonatelloAlgorithms >> pharoHandler [

^ [ : handler |
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt:0.0 and: -0.3.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 1.3.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 0.8 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.65.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 0.8 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 1.3.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 0.3.
	].
]

{ #category : #algorithms }
DonatelloAlgorithms >> pursuiterHandler [
	
	^ [ : handle | 
		| default  |
		default := self nodelets turtlesim defaultTurtleHandler.
		[ true ] whileTrue: [
			| trs linear angular |
			[			
				trs :=  self controller nodelets transformation transformBetween: default  frame and: handle  frame.
				Transcript show: trs; cr.
				linear := (trs position module2d) * 0.5.
				angular :=4 * ( trs position y arcTan: trs position x).
				handle moveAt:  linear and: angular.	
			] on: Error do: [].

			(Delay forMilliseconds: 100) wait.
		].
	]	
]

{ #category : #algorithms }
DonatelloAlgorithms >> randomHandler [

	^ [ : handle |
		| linear angular |
		
		[ true ] whileTrue: [
			linear := (Random seed: DateAndTime now asUnixTime)  next; next; nextInt:20 + ((Random seed: DateAndTime now asUnixTime)  next; nextInt:9) / 10.
			angular := (Random seed: DateAndTime now asUnixTime)  next;next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9) / 10.
			handle moveAt: linear and: angular. 			
			( (Random seed: DateAndTime now asUnixTime) next; nextInt: 3) seconds asDelay wait.
		].
 	].
]
