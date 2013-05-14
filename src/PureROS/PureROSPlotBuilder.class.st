"
allow to build a line for call rxplot program, that line has the shape of topicId/reference/to/a/inner/variable/field1:field2:fieldN

"
Class {
	#name : #PureROSPlotBuilder,
	#superclass : #Object,
	#instVars : [
		'interests'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> addEFKPose [
	^ self newLineFor: '/robot_pose_ekf/odom_combined'. 
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> addPoseStamped [
	^ self newLineFor: '/kompai2/pose'. 
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> addTFBetween: aParentFrame and: aFrame [
	^ self newLineFor:( '/tfaas/{1}/{2}' format: {  (aParentFrame normalizeFrame) . ( aFrame normalizeFrame)}).
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> initialize [ 
	interests := OrderedCollection new
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> newLineFor: aTopicID [
	^  interests add: (PureROSPlotTopic for: aTopicID). 
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> plottingLines [
	^ interests collect: #plotLine	
]
