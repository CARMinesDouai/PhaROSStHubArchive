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
	^ self newLineFor: '/robot_pose_ekf/odom'. 
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> addHectorPose [
	^ self newLineFor: '/pose'. 
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilder >> addPoseStamped [
	^ self newLineFor: '/pose'. 
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
	(interests collect: #entries )sum > 8 ifTrue: [ self error: 'rxplot work with a limit of 8 topics (or variables)'].
	^ interests collect: #plotLine	
]
