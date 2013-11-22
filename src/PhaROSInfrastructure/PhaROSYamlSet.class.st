Class {
	#name : #PhaROSYamlSet,
	#superclass : #PhaROSYamlItem,
	#category : #'PhaROSInfrastructure-ROSLaunch'
}

{ #category : #'as yet unclassified' }
PhaROSYamlSet >> initialize [ 
	value := OrderedCollection  new.
]

{ #category : #'as yet unclassified' }
PhaROSYamlSet >> property [
	^ value add: PhaROSYamlItem new.
]

{ #category : #'as yet unclassified' }
PhaROSYamlSet >> yaml [ 
	 ^ name, ': {', String crlf,  ((',', String crlf) join: (value collect: [ :i | '        ', i yaml ])), String crlf,'}', String crlf
]
