Class {
	#name : #'Std_msgsUInt16',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt16 class >> rosMd5Sum [ 
^'1df79edf208b629fe6b81923a544552d'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16 class >> rosTypeDefinition [ 
^' uint16 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16 class >> rosTypeName [ 
^'std_msgs/UInt16'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16 class >> typeCreationOrder [ 
^312
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt16 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt16 >> initialize [
	super initialize.
	 self data: 0. 

]
