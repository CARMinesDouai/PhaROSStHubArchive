Class {
	#name : #TKTPlanResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'kind',
		'setted'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanResult class >> for: aResult [
	^ self new result: aResult; yourself
]

{ #category : #'as yet unclassified' }
TKTPlanResult >> arguments [
	^ kind = #isAlreadyArguments ifTrue: [ 
		setted ifFalse: [  self error: 'There is not result deployed' ].
		result	
	 ] ifFalse:[
		setted  ifFalse: [  { }  ] 
				ifTrue: [ { result } ]
	]
	
]

{ #category : #polimorfism }
TKTPlanResult >> asArray [
	^ self arguments
]

{ #category : #'as yet unclassified' }
TKTPlanResult >> initialize [ 
	kind := #isNotAlreadyArguments.
	setted := false.
]

{ #category : #'as yet unclassified' }
TKTPlanResult >> isSetted [
	^ setted
]

{ #category : #'as yet unclassified' }
TKTPlanResult >> result [
	^ result
]

{ #category : #'as yet unclassified' }
TKTPlanResult >> result: aResult [
	result := aResult.
	setted := true.
]

{ #category : #'as yet unclassified' }
TKTPlanResult >> setAsArguments [
	kind := #isAlreadyArguments
]
