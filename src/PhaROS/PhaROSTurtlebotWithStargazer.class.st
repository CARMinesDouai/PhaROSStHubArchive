Class {
	#name : #PhaROSTurtlebotWithStargazer,
	#superclass : #Object,
	#instVars : [
		'turtlebot',
		'localizer'
	],
	#category : #'PhaROS-Controllers-Turtlebot'
}

{ #category : #'as yet unclassified' }
PhaROSTurtlebotWithStargazer >> exploreMap [

	^ turtlebot exploreMap
]

{ #category : #'as yet unclassified' }
PhaROSTurtlebotWithStargazer >> fileInLandmarks: aString [

	^localizer filein: aString
]

{ #category : #'as yet unclassified' }
PhaROSTurtlebotWithStargazer >> fileOutLandmarks: aString [

	^localizer fileout: aString
]

{ #category : #'as yet unclassified' }
PhaROSTurtlebotWithStargazer >> goTo: aLandMark [

	^turtlebot goTo: aLandMark
]

{ #category : #'as yet unclassified' }
PhaROSTurtlebotWithStargazer >> initialize [
	|controller|
	controller := PhaROSHandleController turtlebot.
	turtlebot := controller nodelets turtlebot.
	localizer := controller nodelets localizer.
	^turtlebot
]
