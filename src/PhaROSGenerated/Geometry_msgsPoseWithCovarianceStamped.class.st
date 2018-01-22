Class {
	#name : #'Geometry_msgsPoseWithCovarianceStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovarianceStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovarianceStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovarianceStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pose: Geometry_msgsPoseWithCovariance new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovarianceStamped >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovarianceStamped >> pose: aValue [
	^ self at: #pose put: aValue. 

]
