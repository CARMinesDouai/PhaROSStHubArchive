Extension { #name : #TKTTask }

{ #category : #'*TaskITFork' }
TKTTask >> forkIt [
	
	^ TKTOneShotAtThirdInstanceRunner new run: self
]
