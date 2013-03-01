Class {
	#name : #BoCounterResourceForTest,
	#superclass : #TestResource,
	#instVars : [
		'count'
	],
	#category : #'BoTest-Kernel-Test'
}

{ #category : #accessing }
BoCounterResourceForTest >> count [
	^ count
]

{ #category : #accessing }
BoCounterResourceForTest >> count: anObject [
	count := anObject
]

{ #category : #accessing }
BoCounterResourceForTest >> increment [
	self count: self count + 1
]

{ #category : #running }
BoCounterResourceForTest >> setUp [
	super setUp.
	self count: 0
]
