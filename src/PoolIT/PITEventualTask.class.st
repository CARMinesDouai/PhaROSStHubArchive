Class {
	#name : #PITEventualTask,
	#superclass : #TKTTask,
	#instVars : [
		'condition'
	],
	#category : #'PoolIT-Tasks'
}

{ #category : #'as yet unclassified' }
PITEventualTask class >> for: aBlock at: aPriority when: aConditionalBlock [
	^ (super for: aBlock at: aPriority ) condition: aConditionalBlock; yourself.
]

{ #category : #'as yet unclassified' }
PITEventualTask class >> for: aBlock when: aConditionalBlock [
	^ self for:aBlock at: Processor systemBackgroundPriority when: aConditionalBlock.
]

{ #category : #'as yet unclassified' }
PITEventualTask >> cleanup [
	PITWorkersPool it: self.
]

{ #category : #'as yet unclassified' }
PITEventualTask >> condition: aBlock [ 
	condition := aBlock.
]

{ #category : #'as yet unclassified' }
PITEventualTask >> expectedFrequency [ 
	" frequency in Hz. 5 checks per second"
 	^ 5
	 
]

{ #category : #'as yet unclassified' }
PITEventualTask >> initialize [ 
	super initialize.
	self priority: Processor systemBackgroundPriority.
]

{ #category : #'as yet unclassified' }
PITEventualTask >> runOnRunner: aRunner withFuture: aFuture [

	condition value ifTrue: [  .super runOnRunner: aRunner withFuture: aFuture ].
]
