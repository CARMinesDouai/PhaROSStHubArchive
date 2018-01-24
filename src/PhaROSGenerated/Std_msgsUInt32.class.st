Class {
	#name : #'Std_msgsUInt32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt32 class >> rosMd5Sum [ 
^'304a39449588c7f8ce2df6e8001c5fce'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 class >> rosTypeDefinition [ 
^' int32 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 class >> rosTypeName [ 
^'std_msgs/UInt32'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 >> initialize [
	super initialize.
	 self data: 0. 

]
