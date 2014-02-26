Class {
	#name : #PhaROSPoseTrackerNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'lastEntityRecorded'
	],
	#category : #'PhaROS-Nodelets-PoseTracker'
}

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> configure [
	
	self nodelets use: PhaROSLocalizerNodelet as:#localizer.
	self nodelets use: PhaROSTransformationNodelet  as:#transformation.
]

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> initialize [ 
	super initialize.
	lastEntityRecorded := 0
]

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> lastEntityRecorded: anInt [
	lastEntityRecorded := anInt.
]

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> open: aFilePath [
	self nodelets localizer filein: aFilePath.
	self lastEntityRecorded:  (self nodelets localizer entities collect: #id) max.
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> recordCurrentPose [
	| measure currentPose | 
	
	lastEntityRecorded := lastEntityRecorded + 1.
	currentPose := self nodelets  transformation transformBetween: '/base_link' and: '/map'.
	measure := PhaROSLocalizerMeasure id: lastEntityRecorded pose: currentPose.
	
	self nodelets localizer register: measure.
	
	^ measure
]

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> save: aFilePath [
	self nodelets localizer entities do:  #makeImmutable.
	self nodelets localizer fileout: aFilePath.
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseTrackerNodelet >> transformations [ 
	self nodelets localizer transformations.
]
