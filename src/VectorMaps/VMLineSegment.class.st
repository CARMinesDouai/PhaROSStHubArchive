"
VMLineSegment

Instances of this class are use to represent a line segment, defined through two points. A intersectsWith method is provided to test if two line segments intersect.


Public API and Key Messages

- intersectsWith: <VMLineSegment>
	returns True if the provided line segment intersects with this object. Note, that parallel line segments never intersect (because we allow edges of the graph to be identical to the line segments of the vector map)
- pointA
	getter function, to return the start point
- pointA: <Point>
	setter function, sets the start point to be equal to the provided parameter
- pointB
	getter function, returns the end point of the line segment
- pointB: <Point>
	setter function to set the end point
- printString
	helper function for easy debugging and logging. returns a human readable string
- test
	runs internal test. IMPORTANT: this function modifiers the start and end points without restoring them again.

- from: <Point> to: <point> (class side)
	creates a new instance with the start and end points set according to the parameters
"
Class {
	#name : #VMLineSegment,
	#superclass : #Object,
	#instVars : [
		'pointA',
		'pointB',
		'type',
		'angle'
	],
	#category : #'VectorMaps-kernel'
}

{ #category : #'instance creation' }
VMLineSegment class >> from: a to: b [
	"returns a new VMLineSegment object with start and end points set"
	^self new
		pointA: a;
		pointB: b;
		yourself.

]

{ #category : #'instance creation' }
VMLineSegment class >> from: a to: b type: aNumber [
	"returns a new VMLineSegment object with start and end points set"
	^self new
		pointA: a;
		pointB: b;
		type: aNumber;
		yourself.

]

{ #category : #'rendering support' }
VMLineSegment class >> rendererClass [
	^ VMSegmentRenderer 
]

{ #category : #accessing }
VMLineSegment >> angle [

	angle ifNil: [
		angle := (pointB - pointA) angle.
		angle < 0.0 ifTrue: [ angle := angle + Float twoPi. ].
	].

	^angle.

]

{ #category : #'rendering support' }
VMLineSegment >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #testing }
VMLineSegment >> distanceToLineSeg: lineSeg [
	"note: this funtion has a lot of potential for optimization. in other words, the current implementation is slower than necessary"
	| dA dB dC dD minAB minCD |
	
	self ifIntersectsWith: lineSeg do: [ :point :k |
		^0.0.
	].
	
	dA := self distanceToPoint: lineSeg pointA.
	dB := self distanceToPoint: lineSeg pointB.
	dC := lineSeg distanceToPoint: pointA.
	dD := lineSeg distanceToPoint: pointB.
	
	"find the minimum"
	(dA < dB)
		ifTrue: [ minAB:= dA ]
		ifFalse: [ minAB := dB ].
	(dC < dD)
		ifTrue: [ minCD := dC ]
		ifFalse: [ minCD := dD ].
	
	(minAB < minCD)
		ifTrue: [ ^minAB ]
		ifFalse: [ ^minCD ].

]

{ #category : #testing }
VMLineSegment >> distanceToPoint: aPoint [
	"source: http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment
	(javascript code by Joshua)"
	| a b c d dot lengthSquared param xx yy dx dy |
	
	a := aPoint x - pointA x.
	b := aPoint y - pointA y.
	c := pointB x - pointA x.
	d := pointB y - pointA y.
	
	dot := (a * c) + (b * d).
	lengthSquared := (c * c) + (d * d).
	
	(lengthSquared ~= 0) ifTrue: [
		param := dot / lengthSquared.
	] ifFalse: [
		param := -1. "any negative value will do"
	].
	
	(param < 0) ifTrue: [
		xx := pointA x.
		yy := pointA y.
	] ifFalse: [
		(param > 1) ifTrue: [
			xx := pointB x.
			yy := pointB y.
		] ifFalse: [
			xx := pointA x + (param * c).
			yy := pointA y + (param * d).
		].
	].
	
	dx := aPoint x - xx.
	dy := aPoint y - yy.
	
	^(dx * dx + (dy * dy)) sqrt.


]

{ #category : #testing }
VMLineSegment >> factorToPointProjection: aPoint [
	"source: http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment
	(javascript code by Joshua)
	
	this code computes the factor that is needed to determine the projection point from the provided point to the
	line (not line segment) defined by the line segment 'self'. the projection point is located at:
	pointA + (param * (pointB - pointA)).
	as result of this definition, the projection points lies on the line segment if the factor is in the interval [0, 1]. a 
	negative value indicates that the point lies outside of the line segment, closer to pointA. a value grater than 1
	means, that the point lies outside of the line segment, closer to pointB.
	
	if the line segment is of zero length, the function always returns -1."
	| a b c d dot lengthSquared param |
	
	a := aPoint x - pointA x.
	b := aPoint y - pointA y.
	c := pointB x - pointA x.
	d := pointB y - pointA y.
	
	dot := (a * c) + (b * d).
	lengthSquared := (c * c) + (d * d).
	
	"test for zero-length line segment to avoid deviding by zero"
	(lengthSquared ~= 0) ifTrue: [
		param := dot / lengthSquared.
	] ifFalse: [
		param := -1.
	].
	
	^param.
	

]

{ #category : #testing }
VMLineSegment >> ifIntersectsWith: line do: aBlock [
	"computes if this line segement intersects with the provided line segement. if the lines intersect we execute
	the block 'aBlock' with two parameters: the intersection point and the distantce from pointA as convex
	combination factor."
	| vectorV vectorW crossVW p ts tr t u epsilon |
	
	epsilon := 0.0001.
	vectorV := ((pointB x) - (pointA x)) @ ((pointB y) - (pointA y)).
	vectorW := ((line pointB x) - (line pointA x)) @ ((line pointB y) - (line pointA y)).
	
	"compute the cross product of the vectors. if it is zero than the two lines are parallel"
	crossVW := vectorV crossProduct: vectorW.
	
	p := pointB - (line pointB).
	ts := p crossProduct: vectorW.
	tr := p crossProduct: vectorV.
	
	crossVW = 0 ifTrue: [
		"the two lines are parallel.
		
		Note: we return False here no matter whether the lines intersect or not, because the edges of the visibility graph should be able to run along the walls"
		
		tr = 0 ifTrue: [
			"the lines are colinear - we need to check the segments overlap
			 note: in a virtual map this case should never happen, because such lines would be merged."
			^false.
		] ifFalse: [
			"the lines are not identical, hence the line segments cannot overlap"
			^false.
		].
		^false.
	] ifFalse: [
		"the two lines are not parallel"
		
		t := ts / crossVW . "the intersection point is at:  pointA + t*vectorV "
		u := tr / crossVW . "the intersection point is at:  (line pointA) + u*vectorW "
		
		"now we check for the special case, where both lines share a common start/end point. for numerical reasons, we accept a tolerance of epsilon."
		((( t abs ) < epsilon) | ((t-1) abs < epsilon) ) ifTrue: [
			((( u abs ) < epsilon) | ((u-1) abs < epsilon) ) ifTrue: [
				^false.
			].
		].
		
		"todo: incoperate epsilon in these conditions"
		((0.0 <= t) & (t <= 1.0)) ifTrue: [
			((0.0 <= u) & (u <= 1.0)) ifTrue: [
				| point k |
				k := 1.0 - t.
				point := pointA + (k * vectorV).	"the intersection point"
				"point := pointA + ( t * ((pointB x) - (pointA x)) @ ((pointB y) - (pointA y)) )."
				aBlock value: point value: k.
				^ true.
			].
		].
		
		^false.
	].
	
	self assert: false.




]

{ #category : #testing }
VMLineSegment >> ifStrictIntersectsWith: line do: aBlock [
	"computes if this line segement intersects with the provided line segement. if the lines intersect we execute
	the block 'aBlock' with two parameters: the intersection point and the distantce from pointA as convex
	combination factor."
	| vectorV vectorW crossVW p ts tr t u epsilon |
	
	epsilon := 0.0001.
	vectorV := ((pointB x) - (pointA x)) @ ((pointB y) - (pointA y)).
	vectorW := ((line pointB x) - (line pointA x)) @ ((line pointB y) - (line pointA y)).
	
	"compute the cross product of the vectors. if it is zero than the two lines are parallel"
	crossVW := vectorV crossProduct: vectorW.
	
	p := pointB - (line pointB).
	ts := p crossProduct: vectorW.
	tr := p crossProduct: vectorV.
	
	crossVW = 0 ifTrue: [
		"the two lines are parallel."
		
		tr = 0 ifTrue: [
			"the lines are colinear - we need to check the segments overlap."
			
			| rect |
			rect := Rectangle point: pointA point: pointB.
			((rect containsPoint: line pointA) or: [rect containsPoint: line pointB]) ifTrue: [
				^true.
			].
			
			rect := Rectangle point: (line pointA) point: (line pointB).
			((rect containsPoint: pointA) or: [rect containsPoint: pointB]) ifTrue: [
				^true.
			].
			
			^false.
		] ifFalse: [
			"the lines are not identical, hence the line segments cannot overlap"
			^false.
		].
		^false.
	] ifFalse: [
		"the two lines are not parallel"
		
		t := ts / crossVW . "the intersection point is at:  pointA + t*vectorV "
		u := tr / crossVW . "the intersection point is at:  (line pointA) + u*vectorW "
		
		"now we check for the special case, where both lines share a common start/end point. for numerical reasons, we accept a tolerance of epsilon."
		((( t abs ) < epsilon) | ((t-1) abs < epsilon) ) ifTrue: [
			((( u abs ) < epsilon) | ((u-1) abs < epsilon) ) ifTrue: [
				^false.
			].
		].
		
		"todo: incoperate epsilon in these conditions"
		((0.0 <= t) & (t <= 1.0)) ifTrue: [
			((0.0 <= u) & (u <= 1.0)) ifTrue: [
				| point k |
				k := 1.0 - t.
				point := pointA + (k * vectorV).	"the intersection point"
				"point := pointA + ( t * ((pointB x) - (pointA x)) @ ((pointB y) - (pointA y)) )."
				aBlock value: point value: k.
				^ true.
			].
		].
		
		^false.
	].
	
	self assert: false.




]

{ #category : #initialization }
VMLineSegment >> initialize [
	type := 1.
	angle := nil.
]

{ #category : #intersection }
VMLineSegment >> intersectionPointOrNilWith: aLineSegment [ 
	self intersectionPointWith: aLineSegment ifPresentDo: [ :p | ^ p ].
	^ nil

]

{ #category : #intersection }
VMLineSegment >> intersectionPointWith: aLineSegment ifPresentDo: aBlock [
	"for the line intersection algorithm see:
		http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
	"

	| p q r s qMp qpXr rXs u intersectionPoint |
	
	p := self pointA.
	q := aLineSegment pointA.
	r := self pointB - self pointA.
	s := aLineSegment pointB - aLineSegment pointA.
	
	qMp := q - p.
	qpXr := qMp crossProduct: r.
	rXs := r crossProduct: s.
	
	rXs = 0 ifTrue: [
		"the two lines are parallel"
		qpXr = 0 ifTrue: [
			"the two lines are colinear"
			^true.
		].
		
		"parallel but not colinear - never intersects"
		^false.
	].
	
	u := qpXr / (rXs).
	"t := qMp crossProduct: s / (rXs)."
	
	intersectionPoint := q + (u * s).
	aBlock value: intersectionPoint.
	^true.

]

{ #category : #testing }
VMLineSegment >> intersectsWith: line [
	"computes if this line segement intersects with the provided line segement"
	| vectorV vectorW crossVW p ts tr t u epsilon |
	
	epsilon := 0.0001.
	vectorV := ((pointA x) - (pointB x)) @ ((pointA y) - (pointB y)).
	vectorW := ((line pointA x) - (line pointB x)) @ ((line pointA y) - (line pointB y)).
	
	"compute the cross product of the vectors. if it is zero than the two lines are parallel"
	crossVW := self vector: vectorV cross: vectorW.
	p := pointA - (line pointA).
	ts := self vector: p cross: vectorW.
	tr := self vector: p cross: vectorV.
	
	crossVW = 0
		ifTrue: [
			"the two lines are parallel.
			
			Note: we return False here no matter whether the lines intersect or not, because the edges of the visibility graph should be able to run along the walls"
			
			tr = 0
			ifTrue: [
				"the lines are colinear - we need to check the segments overlap
				 note: in a virtual map this case should never happen, because such lines would be merged."
				^false.
			]
			ifFalse: [
				"the lines are not identical, hence the line segments cannot overlap"
				^false.
			].
		]
		ifFalse: [
			"the two lines are not parallel"
			
			t := ts / crossVW . "the intersection point is at:  pointA + t*vectorV "
			u := tr / crossVW . "the intersection point is at:  (line pointA) + u*vectorW "
			
			"now we check for the special case, where both lines share a common start/end point. for numerical reasons, we accept a tolerance of epsilon."
			((( t abs ) < epsilon) | ((t-1) abs < epsilon) ) ifTrue: [
				((( u abs ) < epsilon) | ((u-1) abs < epsilon) ) ifTrue: [
					^false.
				].
			].
			
			"todo: incoperate epsilon in these conditions"
			((0.0 <= t) & (t <= 1.0)) ifTrue: [
				((0.0 <= u) & (u <= 1.0)) ifTrue: [
					^ true.
				].
			].
			
			^false.
		].
	
	^true.
	




]

{ #category : #'vector operations' }
VMLineSegment >> inverse [
	"inverts the direction of the line segment by switching the start and end points"
	| temp |
	temp := pointA.
	pointA := pointB.
	pointB := temp.
	
	angle := nil.
]

{ #category : #testing }
VMLineSegment >> isFrontier [
	(type = 2) ifTrue: [
		^true.
	].
	^false.
]

{ #category : #testing }
VMLineSegment >> isObstacle [
	(type = 1) ifTrue: [
		^true.
	].
	
	^false.
]

{ #category : #testing }
VMLineSegment >> myIntersectsWith: aLineSeg do: aBlock [
	"see: http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect"
	| p q r s u qMp rXs qpXr |
	
	p := pointA.
	q := aLineSeg pointA.
	r := pointB - pointA.
	s:= (aLineSeg pointB) - (aLineSeg pointB).
	
	qMp := q - p.
	qpXr := qMp crossProduct: r.
	rXs := r crossProduct: s.
	
	rXs = 0 ifTrue: [
		qpXr = 0 ifTrue: [
			| t0 t1 rDrr |
			rDrr := r / (r dotProduct: r).
			t0 := qMp dotProduct: rDrr.
			t1 := t0 + s dotProduct: rDrr.
		].
	].
	
	u := qpXr / (rXs).
]

{ #category : #testing }
VMLineSegment >> myIntersectsWith: aLineSeg ifTurnsLeft: leftBlock ifTurnsRight: rightBlock ifParallel: parallelBlock ifBackwards: backwardsBlock [
	"for the line intersection algorithm see:
		http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
	
	this method returns true if the line segments are intersecting. in that case the coresponding block is also
	executed. if the lines do not intersect then the method returns false and no block is executed.
	
	leftBlock
		is executed if the intersecting line points to the left of 'self' line, i.e. if the relative angle is positive
	rightBlock
		is executed if the intersecting line points to the right, i.e. if the relative angle is negative
	parallelBlock
		is exectued if the line is parallel, and pointing in the same direction
	backwardsBlock
		is executed if the line is parallel, and pointing in the oposite direction"
	
	| p q r s t u qMp rXs qpXr |
	
	p := pointA.
	q := aLineSeg pointA.
	r := pointB - pointA.
	s:= (aLineSeg pointB) - (aLineSeg pointA).
	
	qMp := q - p.
	qpXr := qMp crossProduct: r.
	rXs := r crossProduct: s.
	
	rXs = 0 ifTrue: [
		"the two lines are parallel"
		qpXr = 0 ifTrue: [
			"the two lines are colinear"
			| t0 t1 rDrr |
			rDrr := r / (r dotProduct: r).
			t0 := qMp dotProduct: rDrr.
			t1 := t0 + s dotProduct: rDrr.
			
			"Note: if the interval between t0 and t1 intersects the interval [0, 1] then the line segments are collinear and overlapping; otherwise they are collinear and disjoint."
			
			t0 < 0 ifTrue: [
				t1 >= 0 ifTrue: [
					^true.
				].
				^false.
			] ifFalse: [
				t0 > 1 ifTrue: [
					t1 <= 1 ifTrue: [
						^true.
					].
					^false.
				].
				^true.
			].
		].
		
		"parallel but not colinear - never intersects"
		^false.
	].
	
	u := qpXr / (rXs).
	t := qMp crossProduct: s / (rXs).
	
	( (t >= 0) and: [ t <= 1 ] ) ifTrue: [
		( (u >= 0) and: [u <= 1] ) ifTrue: [
			^true.
		].
	].





]

{ #category : #accessing }
VMLineSegment >> pointA [
	^pointA.
]

{ #category : #accessing }
VMLineSegment >> pointA: point [
	pointA := point.
	angle := nil.
	
]

{ #category : #accessing }
VMLineSegment >> pointB [
	^pointB.
]

{ #category : #accessing }
VMLineSegment >> pointB: point [
	pointB := point.
	angle := nil.

]

{ #category : #printing }
VMLineSegment >> printString [
	"returns a string with the coordinates of the start and end point of the line segment"
	^('from:',(pointA printString),' to:',(pointB printString)).
]

{ #category : #tranformation }
VMLineSegment >> transform: frame [
	self pointA: (
		(pointA rotateBy: (frame orientation) about: (0@0)) +
			(frame position)
	).
	
	self pointB: (
		(pointB rotateBy: (frame orientation) about: (0@0)) +
			(frame position)
	).
	
]

{ #category : #accessing }
VMLineSegment >> type [
	^type.
]

{ #category : #accessing }
VMLineSegment >> type: aNumber [
	"current supported types:
		1: obstacle
		2: frontier"
	type := aNumber.
]

{ #category : #'vector operations' }
VMLineSegment >> vector: v cross: w [
	"compute the cross product of the vectors. the arguments are expected to be Point objects."
	
	| crossVW |
	
	crossVW := ((v x) * (w y)) - ((v y) * (w x)).
	
	^ crossVW.
]
