Class {
	#name : #PhaROSTurtlebotWithStargazer,
	#superclass : #Object,
	#instVars : [
		'turtlebot',
		'localizer'
	],
	#category : #'PhaROS-Controllers-Turtlebot'
}

{ #category : #'landmark localization' }
PhaROSTurtlebotWithStargazer >> detectLandmarks [ 

	^ turtlebot detectLandmarks
]

{ #category : #'landmark localization' }
PhaROSTurtlebotWithStargazer >> discoverLandmark [ 

	self detectLandmarks.
	5 seconds asDelay wait.
	self fuseLandmarks.
	5 seconds asDelay wait.
	self localizeLandmarks. 

]

{ #category : #'landmark localization' }
PhaROSTurtlebotWithStargazer >> exploreMap [

	^ turtlebot exploreMap
]

{ #category : #'fileIn/Out' }
PhaROSTurtlebotWithStargazer >> fileInLandmarks: aString [

	^localizer filein: aString
]

{ #category : #'fileIn/Out' }
PhaROSTurtlebotWithStargazer >> fileOutLandmarks: aString [

	^localizer fileout: aString
]

{ #category : #'landmark localization' }
PhaROSTurtlebotWithStargazer >> fuseLandmarks [ 

	^ turtlebot fuseLandmarks
]

{ #category : #navigation }
PhaROSTurtlebotWithStargazer >> goTo: aLandMark [

	^turtlebot goTo: aLandMark
]

{ #category : #'initialize-release' }
PhaROSTurtlebotWithStargazer >> initialize [
	|controller|
	controller := PhaROSHandleController turtlebot.
	turtlebot := controller nodelets turtlebot.
	localizer := controller nodelets localizer.
	^turtlebot
]

{ #category : #navigation }
PhaROSTurtlebotWithStargazer >> landmarks [
	^turtlebot landmarks 
]

{ #category : #'landmark localization' }
PhaROSTurtlebotWithStargazer >> localizeLandmarks [ 

	^ turtlebot localizeLandmarks
]

{ #category : #navigation }
PhaROSTurtlebotWithStargazer >> startLandmarkNavigationDemo [
	turtlebot landmarkNavigation 
	
]

{ #category : #navigation }
PhaROSTurtlebotWithStargazer >> stopLandmarkNavigationDemo [
	turtlebot stopLandmarkNavigation  
	
]
