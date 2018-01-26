Class {
	#name : #'Map_msgsProjectedMap',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap class >> rosMd5Sum [ 
^'7bbe8f96e45089681dc1ea7d023cbfca'
]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap class >> rosTypeDefinition [ 
^' nav_msgs/OccupancyGrid map
 float64 min_z
 float64 max_z
'
]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap class >> rosTypeName [ 
^'map_msgs/ProjectedMap'
]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap class >> typeCreationOrder [ 
^188
]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> initialize [
	super initialize.
	 self map: Nav_msgsOccupancyGrid new. 
	 self min_z: 0.0. 
	 self max_z: 0.0. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> map [
	^ self getAt: #map. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> map: aValue [
	^ self at: #map put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> max_z [
	^ self getAt: #max_z. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> max_z: aValue [
	^ self at: #max_z put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> min_z [
	^ self getAt: #min_z. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMap >> min_z: aValue [
	^ self at: #min_z put: aValue. 

]
