Class {
	#name : #'Kobuki_msgsButtonEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> button0 [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> button1 [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> button2 [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> pressed [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> released [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> rosTypeDefinition [ 
^' int8 Button0=0
 int8 Button1=1
 int8 Button2=2
 int8 RELEASED=0
 int8 PRESSED=1
 int8 button
 int8 state
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent class >> rosTypeName [ 
^'kobuki_msgs/ButtonEvent'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent >> button [
	^ self getAt: #button. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent >> button: aValue [
	^ self at: #button put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent >> initialize [
	super initialize.
	 self button: 0. 
	 self state: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsButtonEvent >> state: aValue [
	^ self at: #state put: aValue. 

]
