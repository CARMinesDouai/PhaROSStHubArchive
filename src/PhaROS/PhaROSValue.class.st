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

{ #category : #converting }
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

{ #category : #accessing }
PhaROSValue >> associations [
	^values associations
]

{ #category : #accessing }
PhaROSValue >> at:aName put: aValue [
	values at:aName put: aValue.
]

{ #category : #accessing }
PhaROSValue >> closeTo: anOtherValue [

	^ (self class = anOtherValue class) and:[
		| allSatisfy|
		
		allSatisfy := true. 
		values keysAndValuesDo: [ :key : val | allSatisfy := allSatisfy and: [val closeTo: (anOtherValue getAt: key)]. ].
		allSatisfy.
	].
]

{ #category : #accessing }
PhaROSValue >> getAt:aName [ 
	^ values at: aName.
]

{ #category : #'gt-inspector-extension' }
PhaROSValue >> gtInspectorItemsIn: composite [
        <gtInspectorPresentationOrder: 0>
        ^ (composite table)
                title: 'Values';
                display: [ self associations ];
                children: [ :each |
                        (each value isKindOf: PhaROSValue)
                                ifTrue: [ each value associations ]
                                ifFalse: [ #() ] ];
                column: 'Key'
                        evaluated: [:each | each key ];
                column: 'Value'
                        evaluated: [:each | each value ]

]

{ #category : #testing }
PhaROSValue >> hasAttribute: aName [ 
	^ values includesKey: aName.
]

{ #category : #initialization }
PhaROSValue >> initialize [ 
	values := Dictionary new.
	
]

{ #category : #testing }
PhaROSValue >> isBasic [
	^ false. 
]

{ #category : #printing }
PhaROSValue >> printOn: aStream [
	aStream nextPutAll: self asString.
	
]
