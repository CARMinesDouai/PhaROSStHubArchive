Class {
	#name : #'Std_msgsInt32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt32 class >> rosMd5Sum [ 
^'da5909fbe378aeaf85e547e830cc1bb7'
]

{ #category : #'as yet unclassified' }
Std_msgsInt32 class >> rosTypeDefinition [ 
^' int32 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt32 class >> rosTypeName [ 
^'std_msgs/Int32'
]

{ #category : #'as yet unclassified' }
Std_msgsInt32 class >> typeCreationOrder [ 
^304
]

{ #category : #'as yet unclassified' }
Std_msgsInt32 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt32 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt32 >> initialize [
	super initialize.
	 self data: 0. 

]
