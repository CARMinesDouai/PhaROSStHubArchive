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
	
	^ algorithms at: aCommand asLowercase  ifAbsent: [ 
		self idleHandler.	
	 ]
	
]

{ #category : #algorithms }
DonatelloAlgorithms >> circularHandler [ 

^ [ : handler |
		handler forwardAt: 1.0.
		1 seconds asDelay wait.
		[  true ] whileTrue: [
			handler moveAt: 0.4 and: 1.0.
			1 seconds asDelay wait.
		].
	].
]

{ #category : #algorithms }
DonatelloAlgorithms >> idleHandler [ 

^ [ : handler | 
	
	[ true ] whileTrue: [ 	
		handler forwardAt: 0.0.
		1 hz wait.
	].
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
	
	^ [ : handle : nodelet | 
		| default  |
		
		default := nodelet chooseAnObjectiveForPursuitFor: handle.
		handle tf.
		default tf.
		
		
		[ true ] whileTrue: [
			| trs linear angular |
			[			
				trs :=  handle transformationTo: default.
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
		| linear angular random sign|
		
		random := (Random seed: DateAndTime now asUnixTime).
		sign := 1.
		
		[ true ] whileTrue: [
			(random nextInt: 20) even ifTrue: [
				random := (Random seed: DateAndTime now asUnixTime).
			] ifFalse: [ 
				sign := sign * -1.
			 ].
			
			
			linear := (random next; next; nextInt:20 )+((random nextInt:9)) / 10.
			angular := (random next;next; next; nextInt:9) + (random  next; next; nextInt:9) / 10.
			
			linear := linear * sign. 
			angular := angular * sign * -1.
			
			handle moveAt: linear and: angular. 			
			( (Random seed: DateAndTime now asUnixTime) next; nextInt: 3) seconds asDelay wait.
		].
 	].
]
