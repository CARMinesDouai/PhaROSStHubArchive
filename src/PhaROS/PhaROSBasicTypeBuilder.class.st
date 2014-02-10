Class {
	#name : #PhaROSBasicTypeBuilder,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'instance creation' }
PhaROSBasicTypeBuilder class >> for: aType [
	^ self new type: aType; yourself.
]

{ #category : #building }
PhaROSBasicTypeBuilder >> build [
	^ type.
]

{ #category : #accessing }
PhaROSBasicTypeBuilder >> type: aType [ 
	type := aType.
]
