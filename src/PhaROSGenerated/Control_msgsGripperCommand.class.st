Class {
	#name : #'Control_msgsGripperCommand',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand class >> rosTypeDefinition [ 
^' float64 position
 float64 max_effort
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand class >> rosTypeName [ 
^'control_msgs/GripperCommand'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand >> initialize [
	super initialize.
	 self position: 0.0. 
	 self max_effort: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand >> max_effort [
	^ self getAt: #max_effort. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand >> max_effort: aValue [
	^ self at: #max_effort put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommand >> position: aValue [
	^ self at: #position put: aValue. 

]
