Class {
	#name : #PhaROSValue,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSValue >> asString [ 
	| string  |	
		
		
	
	string := self class name, '>>'.
	values keysAndValuesDo:[
		:key :val |
		string := string , key asString, ':', val asString, ' | '.
	].
	string := string, String crlf.
	
	
		
	^ string.
]

{ #category : #'as yet unclassified' }
PhaROSValue >> at:aName put: aValue [
	values at:aName put: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSValue >> getAt:aName [ 
	^ values at: aName.
]

{ #category : #'as yet unclassified' }
PhaROSValue >> initialize [ 
	values := Dictionary new.
	
]

{ #category : #'as yet unclassified' }
PhaROSValue >> printOn: aStream [
	aStream nextPutAll: self asString.
	
]
