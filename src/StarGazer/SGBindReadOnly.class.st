Class {
	#name : #SGBindReadOnly,
	#superclass : #SGBind,
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGBindReadOnly >> value: aValue [
	SGError signal: 'Read only property'.
]
