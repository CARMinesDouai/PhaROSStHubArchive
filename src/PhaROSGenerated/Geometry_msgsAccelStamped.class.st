Class {
	#name : #'Geometry_msgsAccelStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Accel accel
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped class >> rosTypeName [ 
^'geometry_msgs/AccelStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped >> accel [
	^ self getAt: #accel. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped >> accel: aValue [
	^ self at: #accel put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self accel: Geometry_msgsAccel new. 

]
