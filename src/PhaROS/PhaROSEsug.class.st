Class {
	#name : #PhaROSEsug,
	#superclass : #PhaROSPackage,
	#instVars : [
		'controller',
		'launch'
	],
	#classInstVars : [
		'location'
	],
	#category : #'PhaROS-PackageManager'
}

{ #category : #'as yet unclassified' }
PhaROSEsug class >> author [
	^ 'SantiagoBragagnolo'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> create: aLocation [
	location := aLocation .
	PhaROSPackageManager  new create: self 
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> description [
	^' ESUG example package'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> install [
	self error: ' Use install: '.
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> install: aLocation [
	location := aLocation.
	PhaROSPackageManager new install: self  
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> location [
	^ location ifNil:[ self error: 'location is not setted' ].
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> packageName [ 
	^ 'esug'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
PhaROSEsug >> colorIsNotPath: aColor [
^ true "
	^ aColor isNil or: [aColor r = 69 and: [ aColor g = 86 and: [ aColor b = 255 ]]]."
]

{ #category : #'as yet unclassified' }
PhaROSEsug >> drawPharo [

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

{ #category : #'as yet unclassified' }
PhaROSEsug >> make: aHandler moveBasedOn: anOtherHandler [

1 to: 1000 by: 1 do: [ :i |
		(anOtherHandler pose notNil and: [ aHandler pose notNil ]) ifTrue:[
			| trs linear angular |
			trs :=  anOtherHandler pose position - aHandler pose position.
			linear := trs module2d.
			angular :=4 * ( trs y arcTan: trs x).
			
			aHandler moveAt:  angular and: linear.
		 ].
		
		
		1 second asDelay wait.
		
	].
		
]

{ #category : #'as yet unclassified' }
PhaROSEsug >> moveAround: handle [

		1 to: 1000 by: 1 do: [ :i | 
			| linear angular |
			linear := (Random seed: DateAndTime now asUnixTime)  next; next; nextInt:20 + ((Random seed: DateAndTime now asUnixTime)  next; nextInt:9) / 10.
	
			angular := (Random seed: DateAndTime now asUnixTime)  next;next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9) / 10.
	
			handle moveAt: linear and: angular. 	
			
			1 second asDelay wait.
		]
			
		
			
		
	
	
]

{ #category : #'as yet unclassified' }
PhaROSEsug >> scriptTurtlesimPharo [
	|handler|
	"Draws a pharo "
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].

	controller := PhaROSHandleController turtlesim.
	handler := controller nodelets turtlesim defaultTurtleHandler.
	
	handler algorithm: self drawPharo.
	 
	

]

{ #category : #'as yet unclassified' }
PhaROSEsug >> scriptTurtlesimRelatedTurtles [
	| handler handlerTurtle2 |
	"Moves a turtle randomly and a second one based on the behavior of the first one distance"
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].

	controller := PhaROSHandleController turtlesim.
	handler := controller nodelets turtlesim defaultTurtleHandler.
	controller nodelets turtlesim spawnTurtle: 'turtle2'.
	handlerTurtle2 := controller nodelets turtlesim turtleHandleFor: 'turtle2'.
	handler algorithm: [ : aHandle | self moveAround: aHandle ].
	handlerTurtle2 algorithm: [self make: handlerTurtle2 moveBasedOn: handler].
	
	 
	

]

{ #category : #'as yet unclassified' }
PhaROSEsug >> scriptTurtlesimSpiral [
	|handler|
	
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].

	controller := PhaROSHandleController turtlesim.
	handler := controller nodelets turtlesim defaultTurtleHandler.
	
	handler algorithm: [
		1 to: 5 by: 0.2 do: [ :factor |
			handler moveAt:0.5 * factor  and: 10 /factor.
			0.5 seconds asDelay wait.
		].
	].
	 
	

]
