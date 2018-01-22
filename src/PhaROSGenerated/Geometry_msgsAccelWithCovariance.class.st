Class {
	#name : #'Geometry_msgsAccelWithCovariance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
