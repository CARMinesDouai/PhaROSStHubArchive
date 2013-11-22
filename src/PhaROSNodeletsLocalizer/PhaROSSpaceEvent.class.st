Class {
	#name : #PhaROSSpaceEvent,
	#superclass : #Object,
	#instVars : [
		'condition',
		'action',
		'manager'
	],
	#category : #PhaROSNodeletsLocalizer
}

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> action: anActionBlock [ 	
	action  := anActionBlock.
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> apply: aLocalizerMeasure [
	(condition value: aLocalizerMeasure ) ifTrue: [
		self executeAction: aLocalizerMeasure.
		
	].

]

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> cancel [ 
	manager remove: self.
	condition := [ :lm | false ]. 
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> condition: aConditionBlock [
	condition := aConditionBlock 
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> executeAction: aLocalizerMeasure [ 
	action cull: aLocalizerMeasure.	
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> manager: aPhaROSSpaceEventManager [ 
	manager := aPhaROSSpaceEventManager 
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEvent >> rescheddule [
	manager rescheddule: self.
]
