Class {
	#name : #'Control_msgsPointHeadFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadFeedback >> initialize [
	super initialize.
	 self pointing_angle_error: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadFeedback >> pointing_angle_error [
	^ self getAt: #pointing_angle_error. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadFeedback >> pointing_angle_error: aValue [
	^ self at: #pointing_angle_error put: aValue. 

]
