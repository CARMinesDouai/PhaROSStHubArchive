Class {
	#name : #PhaROSMergerNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'mergers'
	],
	#category : #'PhaROS-Nodelets-Merger'
}

{ #category : #'as yet unclassified' }
PhaROSMergerNodelet >> finalize [
	super finalize.
	mergers do: #finalize.
]

{ #category : #'as yet unclassified' }
PhaROSMergerNodelet >> initialize [ 
	super initialize.
	mergers := Set new.
]

{ #category : #'as yet unclassified' }
PhaROSMergerNodelet >> merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation redirectingTo: aTopicPublisher [
	| merger |
	merger := PhaROSMerger new.
	merger merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation redirectingTo: aTopicPublisher.
	mergers add: merger.
	^ merger.
]

{ #category : #'as yet unclassified' }
PhaROSMergerNodelet >> merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation when: aCondition redirectingTo: aTopicPublisher [
	| merger |
	merger := PhaROSMerger new.
	merger merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation  when: aCondition redirectingTo: aTopicPublisher.
	mergers add: merger.
	^ merger.
]
