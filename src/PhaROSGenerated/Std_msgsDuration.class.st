Class {
	#name : #'Std_msgsDuration',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsDuration class >> rosMd5Sum [ 
^'3e286caf4241d664e55f3ad380e2ae46'
]

{ #category : #'as yet unclassified' }
Std_msgsDuration class >> rosTypeDefinition [ 
^' duration data
'
]

{ #category : #'as yet unclassified' }
Std_msgsDuration class >> rosTypeName [ 
^'std_msgs/Duration'
]

{ #category : #'as yet unclassified' }
Std_msgsDuration class >> typeCreationOrder [ 
^296
]

{ #category : #'as yet unclassified' }
Std_msgsDuration >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsDuration >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsDuration >> initialize [
	super initialize.
	 self data:  Duration seconds: 0. 

]
