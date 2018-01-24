Class {
	#name : #'Control_msgsSingleJointPositionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback class >> rosMd5Sum [ 
^'8cee65610a3d08e0a1bded82f146f1fd'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 position
 float64 velocity
 float64 error
'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback class >> rosTypeName [ 
^'control_msgs/SingleJointPositionFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self position: 0.0. 
	 self velocity: 0.0. 
	 self error: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> position: aValue [
	^ self at: #position put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> velocity [
	^ self getAt: #velocity. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionFeedback >> velocity: aValue [
	^ self at: #velocity put: aValue. 

]
