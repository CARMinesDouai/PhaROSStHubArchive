Class {
	#name : #'Rospy_tutorialsFloats',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
