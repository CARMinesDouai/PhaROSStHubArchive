"
I am an explorer robot that moves towards the nearest frontier and shares map with other robots that are within wireless range.
"
Class {
	#name : #BGSCollaborativeNearestFrontierExplorerRobot,
	#superclass : #BGSNearestFrontierExplorerRobot,
	#category : #'BOSS-Exploration-Example'
}

{ #category : #'initialize-release' }
BGSCollaborativeNearestFrontierExplorerRobot >> bodyClass [
	^BGSWirelessEnabledRangeSensorBeltRobotBody
]

{ #category : #communicating }
BGSCollaborativeNearestFrontierExplorerRobot >> broadcast: selector args: args [ 
	self robotsWithinWirelessRange do: [:bot|
		bot perform: selector withArguments: args] 
]

{ #category : #sensing }
BGSCollaborativeNearestFrontierExplorerRobot >> robotsWithinWirelessRange [
	^self wireless botsInRange
]

{ #category : #stepping }
BGSCollaborativeNearestFrontierExplorerRobot >> step [
	super step.
	self broadcast: #updateMapFrom: args: {self map}
]

{ #category : #updating }
BGSCollaborativeNearestFrontierExplorerRobot >> updateMapFrom: aBGSExplorableGrid [ 
	self map updateFrom: aBGSExplorableGrid
]

{ #category : #communicating }
BGSCollaborativeNearestFrontierExplorerRobot >> wireless [
	^self body part: #wireless
]
