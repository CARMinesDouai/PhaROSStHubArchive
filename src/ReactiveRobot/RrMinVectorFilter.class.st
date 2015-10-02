Class {
	#name : #RrMinVectorFilter,
	#superclass : #ChaDefaultInOutComponent,
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrMinVectorFilter >> initialize [
	super initialize.
	outputPort set: VeVector zero
]

{ #category : #acting }
RrMinVectorFilter >> newOutputFrom: vectors [
	| sortedVectors |
	vectors ifEmpty: [^VeVector zero].	
	sortedVectors := vectors asSortedCollection: [ : v1 : v2 | v1 length < v2 length ].
	^sortedVectors first
]
