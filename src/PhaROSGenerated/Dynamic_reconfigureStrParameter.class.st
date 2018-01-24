Class {
	#name : #'Dynamic_reconfigureStrParameter',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter class >> rosMd5Sum [ 
^'bc6ccc4a57f61779c8eaae61e9f422e0'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter class >> rosTypeDefinition [ 
^' string name
 string value
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter class >> rosTypeName [ 
^'dynamic_reconfigure/StrParameter'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> initialize [
	super initialize.
	 self name: ''. 
	 self value: ''. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> value: aValue [
	^ self at: #value put: aValue. 

]
