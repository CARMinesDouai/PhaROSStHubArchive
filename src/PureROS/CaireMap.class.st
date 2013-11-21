Class {
	#name : #CaireMap,
	#superclass : #Object,
	#instVars : [
		'grid'
	],
	#category : #'PureROS-Nodelets-Caire'
}

{ #category : #'as yet unclassified' }
CaireMap class >> fromNav_msgsOccupancyGrid: aGrid [
	^ self new grid: aGrid; yourself 
]

{ #category : #'as yet unclassified' }
CaireMap >> at: x at: y [

	 ^ grid data at: (x + (y * self width)). 

	 
]

{ #category : #'as yet unclassified' }
CaireMap >> at: x at: y put: aValue [ 

	 ^ grid data at: (x + (y * self width)) put: aValue. 

	 
]

{ #category : #'as yet unclassified' }
CaireMap >> grid: aGrid [
	grid := aGrid.
]

{ #category : #'as yet unclassified' }
CaireMap >> height [  
	^ grid info height. 
	
]

{ #category : #'as yet unclassified' }
CaireMap >> intoOccupancyGrid: aGrid [
	aGrid info: grid info.
	aGrid data: grid data.
	
]

{ #category : #'as yet unclassified' }
CaireMap >> width [ 
	^ grid info width. 
	
]
