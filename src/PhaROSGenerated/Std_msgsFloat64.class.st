Class {
	#name : #'Std_msgsFloat64',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
