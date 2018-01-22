Class {
	#name : #'Geometry_msgsAccelWithCovarianceStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/AccelWithCovariance accel
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped class >> rosTypeName [ 
^'geometry_msgs/AccelWithCovarianceStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped >> accel [
	^ self getAt: #accel. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped >> accel: aValue [
	^ self at: #accel put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovarianceStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self accel: Geometry_msgsAccelWithCovariance new. 

]
