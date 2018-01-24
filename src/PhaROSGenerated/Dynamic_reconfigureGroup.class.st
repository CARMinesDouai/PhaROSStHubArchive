Class {
	#name : #'Dynamic_reconfigureGroup',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup class >> rosMd5Sum [ 
^'9e8cd9e9423c94823db3614dd8b1cf7a'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup class >> rosTypeDefinition [ 
^' string name
 string type
 dynamic_reconfigure/ParamDescription[] parameters
 int32 parent
 int32 id
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup class >> rosTypeName [ 
^'dynamic_reconfigure/Group'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> initialize [
	super initialize.
	 self name: ''. 
	 self type: ''. 
	 self parameters: OrderedCollection new . 
	 self parent: 0. 
	 self id: 0. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> parameters [
	^ self getAt: #parameters. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> parameters: aValue [
	^ self at: #parameters put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> parent [
	^ self getAt: #parent. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> parent: aValue [
	^ self at: #parent put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroup >> type: aValue [
	^ self at: #type put: aValue. 

]
