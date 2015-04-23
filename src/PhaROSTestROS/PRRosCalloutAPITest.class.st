"
These tests are for the ROS Callout API.
They depend on the tests in PRRosCalloutTest.
The only place that a direct OSProcess call is done is in testPeek, needed for bootstrapping. All the rest of the tests are only in function of the API itself.

"
Class {
	#name : #PRRosCalloutAPITest,
	#superclass : #TestCase,
	#instVars : [
		'resource'
	],
	#category : #'PhaROSTestROS-SimpleAPI'
}

{ #category : #accessing }
PRRosCalloutAPITest class >> resources [
	 ^{ PRSimpleAPIResource }
]

{ #category : #utility }
PRRosCalloutAPITest >> isTurtleAt: aCoordArray [
	self isTurtleAt: aCoordArray forPeekString:  (PRRosCalloutAPI peek: '/turtle1/pose').
]

{ #category : #utility }
PRRosCalloutAPITest >> isTurtleAt: aCoordArray forPeekString: aPeekString [
	| aPeekResult |
	aPeekResult := resource build: 5 associationsFrom: (resource tokenizeString: aPeekString).
	
	self assert: aPeekResult size = aCoordArray size.

	self assert: (aPeekResult at: 1 ) key = 'x:'.
	self assert: (Float readFrom: ((aPeekResult at: 1 ) value)) = (aCoordArray at: 1).

	self assert: (aPeekResult at: 2 ) key = 'y:'.
	self assert: (Float readFrom: ((aPeekResult at: 2 ) value)) = (aCoordArray at: 2).

	self assert: (aPeekResult at: 3 ) key = 'theta:'.
	self assert: (Float readFrom: ((aPeekResult at:  3) value)) = (aCoordArray at: 3).
		
	self assert: (aPeekResult at: 4 ) key = 'linear_velocity:'.
	self assert: (Float readFrom: ((aPeekResult at: 4) value)) = (aCoordArray at: 4).
	
	self assert: (aPeekResult at: 5 ) key = 'angular_velocity:'.
	self assert: (Float readFrom: ((aPeekResult at: 5 ) value)) = (aCoordArray at: 5).

]

{ #category : #utility }
PRRosCalloutAPITest >> isTurtleAtOrigin [
	
	self isTurtleAt: { 5.544444561 . 5.544444561 . 0.0 . 0.0 . 0.0 }.
]

{ #category : #running }
PRRosCalloutAPITest >> setUp [

	"Make sure the resource is available i.e. the ROS nodes have been started, and keep it"
	resource := self resources first current.
]

{ #category : #services }
PRRosCalloutAPITest >> testCall [

	"tests both call variants"
	PRRosCalloutAPI call: '/turtle1/teleport_absolute' withArgs: ' "x: 1.0 \y: 2.0 \theta: 3.0 " ' withCRs.
	
	self isTurtleAt: { 1.0 . 2.0 . 3.0 . 0.0 . 0.0 }.
	
	PRRosCalloutAPI call: '/reset'. 
	
	self isTurtleAtOrigin


]

{ #category : #'publish-subscribe' }
PRRosCalloutAPITest >> testPeek [

	" The *only* OSProcess callout in this TestCase "
	OSProcess waitForCommand: ' rosservice call /reset'.
	"this actually does the peek and asserts the results are correct"
	self isTurtleAtOrigin.
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPITest >> testPublish [
	| msg  |
	
	PRRosCalloutAPI call: '/reset'.

	msg :=
'"linear:
  x: 2.0
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 1.8"'.
	
	PRRosCalloutAPI publish: msg ofType: 'geometry_msgs/Twist' on: '/turtle1/cmd_vel'.

	self isTurtleAt: { 6.60281658173 . 6.93898963928 .  1.81439995766 . 0.0 . 0.0 }.

]

{ #category : #'publish-subscribe' }
PRRosCalloutAPITest >> testSubscribe [
	| subscription |
	
	PRRosCalloutAPI call: '/reset'.
	
	subscription := PRRosCalloutAPI subscribeTo: '/turtle1/pose'.
	
	[subscription value isNil] whileTrue: [Processor yield].

	self isTurtleAt: { 5.544444561 . 5.544444561 . 0.0 . 0.0 . 0.0 } forPeekString: subscription value .
	
	PRRosCalloutAPI call: '/turtle1/teleport_absolute' withArgs: ' "x: 1.0 \y: 2.0 \theta: 3.0 " ' withCRs.
	"wait until we are sure the movement has been made"
	1 second wait.
	self isTurtleAt: { 1.0 . 2.0 . 3.0 . 0.0 . 0.0 } forPeekString: subscription value.
	
	PRRosCalloutAPI unsubscribe: subscription.

]
