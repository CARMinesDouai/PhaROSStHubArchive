Class {
	#name : #'Control_msgsPointHeadFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadFeedback class >> rosMd5Sum [ 
^'cce80d27fd763682da8805a73316cab4'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadFeedback class >> rosTypeDefinition [ 
^' float64 pointing_angle_error
'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadFeedback class >> rosTypeName [ 
^'control_msgs/PointHeadFeedback'
]

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
