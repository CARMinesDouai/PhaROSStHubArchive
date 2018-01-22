Class {
	#name : #'Kobuki_msgsWheelDropEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent class >> dropped [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent class >> left [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent class >> raised [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent class >> right [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent >> initialize [
	super initialize.
	 self wheel: 0. 
	 self state: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent >> state: aValue [
	^ self at: #state put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent >> wheel [
	^ self getAt: #wheel. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsWheelDropEvent >> wheel: aValue [
	^ self at: #wheel put: aValue. 

]
