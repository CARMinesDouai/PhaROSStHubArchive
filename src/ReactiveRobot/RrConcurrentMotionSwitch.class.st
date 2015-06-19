Class {
	#name : #RrConcurrentMotionSwitch,
	#superclass : #ChaDefaultOutputComponent,
	#traits : 'TChaDefaultInputComponent',
	#classTraits : 'TChaDefaultInputComponent classTrait',
	#instVars : [
		'pullPush',
		'switch'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'instance creation' }
RrConcurrentMotionSwitch class >> at: distance [
	^self new
		stopDistance: distance;
		yourself
]

{ #category : #'initialize-release' }
RrConcurrentMotionSwitch >> initialize [
	super initialize.
	pullPush := ChaOverwritingPullPush new.
	switch := RrMotionSwitch new.
	pullPush=>switch.
	outputPort := switch outputPort
]

{ #category : #'forwarding-generated' }
RrConcurrentMotionSwitch >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush input: a1 
]

{ #category : #'forwarding-generated' }
RrConcurrentMotionSwitch >> name: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush name: a1 
]

{ #category : #'forwarding-generated' }
RrConcurrentMotionSwitch >> priority: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush priority: a1 
]

{ #category : #'forwarding-generated' }
RrConcurrentMotionSwitch >> start [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush start
]

{ #category : #'forwarding-generated' }
RrConcurrentMotionSwitch >> stop [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush stop
]

{ #category : #'forwarding-generated' }
RrConcurrentMotionSwitch >> stopDistance: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #switch>

	^switch stopDistance: a1 
]
