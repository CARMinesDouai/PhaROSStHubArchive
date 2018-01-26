Class {
	#name : #'Std_msgsFloat64',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsFloat64 class >> rosMd5Sum [ 
^'fdb28210bfa9d7c91146260178d9a584'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64 class >> rosTypeDefinition [ 
^' float64 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64 class >> rosTypeName [ 
^'std_msgs/Float64'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64 class >> typeCreationOrder [ 
^300
]

{ #category : #'as yet unclassified' }
Std_msgsFloat64 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat64 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat64 >> initialize [
	super initialize.
	 self data: 0.0. 

]
