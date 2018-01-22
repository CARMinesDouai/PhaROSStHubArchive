Class {
	#name : #'Stdr_msgsThermalSensorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> angleSpan [
	^ self getAt: #angleSpan. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> angleSpan: aValue [
	^ self at: #angleSpan put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> frequency [
	^ self getAt: #frequency. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> frequency: aValue [
	^ self at: #frequency put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> initialize [
	super initialize.
	 self maxRange: 0.0. 
	 self frequency: 0.0. 
	 self angleSpan: 0.0. 
	 self frame_id: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> maxRange [
	^ self getAt: #maxRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> maxRange: aValue [
	^ self at: #maxRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMsg >> pose: aValue [
	^ self at: #pose put: aValue. 

]
