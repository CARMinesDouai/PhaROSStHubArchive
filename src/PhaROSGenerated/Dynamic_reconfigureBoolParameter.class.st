Class {
	#name : #'Dynamic_reconfigureBoolParameter',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter class >> rosMd5Sum [ 
^'23f05028c1a699fb83e22401228c3a9e'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter class >> rosTypeDefinition [ 
^' string name
 bool value
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter class >> rosTypeName [ 
^'dynamic_reconfigure/BoolParameter'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter class >> typeCreationOrder [ 
^108
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter >> initialize [
	super initialize.
	 self name: ''. 
	 self value: false. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureBoolParameter >> value: aValue [
	^ self at: #value put: aValue. 

]
