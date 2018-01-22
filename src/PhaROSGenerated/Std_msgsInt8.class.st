Class {
	#name : #'Std_msgsInt8',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt8 class >> rosTypeDefinition [ 
^' int8 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt8 class >> rosTypeName [ 
^'std_msgs/Int8'
]

{ #category : #'as yet unclassified' }
Std_msgsInt8 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt8 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt8 >> initialize [
	super initialize.
	 self data: 0. 

]
