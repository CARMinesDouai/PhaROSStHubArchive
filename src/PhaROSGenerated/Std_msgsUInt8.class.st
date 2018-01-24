Class {
	#name : #'Std_msgsUInt8',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt8 class >> rosMd5Sum [ 
^'7c8164229e7d2c17eb95e9231617fdee'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8 class >> rosTypeDefinition [ 
^' int8 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8 class >> rosTypeName [ 
^'std_msgs/UInt8'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt8 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt8 >> initialize [
	super initialize.
	 self data: 0. 

]
