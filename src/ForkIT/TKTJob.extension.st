Extension { #name : #TKTJob }

{ #category : #'*ForkIT' }
TKTJob >> forkIt [
	
	^ FKTOneShotAtThirdInstanceRunner new run: self
]
