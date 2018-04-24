Extension { #name : #Color }

{ #category : #'*VectorMaps' }
Color class >> byInteger: anInt [
	| h |
	h := (anInt * 41.0) \\ 360.
	Transcript show: 'Color byInteger: ', anInt printString, ' (h=', h printString, ')'; cr.
	
	^(self h: h s: 1.0 v: 1.0)
]
