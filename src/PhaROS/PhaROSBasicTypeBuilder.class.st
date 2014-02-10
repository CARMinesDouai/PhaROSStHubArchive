"
This builder is a polimorfic object that allow us to have a builder that do not build, for the basic types, as Uint, etc.
"
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
