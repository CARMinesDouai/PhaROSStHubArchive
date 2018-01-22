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
