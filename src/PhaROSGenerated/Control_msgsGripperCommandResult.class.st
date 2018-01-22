Class {
	#name : #'Control_msgsGripperCommandResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult class >> rosTypeDefinition [ 
^' float64 position
 float64 effort
 bool stalled
 bool reached_goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult class >> rosTypeName [ 
^'control_msgs/GripperCommandResult'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> effort [
	^ self getAt: #effort. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> effort: aValue [
	^ self at: #effort put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> initialize [
	super initialize.
	 self position: 0.0. 
	 self effort: 0.0. 
	 self stalled: false. 
	 self reached_goal: false. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> position: aValue [
	^ self at: #position put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> reached_goal [
	^ self getAt: #reached_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> reached_goal: aValue [
	^ self at: #reached_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> stalled [
	^ self getAt: #stalled. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandResult >> stalled: aValue [
	^ self at: #stalled put: aValue. 

]
