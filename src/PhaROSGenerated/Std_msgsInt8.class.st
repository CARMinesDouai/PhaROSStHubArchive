Class {
	#name : #'Std_msgsInt8',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt8 class >> rosMd5Sum [ 
^'27ffa0c9c4b8fb8492252bcad9e5c57b'
]

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
Std_msgsInt8 class >> typeCreationOrder [ 
^308
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
