Class {
	#name : #'Control_msgsJointTolerance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance class >> rosMd5Sum [ 
^'f544fe9c16cf04547e135dd6063ff5be'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance class >> rosTypeDefinition [ 
^' string name
 float64 position
 float64 velocity
 float64 acceleration
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance class >> rosTypeName [ 
^'control_msgs/JointTolerance'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> acceleration [
	^ self getAt: #acceleration. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> acceleration: aValue [
	^ self at: #acceleration put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> initialize [
	super initialize.
	 self name: ''. 
	 self position: 0.0. 
	 self velocity: 0.0. 
	 self acceleration: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> position: aValue [
	^ self at: #position put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> velocity [
	^ self getAt: #velocity. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTolerance >> velocity: aValue [
	^ self at: #velocity put: aValue. 

]
