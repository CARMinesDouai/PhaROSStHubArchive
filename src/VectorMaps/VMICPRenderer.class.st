Class {
	#name : #VMICPRenderer,
	#superclass : #VMFigureRenderer,
	#instVars : [
		'inputAColor',
		'inputBColor',
		'outputBColor',
		'showMatches',
		'matchesLineColor',
		'showHistory'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #initialization }
VMICPRenderer >> initialize [
	super initialize.
	
	inputAColor := Color r: 0.0 g: 0.5 b: 1.0.
	inputBColor := Color r: 1.0 g: 0.3 b: 0.2.
	
	outputBColor := Color r: 0.6 g: 0.9 b: 0.1.
	
	matchesLineColor := Color r: 0.0 g: 1.0 b: 1.0.
	
	showMatches := true.
	showHistory := true.
	textScale := 0.02.

]

{ #category : #'as yet unclassified' }
VMICPRenderer >> points [
	^self model inputA.
]

{ #category : #rendering }
VMICPRenderer >> renderHistoryOn: canvas [
	| history size |
	
	history := model iterationHistory.
	history ifNil: [ ^self. ].
	
	size := history size.
	
	history doWithIndex: [ :pointCollection :index |
		| renderColor |
		
		(index = size) ifTrue: [ ^self. ].
		
		"from cyan over blue to purple"
		renderColor := Color h: (180 + ((index-1 / (size-1))*120)) s: 1.0 v: 1.0.
		
		self renderOn: canvas pointCollection: pointCollection color: renderColor label: ('hist.', index printString).
	].

]

{ #category : #rendering }
VMICPRenderer >> renderMatchesOn: canvas [
	
	model matchCollection ifNil: [ ^self. ].
	
	model matchCollection do: [ :pair |
		self renderStyledLineFrom: (pair first) to: (pair last) in: canvas color: matchesLineColor.
	].
	

]

{ #category : #rendering }
VMICPRenderer >> renderOn: canvas [
	
	self renderOn: canvas pointCollection: model inputA color: inputAColor label: 'inputA'.
	
	showHistory ifTrue: [
		self renderHistoryOn: canvas.
	].
	
	showMatches ifTrue: [
		self renderMatchesOn: canvas.
	].
	
	self renderOn: canvas pointCollection: model outputA color: outputBColor label: 'outputA'.

	self renderOn: canvas pointCollection: model nnCollection color: inputBColor label: 'nnCol'.

]

{ #category : #'as yet unclassified' }
VMICPRenderer >> showMatches: aBoolean [
	showMatches := aBoolean.
]
