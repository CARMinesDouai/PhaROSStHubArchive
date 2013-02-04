Class {
	#name : #TKTTask,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTTask class >> for: aBlock [ 
	^ self new block: aBlock ; yourself .
]

{ #category : #'as yet unclassified' }
TKTTask >> block: aBlock [
	block := aBlock.
]

{ #category : #'as yet unclassified' }
TKTTask >> execute [
	self setUp.
	[
		[
			self announce: ( block cull: self ).
		] on: Error do: [ 
			: exception |
			self fallback: exception.
		]
	] ensure: [
		self tearDown.
	].
]

{ #category : #'as yet unclassified' }
TKTTask >> fallback: anError [
]

{ #category : #'as yet unclassified' }
TKTTask >> setUp [
]

{ #category : #'as yet unclassified' }
TKTTask >> tearDown [
]
