"
An IMArduinoLed is xxxxxxxxx.

Instance Variables
	currentValue:		<Object>
	out:		<Object>

currentValue
	- xxxxx

out
	- xxxxx

"
Class {
	#name : #IMArduinoLed,
	#superclass : #Object,
	#instVars : [
		'out',
		'currentValue'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
IMArduinoLed class >> for: aTopicPublisher [ 
	^ self new setOutPublisher: aTopicPublisher; yourself 
]

{ #category : #testing }
IMArduinoLed >> isOn [
	^ currentValue 
]

{ #category : #domain }
IMArduinoLed >> off [
	self out: false.
]

{ #category : #domain }
IMArduinoLed >> on [
	self out: true.
]

{ #category : #private }
IMArduinoLed >> out: aBoolean [
	currentValue := aBoolean.
	out send:[ : m | m data: aBoolean ].
	
]

{ #category : #private }
IMArduinoLed >> setOutPublisher: aTopicPublisher [ 
	out := aTopicPublisher
]
