Class {
	#name : #'Ar_track_alvar_msgsAlvarMarkers',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers class >> rosTypeDefinition [ 
^' std_msgs/Header header
 ar_track_alvar_msgs/AlvarMarker[] markers
'
]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers class >> rosTypeName [ 
^'ar_track_alvar_msgs/AlvarMarkers'
]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self markers: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers >> markers [
	^ self getAt: #markers. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarkers >> markers: aValue [
	^ self at: #markers put: aValue. 

]
