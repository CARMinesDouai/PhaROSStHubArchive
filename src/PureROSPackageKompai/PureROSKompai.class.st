Class {
	#name : #PureROSKompai,
	#superclass : #PhaROSPackage,
	#instVars : [
		'robotName',
		'process',
		'kompaiAbsolutePoseTopic'
	],
	#category : #PureROSPackageKompai
}

{ #category : #private }
PureROSKompai >> build: aRobotName [
	| rbl |
	
	rbl :=  PhaROSHandleController home.
	rbl nodelets use: PureROSKompaiNodelet as: #kompai.
	rbl nodelets kompai initialize: aRobotName. 
	
	^ rbl .
]

{ #category : #private }
PureROSKompai >> buildController [ 
	^ self build: robotName.
	
]

{ #category : #private }
PureROSKompai >> kompaiAbsolutePose: aPose [
	self kompaiAbsolutePoseTopic send: [ : msg | msg pose: aPose asGeometry_msgsPose ].
]

{ #category : #private }
PureROSKompai >> kompaiAbsolutePoseTopic [
	^ kompaiAbsolutePoseTopic ifNil: [
		kompaiAbsolutePoseTopic := self controller node topicPublisher: '/kompai/map/pose' typedAs: 'geometry_msgs/PoseStamped'.	
	]
]

{ #category : #scripts }
PureROSKompai >> scriptKompai1 [
	robotName := #kompai1.
	self controller.		

]

{ #category : #scripts }
PureROSKompai >> scriptKompai2 [
	robotName := #kompai2.
	self controller.		

]

{ #category : #scripts }
PureROSKompai >> scriptLaunchKompai1 [
	
	process := PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai1.
	].
	

]

{ #category : #scripts }
PureROSKompai >> scriptLaunchKompai2 [
	
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai2.
	].
	

]
