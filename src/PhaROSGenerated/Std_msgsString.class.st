Class {
	#name : #'Std_msgsString',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsString class >> rosTypeDefinition [ 
^' string data
'
]

{ #category : #'as yet unclassified' }
Std_msgsString class >> rosTypeName [ 
^'std_msgs/String'
]

{ #category : #'as yet unclassified' }
Std_msgsString >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsString >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsString >> initialize [
	super initialize.
	 self data: ''. 

]
