Class {
	#name : #PhaROSMergerPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'mergers'
	],
	#category : #'PhaROS-Packages-Merger'
}

{ #category : #'as yet unclassified' }
PhaROSMergerPackage >> finalize [
	super finalize.
	mergers do: #finalize.
]

{ #category : #'as yet unclassified' }
PhaROSMergerPackage >> initialize [ 
	super initialize.
	mergers := Set new.
]

{ #category : #'as yet unclassified' }
PhaROSMergerPackage >> merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation redirectingTo: aTopicPublisher [
	| merger |
	merger := PhaROSMerger new.
	merger merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation redirectingTo: aTopicPublisher.
	mergers add: merger.
	^ merger.
]
