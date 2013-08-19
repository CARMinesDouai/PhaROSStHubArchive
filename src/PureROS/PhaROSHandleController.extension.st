Extension { #name : #PhaROSHandleController }

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> kompai1 [
	^ self robulab: #kompai1.
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> kompai2 [
	^ self robulab: #kompai2.
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> robulab: aName [	
	| rbl |
	
	rbl :=  self home.
	rbl nodelets use: PureROSRobulabNodelet as: #robulab.
	rbl nodelets robulab initialize: aName. 
	
	^ rbl .
]
