Class {
	#name : #ChaAnd,
	#superclass : #ChaPrimitiveMultiPortWatcher,
	#category : #'ReactiveRobot-01-EmergencyStop'
}

{ #category : #acting }
ChaAnd >> newOutputFrom: input [
	input ifFalse: [ ^false ].
	^self watchedPorts allSatisfy: [ : port | port data ifNil: [ ^false ] ]
]
