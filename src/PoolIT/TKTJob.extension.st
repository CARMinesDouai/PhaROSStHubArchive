Extension { #name : #TKTJob }

{ #category : #'*PoolIT' }
TKTJob >> scheduleIt [
	^ PITWorkersPool it: self.
]
