Class {
	#name : #'Ar_track_alvar_msgsAlvarMarker',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> confidence [
	^ self getAt: #confidence. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> confidence: aValue [
	^ self at: #confidence put: aValue. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self id: 0. 
	 self confidence: 0. 
	 self pose: Geometry_msgsPoseStamped new. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Ar_track_alvar_msgsAlvarMarker >> pose: aValue [
	^ self at: #pose put: aValue. 

]
