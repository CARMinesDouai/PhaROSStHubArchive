Class {
	#name : #'Kobuki_msgsMotorPower',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower class >> off [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower class >> on [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower class >> rosMd5Sum [ 
^'8f77c0161e0f2021493136bb5f3f0e51'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower class >> rosTypeDefinition [ 
^' int8 OFF=0
 int8 ON=1
 int8 state
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower class >> rosTypeName [ 
^'kobuki_msgs/MotorPower'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower class >> typeCreationOrder [ 
^174
]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower >> initialize [
	super initialize.
	 self state: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsMotorPower >> state: aValue [
	^ self at: #state put: aValue. 

]
