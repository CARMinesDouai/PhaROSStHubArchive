Class {
	#name : #'Kobuki_msgsRobotStateEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent class >> offline [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent class >> online [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent class >> rosMd5Sum [ 
^'c6eccd4cb1f95df95635b56d6226ea32'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent class >> rosTypeDefinition [ 
^' int8 ONLINE=1
 int8 OFFLINE=0
 int8 state
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent class >> rosTypeName [ 
^'kobuki_msgs/RobotStateEvent'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent >> initialize [
	super initialize.
	 self state: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsRobotStateEvent >> state: aValue [
	^ self at: #state put: aValue. 

]
