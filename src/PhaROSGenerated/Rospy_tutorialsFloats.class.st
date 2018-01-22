Class {
	#name : #'Rospy_tutorialsFloats',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rospy_tutorialsFloats class >> rosTypeDefinition [ 
^' float32[] data
'
]

{ #category : #'as yet unclassified' }
Rospy_tutorialsFloats class >> rosTypeName [ 
^'rospy_tutorials/Floats'
]

{ #category : #'as yet unclassified' }
Rospy_tutorialsFloats >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rospy_tutorialsFloats >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rospy_tutorialsFloats >> initialize [
	super initialize.
	 self data: OrderedCollection new . 

]
