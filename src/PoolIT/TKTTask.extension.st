Extension { #name : #TKTTask }

{ #category : #'*PoolIT' }
TKTTask >> scheduleIt [
	^ PITWorkersPool it: self.
]
