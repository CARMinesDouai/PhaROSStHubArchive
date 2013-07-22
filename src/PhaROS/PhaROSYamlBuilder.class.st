Class {
	#name : #PhaROSYamlBuilder,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'PhaROS-Launch'
}

{ #category : #'as yet unclassified' }
PhaROSYamlBuilder >> initialize [ 
	properties := OrderedCollection  new
]

{ #category : #'as yet unclassified' }
PhaROSYamlBuilder >> name: aName value: aValue [
	properties add: (PhaROSYamlItem new name: aName value: aValue; yourself ).
]

{ #category : #'as yet unclassified' }
PhaROSYamlBuilder >> set: aSetName with: aBlockBuilder [
	aBlockBuilder value: (properties add: (PhaROSYamlSet new name:aSetName ; yourself )).
]

{ #category : #'as yet unclassified' }
PhaROSYamlBuilder >> writeFile: aFileName [
	 (StandardFileStream forceNewFileNamed: aFileName) nextPutAll: self yaml; close. 
]

{ #category : #ysml }
PhaROSYamlBuilder >> yaml [
	^String crlf join: (properties collect: #yaml)
]
