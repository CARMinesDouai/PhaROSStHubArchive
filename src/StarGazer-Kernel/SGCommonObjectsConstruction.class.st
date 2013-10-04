Class {
	#name : #SGCommonObjectsConstruction,
	#superclass : #TestCase,
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGCommonObjectsConstruction >> testConstructAPoint [
	| point |
	point := SGPoint x: 1 y:2  z:3. 
	
	self assert: point x = 1.
	self assert: point y = 2.
	self assert: point z = 3.
]

{ #category : #'as yet unclassified' }
SGCommonObjectsConstruction >> testConstructAPose [
	| pose point |
	pose := SGPose x: 1 y:2  z:3 o: 4. 
	point := pose position. 
	
	self assert: point x = 1.
	self assert: point y = 2.
	self assert: point z = 3.
	
	self assert: pose orientation = 4.
]
