Class {
	#name : #'Yocs_msgsWaypointList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsWaypointList >> initialize [
	super initialize.
	 self waypoints: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypointList >> waypoints [
	^ self getAt: #waypoints. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypointList >> waypoints: aValue [
	^ self at: #waypoints put: aValue. 

]
