Class {
	#name : #RoscppLogger,
	#superclass : #PhaROSValue,
	#category : #'PhaROS-Types'
}

{ #category : #'as yet unclassified' }
RoscppLogger class >> rosMd5Sum [
	^ 'a6069a2ff40db7bd32143dd66e1f408e'
]

{ #category : #'as yet unclassified' }
RoscppLogger class >> rosTypeDefinition [ 
^' string name
 string level
'
]

{ #category : #'as yet unclassified' }
RoscppLogger class >> rosTypeName [ 
^'roscpp/Logger'
]

{ #category : #'as yet unclassified' }
RoscppLogger class >> typeCreationOrder [
	^ 0
]

{ #category : #'as yet unclassified' }
RoscppLogger >> initialize [
	super initialize.
	 self name: ''. 
	 self level: ''. 

]

{ #category : #'as yet unclassified' }
RoscppLogger >> level [
	^ self getAt: #level. 

]

{ #category : #'as yet unclassified' }
RoscppLogger >> level: aValue [
	^ self at: #level put: aValue. 

]

{ #category : #'as yet unclassified' }
RoscppLogger >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
RoscppLogger >> name: aValue [
	^ self at: #name put: aValue. 

]
