Class {
	#name : #ChaBufferedMultiPortPullPush,
	#superclass : #ChaMultiPortPullPush,
	#instVars : [
		'queue'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'reflective operations' }
ChaBufferedMultiPortPullPush >> doesNotUnderstand: aMessage [
	^queue nextPut: aMessage
]

{ #category : #'initialize-release' }
ChaBufferedMultiPortPullPush >> initialize [
	super initialize.
	queue := SharedQueue new
]

{ #category : #acting }
ChaBufferedMultiPortPullPush >> pullPush [
	super doesNotUnderstand: queue next
]
