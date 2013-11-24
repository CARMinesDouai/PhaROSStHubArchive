Class {
	#name : #PhaROSEsug,
	#superclass : #PhaROSPackage,
	#instVars : [
		'launch'
	],
	#category : #'PhaROSInfrastructure-Package'
}

{ #category : #'as yet unclassified' }
PhaROSEsug class >> author [
	^ 'SantiagoBragagnolo'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> dependencies [
	^ super dependencies,  {
		PhaROSPackageDependency controller .
		PhaROSPackageDependency turtlesim .
		PhaROSPackageDependency tf 
	}
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> description [
	^' ESUG example package'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> packageName [ 
	^ 'esug'
]

{ #category : #'as yet unclassified' }
PhaROSEsug class >> version [
	^ '0.1.0'
]

{ #category : #private }
PhaROSEsug >> colorIsNotPath: aColor [
^ true "
	^ aColor isNil or: [aColor r = 69 and: [ aColor g = 86 and: [ aColor b = 255 ]]]."
]

{ #category : #private }
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

{ #category : #private }
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

{ #category : #private }
PhaROSEsug >> make: aHandler pursuit: anOtherHandler [
	
	1 to: 4000 by: 1 do: [ :i |
		[
		"(anOtherHandler pose notNil and: [ aHandler pose notNil ]) ifTrue:["
			| trs linear angular |
			trs :=  self controller nodelets transformation transformBetween: anOtherHandler  frame and: aHandler  frame.
			Transcript show: trs; cr.
			linear := (trs position module2d) * 0.5.
			angular :=4 * ( trs position y arcTan: trs position x).
			
			aHandler moveAt:  linear and: angular.
	"	 ]."
				
	] on: Error do: [ :e |  ].
	(Delay forMilliseconds: 100) wait.
].
		
]

{ #category : #private }
PhaROSEsug >> moveAround: handle [

		1 to: 1000 by: 1 do: [ :i | 
			| linear angular |
			linear := (Random seed: DateAndTime now asUnixTime)  next; next; nextInt:20 + ((Random seed: DateAndTime now asUnixTime)  next; nextInt:9) / 10.
	
			angular := (Random seed: DateAndTime now asUnixTime)  next;next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9) / 10.
	
			handle moveAt: linear and: angular. 	
			
			1 second asDelay wait.
		]
			
		
			
		
	
	
]

{ #category : #scripts }
PhaROSEsug >> scriptTurtlesimPharo [
	|handler|
	
	"
		 The idea of this example is to show how to:
		
		1- spawn a roslaunch from the node. 
		2- create a  PhaROSHandleController, which is the entry point to ROS world.
		3- use a nodelet that was configured by the constructor. 
		4- create a turtle handler.
		5- easyly move the turtle around the ground.
	"
	
	
	"
		Launch message receives a block with a specification as parameter. To go deeper browse #PhaROSLaunchBuilder
	"
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].

	"
		A Controller is an object that build a base and unique node which represent the input and output of information between this image and ROS world
	"
	
	self controller.
	
	"
		In order to add behavior to a node we have the concept of Nodelet, (which is  similar to the ROS nodelet, because it runs without communication cost in between inner nodelets, 
		but also encourage to make small units of behavior, in order to be able to reuse, and since the code is all available in the same image is far easier to browse and understand the relation. 
		To know more about which nodelets we have, you can browse the category PhaROS-Nodelets, starting for PhaROSNodelet and PhaROSNodeletContainer.  .
		In this case, turtlesim constructor adds turtlesim nodelet into the nodelet repository. 
	"
	
	
	handler := self controller nodelets turtlesim defaultTurtleHandler.
	handler algorithm: self drawPharo.
	
	"
		The block sent as algorithm to the Turtle handler it will be executed in other thread.
	"	 
	

]

{ #category : #scripts }
PhaROSEsug >> scriptTurtlesimPursuitTurtles [
	| handler handlerTurtle2 |
	
	"
		The idea of this example is to show how to:
		
		1- spawn a second turtle 
		2- spawn a related controller
		3- broadcast tf information related with the turtles
		4- consume tf information. 
		
	"
	
	launch := PhaROSSystemLauncher instance launch: [
		:spec | 
		spec turtlesim.	
	].


	
	handler := self controller nodelets turtlesim defaultTurtleHandler.
	
	
	
	" 
		This following method is based in a command, because services are not yet completely reificated. It spawns a turtle using rosservice command 
	"
	
	self controller nodelets turtlesim spawnTurtle: 'turtle2'.
	handlerTurtle2 := self controller nodelets turtlesim turtleHandleFor: 'turtle2'.
	
	"
		tf messages, one per each turtle-handler, rely on a PhaROSPoseToTFNodelet object, which is an excelent example to show how nice the nodelets are.  This nodelet, based on the Pose that the turtle inform, broadcast tf information in the proper frame. 
	"
	handler tf.
	handlerTurtle2 tf.
	
	
	
	"
		The algorithm of the first turtle is an easy turtle driver, that sends the turtle to different places applying linear and angular speed randomly. 
	"
	
	handler algorithm: [ : aHandle | self moveAround: aHandle ].
	
	"
		The algorithm of the second turtle is an example about how to use  pharos TF library in order to get distances and transformations. Based on that the second turtle will pursuit the firstone. 
		This example is based on the turtle_tf example. 
	"
	
	handlerTurtle2 algorithm: [self make: handlerTurtle2 pursuit: handler].
	
	 "
	controller nodelets transformation between: '/turtle2' and: '/turtle1' for: [ : p | Transcript show: p; cr. ]
	"


]
