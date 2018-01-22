Class {
	#name : #'Dynamic_reconfigureDoubleParameter',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter class >> rosTypeDefinition [ 
^' string name
 float64 value
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter class >> rosTypeName [ 
^'dynamic_reconfigure/DoubleParameter'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter >> initialize [
	super initialize.
	 self name: ''. 
	 self value: 0.0. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureDoubleParameter >> value: aValue [
	^ self at: #value put: aValue. 

]
