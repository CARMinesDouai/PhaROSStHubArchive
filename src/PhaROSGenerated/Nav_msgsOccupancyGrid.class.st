Class {
	#name : #'Nav_msgsOccupancyGrid',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid class >> rosMd5Sum [ 
^'3381f2d731d4076ec5c71b0759edbe4e'
]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid class >> rosTypeDefinition [ 
^' std_msgs/Header header
 nav_msgs/MapMetaData info
 int8[] data
'
]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid class >> rosTypeName [ 
^'nav_msgs/OccupancyGrid'
]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid class >> typeCreationOrder [ 
^187
]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> info [
	^ self getAt: #info. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> info: aValue [
	^ self at: #info put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self info: Nav_msgsMapMetaData new. 
	 self data: OrderedCollection new . 

]
