Class {
	#name : #ChaConcurrentAnd,
	#superclass : #ChaDefaultOutputComponent,
	#traits : 'TChaDefaultInputComponent + TChaMultiPortWatcher',
	#classTraits : 'TChaDefaultInputComponent classTrait + TChaMultiPortWatcher classTrait',
	#instVars : [
		'pullPush',
		'and'
	],
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #'initialize-release' }
ChaConcurrentAnd >> initialize [
	super initialize.
	pullPush := ChaOverwritingPullPush new.
	and := ChaAnd new.
	pullPush=>and.
	outputPort := and outputPort
]

{ #category : #'forwarding-generated' }
ChaConcurrentAnd >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush input: a1 
]

{ #category : #'forwarding-generated' }
ChaConcurrentAnd >> name: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush name: a1 
]

{ #category : #'forwarding-generated' }
ChaConcurrentAnd >> priority: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush priority: a1 
]

{ #category : #'forwarding-generated' }
ChaConcurrentAnd >> start [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush start
]

{ #category : #'forwarding-generated' }
ChaConcurrentAnd >> stop [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #pullPush>

	^pullPush stop
]

{ #category : #'forwarding-generated' }
ChaConcurrentAnd >> watchedPorts: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #and>

	^and watchedPorts: a1 
]
