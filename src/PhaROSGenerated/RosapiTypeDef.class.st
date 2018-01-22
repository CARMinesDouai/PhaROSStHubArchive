Class {
	#name : #RosapiTypeDef,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
RosapiTypeDef class >> rosTypeDefinition [ 
^' string type
 string[] fieldnames
 string[] fieldtypes
 int32[] fieldarraylen
 string[] examples
'
]

{ #category : #'as yet unclassified' }
RosapiTypeDef class >> rosTypeName [ 
^'rosapi/TypeDef'
]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> examples [
	^ self getAt: #examples. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> examples: aValue [
	^ self at: #examples put: aValue. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> fieldarraylen [
	^ self getAt: #fieldarraylen. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> fieldarraylen: aValue [
	^ self at: #fieldarraylen put: aValue. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> fieldnames [
	^ self getAt: #fieldnames. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> fieldnames: aValue [
	^ self at: #fieldnames put: aValue. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> fieldtypes [
	^ self getAt: #fieldtypes. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> fieldtypes: aValue [
	^ self at: #fieldtypes put: aValue. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> initialize [
	super initialize.
	 self type: ''. 
	 self fieldnames: OrderedCollection new . 
	 self fieldtypes: OrderedCollection new . 
	 self fieldarraylen: OrderedCollection new . 
	 self examples: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
RosapiTypeDef >> type: aValue [
	^ self at: #type put: aValue. 

]
