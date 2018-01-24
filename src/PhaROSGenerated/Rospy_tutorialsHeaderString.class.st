Class {
	#name : #'Rospy_tutorialsHeaderString',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString class >> rosMd5Sum [ 
^'c99a9440709e4d4a9716d55b8270d5e7'
]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string data
'
]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString class >> rosTypeName [ 
^'rospy_tutorials/HeaderString'
]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Rospy_tutorialsHeaderString >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self data: ''. 

]
