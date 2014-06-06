Extension { #name : #TKTTask }

{ #category : #'*ForkIT' }
TKTTask >> forkIt [
	
	^ FKTOneShotAtThirdInstanceRunner new run: self
]
