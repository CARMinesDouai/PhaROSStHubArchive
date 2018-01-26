Class {
	#name : #'Geometry_msgsAccelWithCovariance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance class >> rosMd5Sum [ 
^'ad5a718d699c6be72a02b8d6a139f334'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance class >> rosTypeDefinition [ 
^' geometry_msgs/Accel accel
 float64[36]  covariance
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance class >> rosTypeName [ 
^'geometry_msgs/AccelWithCovariance'
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance class >> typeCreationOrder [ 
^139
]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance >> accel [
	^ self getAt: #accel. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance >> accel: aValue [
	^ self at: #accel put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance >> covariance [
	^ self getAt: #covariance. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance >> covariance: aValue [
	^ self at: #covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccelWithCovariance >> initialize [
	super initialize.
	 self accel: Geometry_msgsAccel new. 
	 self covariance:  (OrderedCollection new: 36). 

]
