Class {
	#name : #PITConsumableEventualTask,
	#superclass : #PITEventualTask,
	#instVars : [
		'instances'
	],
	#category : #'PoolIT-Tasks'
}

{ #category : #'as yet unclassified' }
PITConsumableEventualTask class >> for: aBlock when: aConditionalBlock for: nTimes [
	^ (self for: aBlock when: aConditionalBlock) instances: nTimes; yourself.
]

{ #category : #'as yet unclassified' }
PITConsumableEventualTask >> cleanup [
	instances > 0 ifTrue: [
		PITWorkersPool it: self.
	].
]

{ #category : #'as yet unclassified' }
PITConsumableEventualTask >> instances: nTimes [
	instances := nTimes. 
]

{ #category : #'as yet unclassified' }
PITConsumableEventualTask >> runOnRunner: aRunner withFuture: aFuture [

	instances > 0 ifTrue: [ 
		condition value ifTrue: [ 
			super runOnRunner: aRunner withFuture: aFuture.
			instances := instances - 1.
		]
	].
]
