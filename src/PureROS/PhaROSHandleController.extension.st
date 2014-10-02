Extension { #name : #PhaROSHandleController }

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

{ #category : #'*PureROS-Nodelet' }
PhaROSHandleController classSide >> robulab: aRobotName nodeNamed: aNodeName [	
	| rbl |
	
	rbl :=  self homeWithNodeNamed: aNodeName.
	rbl nodelets use: PureROSRobulabNodelet as: #robulab.
	rbl nodelets robulab robotName: aRobotName. 
	
	^ rbl .
]
