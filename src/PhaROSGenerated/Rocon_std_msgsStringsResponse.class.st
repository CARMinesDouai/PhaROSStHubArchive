Class {
	#name : #'Rocon_std_msgsStringsResponse',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse class >> rosMd5Sum [ 
^'992ce8a1687cec8c8bd883ec73ca41d1'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse class >> rosTypeDefinition [ 
^' string data
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse class >> rosTypeName [ 
^'rocon_std_msgs/StringsResponse'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse >> initialize [
	super initialize.
	 self data: ''. 

]
