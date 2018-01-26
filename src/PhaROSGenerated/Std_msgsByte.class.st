Class {
	#name : #'Std_msgsByte',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsByte class >> rosMd5Sum [ 
^'ad736a2e8818154c487bb80fe42ce43b'
]

{ #category : #'as yet unclassified' }
Std_msgsByte class >> rosTypeDefinition [ 
^' int8 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsByte class >> rosTypeName [ 
^'std_msgs/Byte'
]

{ #category : #'as yet unclassified' }
Std_msgsByte class >> typeCreationOrder [ 
^290
]

{ #category : #'as yet unclassified' }
Std_msgsByte >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsByte >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsByte >> initialize [
	super initialize.
	 self data: 0. 

]
