Class {
	#name : #BoCounterForTest,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#classInstVars : [
		'current'
	],
	#category : #'BoTest-Kernel-Test'
}

{ #category : #accessing }
BoCounterForTest class >> current [
	^current ifNil: [current := self new]
]

{ #category : #accessing }
BoCounterForTest class >> reset [
	^current := nil
]

{ #category : #accessing }
BoCounterForTest >> count [
	^ count
]

{ #category : #accessing }
BoCounterForTest >> count: anObject [
	count := anObject
]

{ #category : #accessing }
BoCounterForTest >> increment [
	self count: self count + 1
]

{ #category : #running }
BoCounterForTest >> initialize [
	super initialize.
	self count: 0
]
