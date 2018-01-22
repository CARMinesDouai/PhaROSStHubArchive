"
I represent a controller for an autonomous. I am in charge of a robot behavior. That is:
- sensing: extracting an model of the world  from sensed data, 
- planning: deciding what to do and when to do it
- acting: performing deciding actions 

I am the facade (Face design pattern) for all objects to make a robot. This includes (but not limited to) instance Variables
	body:		<BcBody>  Driver to the robot body.  Gives access to sensors and actuators.
	runner:		<BcRunner>  manages my control flow i.e. the threading model and when sensing, planning, and acting are performed an in which order if any.

I am an abstract class. Subclasses should:
-define some behavior (sensing, planning, acting)
-implement class-side method defaultRunner

Public API and Key Messages
- start 
Brings up the robot to life, i.e. start sensing the world and behaving autonomously
- stop
Tears down the robot. Ensures that body is swiched off.
- body: aBcBody runnerClass: aBcRunnerClass
Creates a ready to use controller with a given body. The runner is instantiated from the given runner class
- pureRobulab1
Creates a ready to use controller for Robulab-1 over the Pure middleware using the default runner.
- pureRobulab2
Creates a ready to use controller for Robulab-1 over the Pure middleware using the default runner.

"
Class {
	#name : #BcController,
	#superclass : #Object,
	#instVars : [
		'runner',
		'body'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcController class >> body: aBcBody [
	^self new
		body: aBcBody;
		yourself
]

{ #category : #'instance creation' }
BcController class >> body: aBcBody runnerClass: aRunnerClass [
	^(self body: aBcBody)
		runnerClass: aRunnerClass;
		yourself
]

{ #category : #'instance creation' }
BcController class >> defaultRunnerClass [
	self subclassResponsibility
]

{ #category : #'instance creation' }
BcController class >> pureRobulab1 [
	^ self
		body: BcRobulabPure robulab1
		runnerClass: self defaultRunnerClass
]

{ #category : #'instance creation' }
BcController class >> pureRobulab2 [
	^ self
		body: BcRobulabPure robulab2
		runnerClass: self defaultRunnerClass
]

{ #category : #accessing }
BcController >> body [
	^ body
]

{ #category : #accessing }
BcController >> body: anObject [
	body := anObject.

]

{ #category : #'initialize-release' }
BcController >> newAction: behaviorClass [
	^behaviorClass controller: self
]

{ #category : #'initialize-release' }
BcController >> newRunner: runnerClass [
	^runnerClass controller: self
]

{ #category : #accessing }
BcController >> runner [
	^ runner
]

{ #category : #accessing }
BcController >> runner: anObject [
	runner := anObject
]

{ #category : #'initialize-release' }
BcController >> runnerClass: runnerClass [
	self runner: (self newRunner: runnerClass)
]

{ #category : #living }
BcController >> start [
	self body startUp.
	self runner start.
]

{ #category : #living }
BcController >> stop [
	self body shutDown.
	self runner stop.

]
