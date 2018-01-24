Class {
	#name : #'Nav_msgsGetMapResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsGetMapResult class >> rosMd5Sum [ 
^'6cdd0a18e0aff5b0a3ca2326a89b54ff'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapResult class >> rosTypeDefinition [ 
^' nav_msgs/OccupancyGrid map
'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapResult class >> rosTypeName [ 
^'nav_msgs/GetMapResult'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapResult >> initialize [
	super initialize.
	 self map: Nav_msgsOccupancyGrid new. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapResult >> map [
	^ self getAt: #map. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapResult >> map: aValue [
	^ self at: #map put: aValue. 

]
