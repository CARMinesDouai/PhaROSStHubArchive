"
This class provides scripts for controlling a Robluab through ROS.
It consumes  raw sensor data (/pose) to provide higher level data (/odom and /tf (transform from /odom  to /base_link))
"
Class {
	#name : #PureROSRobulab,
	#superclass : #PhaROSPackage,
	#instVars : [
		'rosNodeName',
		'robotName'
	],
	#category : #PureROSPackageRobulab
}

{ #category : #'meta infos' }
PureROSRobulab class >> catkinPackageAuthor [
	^ 'LucFabresse'
	
]

{ #category : #'meta infos' }
PureROSRobulab class >> catkinPackageDescription [
	^ 'This package is the high-level part of the ROS driver for Robulab. It relies on the PureROSKompai package'
]

{ #category : #'meta infos' }
PureROSRobulab class >> catkinPackageName [ 
	^ 'robulab'
]

{ #category : #private }
PureROSRobulab >> buildController [
	| controller |
	controller := PhaROSHandleController homeWithNodeNamed: rosNodeName.
	controller nodelets use: PureROSRobulabNodelet as: #robulab.
	controller nodelets robulab robotName: robotName. 
	^ controller
]

{ #category : #'scripts /odom' }
PureROSRobulab >> publishOdomFor: aRobotName [
	robotName := aRobotName.
	rosNodeName := robotName, '_odom'.
	2 seconds wait. "important because /pose must be available for subscritption"
	self controller nodelets odometer transformToOdometry: self controller nodelets robulab  poseStamped.
	self inform: ('scriptPublishOdomFor{1} running...' format: { aRobotName asString })
]

{ #category : #'script /tf' }
PureROSRobulab >> publishOdomToBaseLinkTfFor: aRobotName [
	| namespace |
	4 seconds wait. "important because /pose must be available for subscritption and the /odom frame should be known in tf"
	robotName := aRobotName.
	rosNodeName := robotName, '_tf_odom_to_base_link'.
	namespace := '/', robotName asString.
	self controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	self controller nodelets pose2tf 
		express: self controller nodelets robulab poseStamped 
		as: namespace, PureROSRobulabNodelet baseLinkFrame 
		childOf: namespace, PureROSRobulabNodelet baseLinkParentFrame.
	self inform: ('scriptPublishOdomToBaseLinkTfFor{1} running...' format: { aRobotName asString })
]

{ #category : #'scripts /odom' }
PureROSRobulab >> scriptPublishOdomForKompai1 [
	self publishOdomFor: #kompai1
]

{ #category : #'scripts /odom' }
PureROSRobulab >> scriptPublishOdomForKompai2 [
	self publishOdomFor: #kompai2
]

{ #category : #'script /tf' }
PureROSRobulab >> scriptPublishOdomToBaseLinkTfForKompai1 [
	self publishOdomToBaseLinkTfFor: #kompai1
]

{ #category : #'script /tf' }
PureROSRobulab >> scriptPublishOdomToBaseLinkTfForKompai2 [
	self publishOdomToBaseLinkTfFor: #kompai2
]
