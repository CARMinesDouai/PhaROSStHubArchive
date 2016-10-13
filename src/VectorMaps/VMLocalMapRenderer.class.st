Class {
	#name : #VMLocalMapRenderer,
	#superclass : #VMFigureRenderer,
	#instVars : [
		'showFrontiers'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #'as yet unclassified' }
VMLocalMapRenderer >> initialize [
	super initialize.
	showFrontiers := false.
]

{ #category : #rendering }
VMLocalMapRenderer >> lineColorByType: type [

	(type = 1) ifTrue: [
		"obstacle"
		^Color red.
	].

	(type = 2) ifTrue: [
		"frontier"
		^Color green.
	].

	"unsupported type"
	^Color yellow.
]

{ #category : #'as yet unclassified' }
VMLocalMapRenderer >> points [
	^model lineSegments collect: [ :lineSeg | lineSeg pointA ].
]

{ #category : #rendering }
VMLocalMapRenderer >> renderOn: canvas [
	| frame |
	
	frame := model tf.
	
	model lineSegments do: [ :line |
		|from to |
		
		from := (line pointA rotateBy: frame orientation about: (0@0)) + frame position.
		to  := (line pointB rotateBy: frame orientation about: (0@0)) + frame position.
		
		self setLineStyleByType: (line type).
		( showFrontiers or: [line isObstacle] ) ifTrue: [
			self renderStyledLineFrom: from to: to in: canvas color: (self lineColorByType: line type).
		].
	].

	super renderOn: canvas.
]

{ #category : #rendering }
VMLocalMapRenderer >> setLineStyleByType: type [

	(type = 1) ifTrue: [
		"obstacle"
		^self beSolid.
	].

	(type = 2) ifTrue: [
		"frontier"
		^self beDotted.
	].

	"unsupported type"
	^self beDashed.
]
