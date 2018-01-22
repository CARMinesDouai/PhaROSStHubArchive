Class {
	#name : #'Stdr_msgsCO2Source',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> initialize [
	super initialize.
	 self id: ''. 
	 self ppm: 0.0. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> ppm [
	^ self getAt: #ppm. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> ppm: aValue [
	^ self at: #ppm put: aValue. 

]
