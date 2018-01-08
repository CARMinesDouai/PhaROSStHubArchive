"
I am an abstract controller.
I meanly provide facility methods to create more concrete controllers.
Classe side methods allow creating controllers connected to pre-built bodies such as the ones of robobulab and turtlebot


    Instance Variables
	body:		<Object>


"
Class {
	#name : #BcController,
	#superclass : #Object,
	#instVars : [
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
BcController class >> pureRobulab1 [
	^self body: BcRobulabPure robulab1
]

{ #category : #'instance creation' }
BcController class >> pureRobulab2 [
	^self body: BcRobulabPure robulab2
]

{ #category : #accessing }
BcController >> body [
	^ body
]

{ #category : #accessing }
BcController >> body: anObject [
	body := anObject.

]

{ #category : #living }
BcController >> start [
	self body startUp.
]

{ #category : #living }
BcController >> stop [
	self body shutDown
]
