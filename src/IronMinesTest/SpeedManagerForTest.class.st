Class {
	#name : #SpeedManagerForTest,
	#superclass : #SpeedManager,
	#category : #IronMinesTest
}

{ #category : #'as yet unclassified' }
SpeedManagerForTest >> newVelocityThread [ 
	^ velocityThread := [ 
	[ 
	self kobuki x: (self kobuki x + (0.01*((self kobuki velocity linear x) * (self kobuki z cos))) ).
	self kobuki y: (self kobuki y + (0.01*((self kobuki velocity linear x) * (self kobuki z sin)) )).
	self kobuki z: (self kobuki z + (0.01*(self kobuki velocity angular z * 1))).
	self kobuki changed .
	(Delay forMilliseconds: 1) wait ] repeat ] newProcess
]
