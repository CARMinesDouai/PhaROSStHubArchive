Class {
	#name : #RrShowObstacleSensorsController,
	#superclass : #RrController,
	#instVars : [
		'display',
		'displayController',
		'irVectorsBuilder',
		'laserVectorsBuilder',
		'sonarVectorsBuilder',
		'irDistances',
		'sonarDistances',
		'laserDistances',
		'displayTrigger'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #'initialize-release' }
RrShowObstacleSensorsController >> initialize [
	| pi |
	super initialize.
	display := RrVectorDisplay new.
	displayController := RrVectorLayersDisplayController layersCount: 3.
	displayController display: display.
	(displayController layerAt: 1) 
		color: Color blue.
	(displayController layerAt: 2) 
		color: Color green.
	(displayController layerAt: 3) 
		color: Color red.
	displayTrigger := ActiveObject 
		repeat: [
			irDistances ifNotNil: [
				irVectorsBuilder input: irDistances].
			sonarDistances ifNotNil: [ 
				sonarVectorsBuilder input: sonarDistances].
			laserDistances ifNotNil: [ 
				laserVectorsBuilder input: laserDistances].
		] every: 100 milliSeconds .
	displayTrigger 
		priority: Processor userInterruptPriority .
	sonarVectorsBuilder := RrVectorsBuilder new.
	irVectorsBuilder := RrVectorsBuilder new.
	laserVectorsBuilder := RrVectorsBuilder new.
	pi := VeAngle pi.
	sonarVectorsBuilder 
		sensorAngles: {pi/12. pi/4. pi/2. 3*pi/4. pi.  -3*pi/4. -1*pi/2. -1*pi/4 . -1*pi/12};
		onOutputDo: [ : vectors | displayController drawAll: vectors onLayer: 3 ].
	irVectorsBuilder 
		sensorAngles: {0 radians. pi/12. pi/4. 3*pi/8. pi/2.  5*pi/8. 3*pi/4. 11*pi/12. 
						pi.
						 -11*pi/12. -3*pi/4. -5*pi/8. -1*pi/2. -3*pi/8. -1*pi/4.  -1*pi/12.};
		onOutputDo: [ : vectors | displayController drawAll: vectors onLayer: 2 ].
	laserVectorsBuilder 
		sensorAngles: ((0 to: 270) collect: [: degree | degree degreesToRadians radians]) ;
		onOutputDo: [ : vectors | displayController drawAll: vectors onLayer: 1 ].

]

{ #category : #acting }
RrShowObstacleSensorsController >> start [
	display start.
	self robot 
		scanIrEvery: 0 
		do: [ : distances| 
			irDistances := distances.
		];
		scanSonarsEvery: 0 
		do: [ : distances| 
			sonarDistances := distances.
		];
		scanLaserEvery: 0
		do: [ : distances|
			laserDistances := distances.
		].
	displayTrigger start
]

{ #category : #acting }
RrShowObstacleSensorsController >> stop [
	super stop.
	display stop.
	displayTrigger stop
]
