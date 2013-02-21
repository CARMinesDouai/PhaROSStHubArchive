Class {
	#name : #BoCounterTestResource,
	#superclass : #TestResource,
	#instVars : [
		'counter'
	],
	#category : #'BoTest-Kernel-Test'
}

{ #category : #accessing }
BoCounterTestResource >> counter [
	^ counter
]

{ #category : #accessing }
BoCounterTestResource >> counter: anObject [
	counter := anObject
]

{ #category : #running }
BoCounterTestResource >> setUp [
	super setUp.
	self counter: 0
]
