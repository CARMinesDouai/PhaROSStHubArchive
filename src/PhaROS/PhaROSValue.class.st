"
A PhaROSValue is a Value that has it definition in a dictionary. Is used as super class of all the generated classes related with  types.
"
Class {
	#name : #PhaROSValue,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'PhaROS-Types'
}

{ #category : #'as yet unclassified' }
PhaROSValue >> asString [ 
	| string  |	
		
	
	string := self class name, '>>', String crlf, String tab.
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
PhaROSValue >> closeTo: anOtherValue [

	^ (self class = anOtherValue class) and:[
		| allSatisfy|
		
		allSatisfy := true. 
		values keysAndValuesDo: [ :key : val | allSatisfy := allSatisfy and: [val closeTo: (anOtherValue getAt: key)]. ].
		allSatisfy.
	].
]

{ #category : #'as yet unclassified' }
PhaROSValue >> getAt:aName [ 
	^ values at: aName.
]

{ #category : #'as yet unclassified' }
PhaROSValue >> hasAttribute: aName [ 
	^ values includesKey: aName.
]

{ #category : #'as yet unclassified' }
PhaROSValue >> initialize [ 
	values := Dictionary new.
	
]

{ #category : #'as yet unclassified' }
PhaROSValue >> isBasic [
	^ false. 
]

{ #category : #'as yet unclassified' }
PhaROSValue >> printOn: aStream [
	aStream nextPutAll: self asString.
	
]
