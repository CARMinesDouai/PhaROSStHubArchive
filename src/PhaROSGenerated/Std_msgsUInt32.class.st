Class {
	#name : #'Std_msgsUInt32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
