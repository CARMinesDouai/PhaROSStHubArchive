Class {
	#name : #'Std_msgsInt64',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt64 class >> rosMd5Sum [ 
^'34add168574510e6e17f5d23ecc077ef'
]

{ #category : #'as yet unclassified' }
Std_msgsInt64 class >> rosTypeDefinition [ 
^' int64 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt64 class >> rosTypeName [ 
^'std_msgs/Int64'
]

{ #category : #'as yet unclassified' }
Std_msgsInt64 class >> typeCreationOrder [ 
^306
]

{ #category : #'as yet unclassified' }
Std_msgsInt64 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt64 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt64 >> initialize [
	super initialize.
	 self data: 0. 

]
