Class {
	#name : #RrObstacleSensorsViewer,
	#superclass : #Object,
	#instVars : [
		'sensorsDisplay',
		'sensorsDisplayController',
		'sensorsDisplayUpdater',
		'showSonar',
		'sonarVectors',
		'showIr',
		'irVectors',
		'showLaser',
		'laserVectors'
	],
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #'initialize-release' }
RrObstacleSensorsViewer >> displayRefereshPeriod [
	^ 100 milliSeconds
]

{ #category : #acting }
RrObstacleSensorsViewer >> hideIr [
	showIr := false.
	sensorsDisplayController eraseLayer: self irLayerIndex.

]

{ #category : #acting }
RrObstacleSensorsViewer >> hideLaser [
	showLaser := false.
	sensorsDisplayController eraseLayer: self laserLayerIndex.
	
]

{ #category : #acting }
RrObstacleSensorsViewer >> hideSonar [
	showSonar := false.
	sensorsDisplayController eraseLayer: self sonarLayerIndex.

]

{ #category : #'initialize-release' }
RrObstacleSensorsViewer >> initialize [
	super initialize.
	sensorsDisplay := self sensorDisplayClass labelled: 'Sensor Values'.
	sensorsDisplayController := RrVectorLayersDisplayController layersCount: 3.
	sensorsDisplayController display: sensorsDisplay.
	(sensorsDisplayController layerAt: self laserLayerIndex)
		lineWidth: 1;
		color: Color blue.
	(sensorsDisplayController layerAt: self sonarLayerIndex)
		lineWidth: 2;
		color: Color green.
	(sensorsDisplayController layerAt: self irLayerIndex)
		lineWidth: 4;
		color: Color red.
	sensorsDisplayUpdater := ActiveObject repeat: [ self updateDisplay ] every: self displayRefereshPeriod.
	sensorsDisplayUpdater
		name: self className;
		priority: Processor userInterruptPriority.
	sonarVectors := #().
	irVectors := #().
	laserVectors := #().
	self showLaser.
	self showIr.
	self showSonar
]

{ #category : #accessing }
RrObstacleSensorsViewer >> irLayerIndex [
	^2
]

{ #category : #accessing }
RrObstacleSensorsViewer >> irVectors [
	^ irVectors
]

{ #category : #accessing }
RrObstacleSensorsViewer >> irVectors: anObject [
	irVectors := anObject
]

{ #category : #accessing }
RrObstacleSensorsViewer >> laserLayerIndex [
	^1
]

{ #category : #accessing }
RrObstacleSensorsViewer >> laserVectors [
	^ laserVectors
]

{ #category : #accessing }
RrObstacleSensorsViewer >> laserVectors: anObject [
	laserVectors := anObject
]

{ #category : #'initialize-release' }
RrObstacleSensorsViewer >> sensorDisplayClass [
	^ RrVectorDisplay
]

{ #category : #acting }
RrObstacleSensorsViewer >> showIr [
	showIr := true
]

{ #category : #acting }
RrObstacleSensorsViewer >> showLaser [
	showLaser := true
]

{ #category : #acting }
RrObstacleSensorsViewer >> showSonar [
	showSonar := true
]

{ #category : #accessing }
RrObstacleSensorsViewer >> sonarLayerIndex [
	^3
]

{ #category : #accessing }
RrObstacleSensorsViewer >> sonarVectors [
	^ sonarVectors
]

{ #category : #accessing }
RrObstacleSensorsViewer >> sonarVectors: anObject [
	sonarVectors := anObject
]

{ #category : #acting }
RrObstacleSensorsViewer >> start [
	sensorsDisplay start.
	sensorsDisplayUpdater start	

]

{ #category : #acting }
RrObstacleSensorsViewer >> stop [
	sensorsDisplay stop.
	sensorsDisplayUpdater stop
]

{ #category : #displaying }
RrObstacleSensorsViewer >> updateDisplay [
	showSonar ifTrue: [ sensorsDisplayController drawAll: self sonarVectors onLayer: self sonarLayerIndex ].
	showIr ifTrue: [ sensorsDisplayController drawAll: self irVectors onLayer: self irLayerIndex ].
	showLaser ifTrue: [ sensorsDisplayController drawAll: self laserVectors onLayer: self laserLayerIndex ]
]
