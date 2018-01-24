Class {
	#name : #'Std_msgsInt16',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt16 class >> rosMd5Sum [ 
^'8524586e34fbd7cb1c08c5f5f1ca0e57'
]

{ #category : #'as yet unclassified' }
Std_msgsInt16 class >> rosTypeDefinition [ 
^' int16 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt16 class >> rosTypeName [ 
^'std_msgs/Int16'
]

{ #category : #'as yet unclassified' }
Std_msgsInt16 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt16 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt16 >> initialize [
	super initialize.
	 self data: 0. 

]
