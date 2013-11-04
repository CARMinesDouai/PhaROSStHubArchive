Class {
	#name : #TKTConsumableEventualTask,
	#superclass : #TKTEventualTask,
	#instVars : [
		'instances'
	],
	#category : #'TaskIT-Tasks'
}

{ #category : #'as yet unclassified' }
TKTConsumableEventualTask class >> for: aBlock when: aConditionalBlock for: nTimes [
	^ (self for: aBlock when: aConditionalBlock) instances: nTimes; yourself.
]

{ #category : #'as yet unclassified' }
TKTConsumableEventualTask >> cleanup [
	instances > 0 ifTrue: [
		TKTTaskDispatcher it: self.
	].
]

{ #category : #'as yet unclassified' }
TKTConsumableEventualTask >> instances: nTimes [
	instances := nTimes. 
]

{ #category : #'as yet unclassified' }
TKTConsumableEventualTask >> value: aFuture [ 
	instances > 0 ifTrue: [ 
		^ condition value ifTrue: [ 
			super value: aFuture.
			instances := instances - 1.
		]
	].
]
