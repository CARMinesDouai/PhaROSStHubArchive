Class {
	#name : #RrMaxVectorFilter,
	#superclass : #ChaDefaultInOutComponent,
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrMaxVectorFilter >> initialize [
	super initialize.
	outputPort set: VeVector zero
]

{ #category : #acting }
RrMaxVectorFilter >> newOutputFrom: vectors [
	| max |
	vectors ifEmpty: [^VeVector zero].	
	max := vectors first.
	vectors do: [ : v | v length > max length ifTrue: [max := v]].
	^max
]
