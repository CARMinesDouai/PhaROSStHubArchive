Class {
	#name : #TKTTask,
	#superclass : #Object,
	#instVars : [
		'block',
		'priority'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTTask class >> for: aBlock [ 
	^ self for: aBlock at: Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
TKTTask class >> for: aBlock at: aPriority [ 
	^ self new block: aBlock; priority: aPriority  ; yourself .
]

{ #category : #sorting }
TKTTask >> < aTKTTask [ 
	^ priority < aTKTTask priority.
]

{ #category : #sorting }
TKTTask >> > aTKTTask [ 
	^ priority > aTKTTask priority.
]

{ #category : #'as yet unclassified' }
TKTTask >> asTask [ 
	^ self.
]

{ #category : #'as yet unclassified' }
TKTTask >> block: aBlock [
	block := aBlock.
]

{ #category : #sorting }
TKTTask >> doIt [

	| future |
	future := TKTStickyFuture new.
	
	future process:( [
		self value: future.
	] forkAt: self priority named: 'Task').

	^ future.
]

{ #category : #'as yet unclassified' }
TKTTask >> fallback: anError [
	
]

{ #category : #'as yet unclassified' }
TKTTask >> priority [
	^ priority .
]

{ #category : #'as yet unclassified' }
TKTTask >> priority: aPriority [
	priority := aPriority.
]

{ #category : #'as yet unclassified' }
TKTTask >> setUp [
]

{ #category : #'as yet unclassified' }
TKTTask >> tearDown [
]

{ #category : #'as yet unclassified' }
TKTTask >> value [
	" The future is dispendable in this case, cause is executing in the same thread "
	^ self value: TKTFuture new.
]

{ #category : #'as yet unclassified' }
TKTTask >> value: aFuture [ 
	| value | 
	self setUp.
	[
		[
			value :=  ( block cull: self ). 
		] on: Error do: [ 
			: exception |
			self fallback: exception.
			aFuture deployError: exception.
		]
	] ensure: [
		self tearDown.
	].
	aFuture deployValue: value.
	
	^ value.
]
