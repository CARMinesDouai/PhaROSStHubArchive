Class {
	#name : #'Std_msgsFloat32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsFloat32 class >> rosMd5Sum [ 
^'73fcbf46b49191e672908e50842a83d4'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32 class >> rosTypeDefinition [ 
^' float32 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32 class >> rosTypeName [ 
^'std_msgs/Float32'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32 class >> typeCreationOrder [ 
^298
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat32 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat32 >> initialize [
	super initialize.
	 self data: 0.0. 

]
