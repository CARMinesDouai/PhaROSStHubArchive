Class {
	#name : #'Control_msgsGripperCommandFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback class >> rosTypeDefinition [ 
^' float64 position
 float64 effort
 bool stalled
 bool reached_goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback class >> rosTypeName [ 
^'control_msgs/GripperCommandFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> effort [
	^ self getAt: #effort. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> effort: aValue [
	^ self at: #effort put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> initialize [
	super initialize.
	 self position: 0.0. 
	 self effort: 0.0. 
	 self stalled: false. 
	 self reached_goal: false. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> position: aValue [
	^ self at: #position put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> reached_goal [
	^ self getAt: #reached_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> reached_goal: aValue [
	^ self at: #reached_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> stalled [
	^ self getAt: #stalled. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandFeedback >> stalled: aValue [
	^ self at: #stalled put: aValue. 

]
