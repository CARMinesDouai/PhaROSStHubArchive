Extension { #name : #PhaROSHandleController }

{ #category : #'*purerospackagerobulab' }
PhaROSHandleController classSide >> robulab1 [
	^ self robulab: #kompai1.
]

{ #category : #'*purerospackagerobulab' }
PhaROSHandleController classSide >> robulab2 [
	^ self robulab: #kompai2.
]

{ #category : #'*purerospackagerobulab' }
PhaROSHandleController classSide >> robulab: aName [	
	| rbl |
	
	rbl :=  self home.
	rbl nodelets use: PureROSRobulabNodelet as: #robulab.
	rbl nodelets robulab robotName: aName. 
	
	^ rbl .
]
