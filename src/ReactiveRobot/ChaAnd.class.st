Class {
	#name : #ChaAnd,
	#superclass : #ChaMultiPortWatcher,
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #acting }
ChaAnd >> newOutputFrom: input [
	input ifFalse: [ ^false ].
	^self watchedPorts allSatisfy: [ : port | port data ifNil: [ ^false ] ]
]
