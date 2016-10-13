Class {
	#name : #VMICPRenderer,
	#superclass : #VMFigureRenderer,
	#instVars : [
		'inputAColor',
		'inputBColor',
		'outputBColor',
		'showMatches',
		'matchesLineColor'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #initialization }
VMICPRenderer >> initialize [
	super initialize.
	
	inputAColor := Color r: 0.0 g: 0.5 b: 1.0.
	inputBColor := Color r: 0.0 g: 0.9 b: 0.9.
	
	outputBColor := Color r: 0.6 g: 0.9 b: 0.1.
	
	matchesLineColor := Color r: 0.0 g: 1.0 b: 1.0.
	
	showMatches := true.
	textScale := 0.02.

]

{ #category : #'as yet unclassified' }
VMICPRenderer >> points [
	^self model inputA.
]

{ #category : #rendering }
VMICPRenderer >> renderMatchesOn: canvas [
	
	model matchCollection ifNil: [ ^self. ].
	"
	model matchCollection do: [ :pair |
		self renderStyledLineFrom: (pair first) to: (pair last) in: canvas color: matchesLineColor.
	].
	"

]

{ #category : #rendering }
VMICPRenderer >> renderOn: canvas [
	
	model inputA ifNotNil: [
		model inputA do: [ :p |
			self renderPoint: p radius: lineWidth in: canvas color: inputAColor.
		].
		self renderString: 'inputA' at: (model inputA first) in: canvas color: inputAColor.
	].
	
	model inputB ifNotNil: [
		model inputB do: [ :p |
			self renderPoint: p radius: lineWidth in: canvas color: inputBColor.
		].
		self renderString: 'inputB' at: (model inputB first) in: canvas color: inputBColor.
	].
	
	model outputA ifNotNil: [
		model outputA do: [ : p |
			self renderPoint: p radius: lineWidth in: canvas color: outputBColor.
		].
	].
	
	showMatches ifTrue: [
		self renderMatchesOn: canvas.
	].
	
	super renderOn: canvas.

]
