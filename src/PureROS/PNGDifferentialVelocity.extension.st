Extension { #name : #PNGDifferentialVelocity }

{ #category : #'*PureROS' }
PNGDifferentialVelocity classSide >> fromGeometry_msgsTwist: aTwist [
	^ self new linear: aTwist linear x; angular: aTwist angular z; yourself.
]
