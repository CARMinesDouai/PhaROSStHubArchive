Extension { #name : #PNGDifferentiaVelocity }

{ #category : #'*PureROS' }
PNGDifferentiaVelocity classSide >> fromGeometry_msgs_Twist: aTwist [
	^ self new linear: aTwist linear x; angular: aTwist angular z; yourself.
]
