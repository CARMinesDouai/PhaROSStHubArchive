Class {
	#name : #PureROSKompai,
	#superclass : #PhaROSPackage,
	#instVars : [
		'robotName',
		'process',
		'rosNodeName'
	],
	#category : #PureROSPackageKompai
}

{ #category : #'meta infos' }
PureROSKompai class >> catkinPackageAuthor [
	^ 'SantiagoBragagnolo'
	
]

{ #category : #'meta infos' }
PureROSKompai class >> catkinPackageDescription [
	^'This Kompai package is the low-level part of the Robulab driver. It is a PureNG wrapper for ROS.'
]

{ #category : #'meta infos' }
PureROSKompai class >> catkinPackageName [ 
	^ 'kompai'
]

{ #category : #private }
PureROSKompai >> buildController [ 
	^ PhaROSHandleController home
	
]

{ #category : #'scripts - /pose and /scan' }
PureROSKompai >> publishPoseAndScanFor: aRobotName [
	robotName := aRobotName.
	rosNodeName := robotName, '_driver'.
	self controller nodelets use: PureROSKompaiNodelet as: #kompai.
	self controller nodelets kompai initialize: robotName. 	

	self inform: ('scriptPublishPoseAndScanFor{1} running...' format: { aRobotName asString})
]

{ #category : #'scripts - /pose and /scan' }
PureROSKompai >> scriptPublishPoseAndScanForKompai1 [
	self publishPoseAndScanFor: #kompai1
]

{ #category : #'scripts - /pose and /scan' }
PureROSKompai >> scriptPublishPoseAndScanForKompai2 [
	self publishPoseAndScanFor: #kompai2
]
