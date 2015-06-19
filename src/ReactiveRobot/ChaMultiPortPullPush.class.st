Class {
	#name : #ChaMultiPortPullPush,
	#superclass : #ChaMultiPortComponent,
	#instVars : [
		'thread'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'initialize-release' }
ChaMultiPortPullPush >> initialize [
	super initialize.
	thread := ActiveObject repeat: [ self pullPush ].
	thread name: self className.

]

{ #category : #'forwarding-generated' }
ChaMultiPortPullPush >> name: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #thread>

	^thread name: a1 
]

{ #category : #'forwarding-generated' }
ChaMultiPortPullPush >> priority: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #thread>

	^thread priority: a1 
]

{ #category : #acting }
ChaMultiPortPullPush >> pullPush [
	self subclassResponsibility
]

{ #category : #'forwarding-generated' }
ChaMultiPortPullPush >> start [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #thread>

	^thread start
]

{ #category : #'forwarding-generated' }
ChaMultiPortPullPush >> stop [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #thread>

	^thread stop
]
