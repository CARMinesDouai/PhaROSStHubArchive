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
