Class {
	#name : #PhaROSYamlItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'value'
	],
	#category : #'PhaROSInfrastructure-ROSLaunch'
}

{ #category : #'as yet unclassified' }
PhaROSYamlItem >> name: aName [
	name := aName 
]

{ #category : #'as yet unclassified' }
PhaROSYamlItem >> name: aName value: aValue [
	^ self name: aName ; value: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSYamlItem >> value: aValue [ 
	value := aValue 
	
]

{ #category : #'as yet unclassified' }
PhaROSYamlItem >> yaml [
	^ name, ': ', value asString
]
