"
I am a window that displays an exploration simulation.
To create an instance and have it immediatly displayed, you can either use one of the following messages:

-BGSExplorationSimulationWindow onClass:  explorationSimulationClass
-BGSExplorationSimulationWindow on: explorationSimulation

"
Class {
	#name : #BGSExplorationSimulationWindow,
	#superclass : #BGSSimulationWindow,
	#instVars : [
		'frontierCounterMorph',
		'unexploredCounterMorph'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSExplorationSimulationWindow >> addButtonsToPanel: panel [
	|botMapsButton|
	botMapsButton := self makeButton: 'Robot Maps' action: #showRobotMaps state: nil target: self. 
	panel addMorph: botMapsButton.
	super addButtonsToPanel: panel.

]

{ #category : #'initialize-release' }
BGSExplorationSimulationWindow >> addCountersToPanel: panel [
	| frontierView unexploredView |
	self frontierCounterMorph: (LabelMorph contents: '0').
	frontierView := self wrapMorph: self frontierCounterMorph andAddLabel: 'Frontier cells'.
	self unexploredCounterMorph: (LabelMorph contents: '1000').
	unexploredView := self
		wrapMorph: self unexploredCounterMorph
		andAddLabel: 'Unexplored cells'.
	{frontierView.
	unexploredView}
		do: [ :view | 
			panel
				addMorph: view
				fullFrame: (LayoutFrame identity fromArray: #(0 0 1 0 -8 4 4 44)) ].
	super addCountersToPanel: panel
]

{ #category : #accessing }
BGSExplorationSimulationWindow >> frontierCounterMorph [
	^ frontierCounterMorph
]

{ #category : #accessing }
BGSExplorationSimulationWindow >> frontierCounterMorph: anObject [
	frontierCounterMorph := anObject
]

{ #category : #'initialize-release' }
BGSExplorationSimulationWindow >> gridViewClass [
	^BGSExplorableGridView 
]

{ #category : #'initialize-release' }
BGSExplorationSimulationWindow >> robotMapCellExtent [
	^3@3
]

{ #category : #'initialize-release' }
BGSExplorationSimulationWindow >> showRobotMaps [
	self simulation robots do: [:bot|
		|window|
		window := BGSRobotMapWindow displayGrid: bot map cellExtent: self robotMapCellExtent.
		window setLabel: bot id.
		window openInWorld
		]
]

{ #category : #accessing }
BGSExplorationSimulationWindow >> unexploredCounterMorph [
	^ unexploredCounterMorph
]

{ #category : #accessing }
BGSExplorationSimulationWindow >> unexploredCounterMorph: anObject [
	unexploredCounterMorph := anObject
]

{ #category : #display }
BGSExplorationSimulationWindow >> update: anObject [
	super update: anObject.
	self frontierCounterMorph contents: self simulation frontierPositionsCount printString.
	self unexploredCounterMorph contents: self simulation unexploredPositionsCount printString.

]
