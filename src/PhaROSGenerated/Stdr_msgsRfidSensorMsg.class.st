Class {
	#name : #'Stdr_msgsRfidSensorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> angleSpan [
	^ self getAt: #angleSpan. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> angleSpan: aValue [
	^ self at: #angleSpan put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> frequency [
	^ self getAt: #frequency. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> frequency: aValue [
	^ self at: #frequency put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> initialize [
	super initialize.
	 self maxRange: 0.0. 
	 self angleSpan: 0.0. 
	 self signalCutoff: 0.0. 
	 self frequency: 0.0. 
	 self frame_id: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> maxRange [
	^ self getAt: #maxRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> maxRange: aValue [
	^ self at: #maxRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> signalCutoff [
	^ self getAt: #signalCutoff. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMsg >> signalCutoff: aValue [
	^ self at: #signalCutoff put: aValue. 

]
