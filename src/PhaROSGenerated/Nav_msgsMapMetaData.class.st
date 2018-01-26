Class {
	#name : #'Nav_msgsMapMetaData',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData class >> rosMd5Sum [ 
^'10cfc8a2818024d3248802c00c95f11b'
]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData class >> rosTypeDefinition [ 
^' time map_load_time
 float32 resolution
 int32 width
 int32 height
 geometry_msgs/Pose origin
'
]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData class >> rosTypeName [ 
^'nav_msgs/MapMetaData'
]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData class >> typeCreationOrder [ 
^186
]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> initialize [
	super initialize.
	 self map_load_time:  PhaROSTimestamp now. 
	 self resolution: 0.0. 
	 self width: 0. 
	 self height: 0. 
	 self origin: Geometry_msgsPose new. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> map_load_time [
	^ self getAt: #map_load_time. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> map_load_time: aValue [
	^ self at: #map_load_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> origin [
	^ self getAt: #origin. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> origin: aValue [
	^ self at: #origin put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> resolution [
	^ self getAt: #resolution. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> resolution: aValue [
	^ self at: #resolution put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Nav_msgsMapMetaData >> width: aValue [
	^ self at: #width put: aValue. 

]
