Class {
	#name : #ChaAnd,
	#superclass : #ChaPrimitiveMultiPortWatcher,
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #acting }
ChaAnd >> newOutputFrom: input [
	input ifFalse: [ ^false ].
	^self watchedPorts allSatisfy: [ : port | port data ifNil: [ ^false ] ]
]
