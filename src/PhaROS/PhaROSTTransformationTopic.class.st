Class {
	#name : #PhaROSTTransformationTopic,
	#superclass : #Object,
	#instVars : [
		'launch',
		'from',
		'to',
		'callback',
		'rosnode'
	],
	#category : #'PhaROS-Nodelets-TFAAS'
}

{ #category : #'as yet unclassified' }
PhaROSTTransformationTopic >> callback: aCallback [
	callback := aCallback.
]

{ #category : #'as yet unclassified' }
PhaROSTTransformationTopic >> for: aCallback [ 
	
]

{ #category : #'as yet unclassified' }
PhaROSTTransformationTopic >> from: aFrame to: anOtherFrame [
	from := aFrame.
	to := anOtherFrame.
]

{ #category : #'as yet unclassified' }
PhaROSTTransformationTopic >> launch [
	launch ifNil: [
		launch := PhaROSSystemLauncher instance launch: [: l | l tfaas: from to:to rate: self rate ].
	].


]
