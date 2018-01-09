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
BcController class >> pureRobulab1 [
	^self body: BcRobulabPure robulab1 runnerClass: BcSingleThreadRunner
]

{ #category : #'instance creation' }
BcController class >> pureRobulab2 [
	^self body: BcRobulabPure robulab2 runnerClass: BcSingleThreadRunner
]

{ #category : #living }
BcController >> act [
	^self
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

{ #category : #living }
BcController >> plan [
	^self
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
BcController >> sense [
	^self
]

{ #category : #living }
BcController >> start [
	self body startUp.
	self runner start.
]

{ #category : #living }
BcController >> stop [
	self body shutDown
]
