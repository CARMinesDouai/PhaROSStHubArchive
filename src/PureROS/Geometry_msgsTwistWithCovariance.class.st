Class {
	#name : #'Geometry_msgsTwistWithCovariance',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> addCovarianc: aValue [
	^ self covariance add: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> covariance [
	^ self getAt: #covariance. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> covariance: aValue [
	^ self at: #covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> initialize [
	super initialize.
	 self twist: Geometry_msgsTwist new. 
	 self covariance:  (OrderedCollection new: 36). 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> twist: aValue [
	^ self at: #twist put: aValue. 

]
