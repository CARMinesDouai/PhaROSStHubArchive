Class {
	#name : #'Std_msgsFloat64MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray class >> rosMd5Sum [ 
^'4b7d974086d4060e7db4613a7e6c3ba4'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 float64[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray class >> rosTypeName [ 
^'std_msgs/Float64MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray class >> typeCreationOrder [ 
^301
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat64MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
