Extension { #name : #TKTWorker }

{ #category : #'*PoolIT' }
TKTWorker >> busyTime [
	^ workingQueue size * 500.
]

{ #category : #'*PoolIT' }
TKTWorker >> matching: anOtherTask [ 
	| frequency |
	
	frequency :=  workingQueue timeout.  
	(anOtherTask respondsTo: #expectedFrequency) ifTrue: [
		frequency := frequency - (1000 // anOtherTask expectedFrequency).
	]. 
	
	^ ((self priority - anOtherTask priority ) abs * 1000) + self busyTime + frequency.
]
