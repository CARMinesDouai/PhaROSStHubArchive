Class {
	#name : #MapWrapper,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Phrontier_explorationPackage'
}

{ #category : #accessing }
MapWrapper >> findFrontiers [
	| frontiers point32 neighbors currentPoint metricPoint |
	frontiers := Set  new.
	0 to: map info width - 1 do: [ : x |
		0 to: map info height - 1 do: [ : y |
			currentPoint := x @ y.
			(self isFreePixelAt: currentPoint) ifTrue: [
				neighbors := currentPoint eightNeighbors select: [ : aNeighbor | self isValidPixel: aNeighbor].
				neighbors 
					detect: [ : aNeighbor | self isUnknownPixelAt: aNeighbor] 
					ifFound: [
						metricPoint := self pixelToMeter: currentPoint.
						point32 := Geometry_msgsPoint32 new.
						point32 x: metricPoint x; y: metricPoint y; z: 0.0.
						frontiers add: point32.
		 			].
				]
		]
	].
	^ frontiers. 
]

{ #category : #accessing }
MapWrapper >> findReachableFrontiersFrom: aPoint [
	| frontiers exploredPoints pointsToExplore pointsToExploreCopy point32 neighbors metricPoint |
	frontiers := Set  new.
	exploredPoints := Set  new.
	pointsToExplore := Set with: aPoint.
	[pointsToExplore isEmpty] whileFalse: [
		pointsToExploreCopy := pointsToExplore copy.
		pointsToExplore := Set new.
		pointsToExploreCopy do: [ : currentPoint |
			neighbors := currentPoint eightNeighbors select: [ : aNeighbor | self isValidPixel: aNeighbor].
			neighbors 
				detect: [ : aNeighbor | self isUnknownPixelAt: aNeighbor] 
				ifFound: [
					metricPoint := self pixelToMeter: currentPoint.
					point32 := Geometry_msgsPoint32 new.
					point32 x: metricPoint x; y: metricPoint y; z: 0.0.
					frontiers add: point32.
		 		].
			pointsToExplore addAll: (neighbors select: [: aNeighbor | self isFreePixelAt: aNeighbor]).
			exploredPoints add: currentPoint.
		].
		pointsToExplore := pointsToExplore copyWithoutAll: exploredPoints.
	].
	^ frontiers. 
]

{ #category : #accessing }
MapWrapper >> indexForPixelAt: aPoint [
	^(aPoint y  * map info width) + aPoint x + 1.

]

{ #category : #accessing }
MapWrapper >> isFreePixelAt: aPoint [
	^(self valuePixelAt: aPoint) = 0
]

{ #category : #accessing }
MapWrapper >> isObstaclePixelAt: aPoint [
	^(self valuePixelAt: aPoint) > 0
]

{ #category : #accessing }
MapWrapper >> isUnknownPixelAt: aPoint [
	^(self valuePixelAt: aPoint) = -1.0
]

{ #category : #accessing }
MapWrapper >> isValidPixel: aPoint [ 
	^ (aPoint x >= 0 )
		& (aPoint y >= 0)
		& (aPoint x < map info width)
		& (aPoint y < map info height)
]

{ #category : #accessing }
MapWrapper >> map [	
	^ map
]

{ #category : #accessing }
MapWrapper >> map: aMap [
	map := aMap
]

{ #category : #accessing }
MapWrapper >> meterToPixel: aPoint [
	| rawPixelPosition |
	rawPixelPosition := (aPoint / map info resolution) rounded.
	^ (rawPixelPosition - self pixelOrigin) rounded

]

{ #category : #accessing }
MapWrapper >> metricOrigin [
	^map info origin position x @ map info origin position y
]

{ #category : #accessing }
MapWrapper >> pixelOrigin [
	^ (map metricOrigin / map info resolution) rounded

]

{ #category : #accessing }
MapWrapper >> pixelToMeter: aPoint [
	^ (aPoint * map info resolution) + self metricOrigin
]

{ #category : #accessing }
MapWrapper >> updateWith: aMapUpdate [
	0 to: (aMapUpdate width - 1) do: [ :i | 
		0 to: (aMapUpdate height - 1) do: [ :j | 
			self valuePixelAt: (i @ j ) + (aMapUpdate x @ aMapUpdate y) put: (aMapUpdate data at: (j * aMapUpdate width + i + 1) ) ] ].
]

{ #category : #accessing }
MapWrapper >> valueAtFromMap: aPoint [
	| nbPixel   py px |
	py := ((aPoint y - map info origin position y) / map info resolution) rounded. 
	px := ((aPoint x - map info origin position y) / map info resolution) rounded.
	nbPixel := (py  * map info width) + px.
	^ self valuePixelAt: px @ py
]

{ #category : #accessing }
MapWrapper >> valuePixelAt: aPoint [
	^ map data at: (self indexForPixelAt: aPoint)
]

{ #category : #accessing }
MapWrapper >> valuePixelAt: aPoint put: aValue [
	(self isValidPixel: aPoint) ifFalse: [ ^ self ].
	map data at: (self indexForPixelAt: aPoint) put: aValue
]
