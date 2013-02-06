Class {
	#name : #TKTEventualTask,
	#superclass : #TKTTask,
	#instVars : [
		'condition'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTEventualTask class >> for: aBlock at: aPriority when: aConditionalBlock [
	^ (super for: aBlock at: aPriority ) condition: aConditionalBlock; yourself.
]

{ #category : #'as yet unclassified' }
TKTEventualTask class >> for: aBlock when: aConditionalBlock [
	^ self for:aBlock at: Processor systemBackgroundPriority when: aConditionalBlock.
]

{ #category : #'as yet unclassified' }
TKTEventualTask >> cleanup [
	TKTTaskDispatcher it: self.
]

{ #category : #'as yet unclassified' }
TKTEventualTask >> condition: aBlock [ 
	condition := aBlock.
]

{ #category : #'as yet unclassified' }
TKTEventualTask >> expectedFrequency [ 
	" frequency in Hz. 5 checks per second"
 	^ 5
	 
]

{ #category : #'as yet unclassified' }
TKTEventualTask >> initialize [ 
	super initialize.
	self priority: Processor systemBackgroundPriority.
]

{ #category : #'as yet unclassified' }
TKTEventualTask >> value: aFuture [ 
	^ condition value ifTrue: [ super value: aFuture ].
]
