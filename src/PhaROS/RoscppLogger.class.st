Class {
	#name : #RoscppLogger,
	#superclass : #PhaROSValue,
	#category : #'PhaROS-Types'
}

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
