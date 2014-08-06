Class {
	#name : #BGSRobotMapWindow,
	#superclass : #BGSGridWindow,
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSRobotMapWindow >> gridViewClass [ 
	^BGSExplorationMapView 
]
