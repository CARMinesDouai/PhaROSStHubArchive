Class {
	#name : #'Geometry_msgsPoseWithCovariance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> covariance [
	^ self getAt: #covariance. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> covariance: aValue [
	^ self at: #covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> initialize [
	super initialize.
	 self pose: Geometry_msgsPose new. 
	 self covariance:  (OrderedCollection new: 36). 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> pose: aValue [
	^ self at: #pose put: aValue. 

]
