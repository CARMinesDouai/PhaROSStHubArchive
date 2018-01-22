Class {
	#name : #'Std_msgsUInt64',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt64 class >> rosTypeDefinition [ 
^' int64 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt64 class >> rosTypeName [ 
^'std_msgs/UInt64'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt64 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt64 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt64 >> initialize [
	super initialize.
	 self data: 0. 

]
