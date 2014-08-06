Class {
	#name : #BGSExplorationMapView,
	#superclass : #BGSExplorableGridView,
	#category : #'BOSS-Exploration'
}

{ #category : #'as yet unclassified' }
BGSExplorationMapView >> drawParts [
	"We do not want these details at this level"
	^self
]

{ #category : #'as yet unclassified' }
BGSExplorationMapView >> drawRobotBody: botBody on: aCanvas [
	| box |
	box := self boxForCellAt: botBody position.
	aCanvas fillRectangle: box color: self robotBodyColor
]

{ #category : #'as yet unclassified' }
BGSExplorationMapView >> robotBodyColor [
	^Color red
]
