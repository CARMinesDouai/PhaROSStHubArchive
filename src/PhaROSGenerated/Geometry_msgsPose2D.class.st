Class {
	#name : #'Geometry_msgsPose2D',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self theta: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> theta [
	^ self getAt: #theta. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> theta: aValue [
	^ self at: #theta put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> y: aValue [
	^ self at: #y put: aValue. 

]
