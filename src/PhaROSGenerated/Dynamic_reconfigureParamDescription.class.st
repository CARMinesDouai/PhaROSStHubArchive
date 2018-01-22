Class {
	#name : #'Dynamic_reconfigureParamDescription',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription class >> rosTypeDefinition [ 
^' string name
 string type
 int32 level
 string description
 string edit_method
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription class >> rosTypeName [ 
^'dynamic_reconfigure/ParamDescription'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> edit_method [
	^ self getAt: #edit_method. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> edit_method: aValue [
	^ self at: #edit_method put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> initialize [
	super initialize.
	 self name: ''. 
	 self type: ''. 
	 self level: 0. 
	 self description: ''. 
	 self edit_method: ''. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> level [
	^ self getAt: #level. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> level: aValue [
	^ self at: #level put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureParamDescription >> type: aValue [
	^ self at: #type put: aValue. 

]
