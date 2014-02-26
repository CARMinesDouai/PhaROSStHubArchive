Class {
	#name : #PhaROSActionEntity,
	#superclass : #Object,
	#instVars : [
		'input',
		'output',
		'name'
	],
	#category : #'PhaROS-Nodelets-Action'
}

{ #category : #'as yet unclassified' }
PhaROSActionEntity >> inputTopicDefinition [
	^ { #name ->  '/', name, '/input' . #type -> 'pharos/Action' } 
]

{ #category : #'as yet unclassified' }
PhaROSActionEntity >> outputTopicDefinition [
	^ { #name ->  '/', name, '/output' . #type -> 'pharos/Action' } 
]
