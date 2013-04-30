Class {
	#name : #'Geometry_msgsTwistWithCovarianceStamped',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self twist: Geometry_msgsTwistWithCovariance new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> twist: aValue [
	^ self at: #twist put: aValue. 

]
