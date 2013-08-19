Extension { #name : #PhaROSHandleController }

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> kompai1 [
	^ self kompai: #kompai1.
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> kompai2 [
	^ self kompai: #kompai2.
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> kompai: aName [	
	| rbl |
	
	rbl :=  self home.
	rbl nodelets use: PureROSKompaiNodelet as: #kompai.
	rbl nodelets kompai initialize: aName. 
	
	^ rbl .
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> robulab1 [
	^ self robulab: #kompai1.
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> robulab2 [
	^ self robulab: #kompai2.
]

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> robulab: aName [	
	| rbl |
	
	rbl :=  self home.
	rbl nodelets use: PureROSRobulabNodelet as: #robulab.
	rbl nodelets robulab robotName: aName. 
	
	^ rbl .
]
