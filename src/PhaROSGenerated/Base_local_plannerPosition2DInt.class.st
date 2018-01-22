Class {
	#name : #'Base_local_plannerPosition2DInt',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> initialize [
	super initialize.
	 self x: 0. 
	 self y: 0. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> y: aValue [
	^ self at: #y put: aValue. 

]
