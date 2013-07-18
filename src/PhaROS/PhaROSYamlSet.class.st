Class {
	#name : #PhaROSYamlSet,
	#superclass : #PhaROSYamlItem,
	#category : #'PhaROS-Launch'
}

{ #category : #'as yet unclassified' }
PhaROSYamlSet >> initialize [ 
	value := Set new.
]

{ #category : #'as yet unclassified' }
PhaROSYamlSet >> property [
	^ value add: PhaROSYamlItem new.
]

{ #category : #'as yet unclassified' }
PhaROSYamlSet >> yaml [ 
	 ^ name, ': {', String crlf,  ((',', String crlf) join: (value collect: #yaml)), String crlf,'}', String crlf
]
