Class {
	#name : #'Nav_msgsGetMapResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
