Class {
	#name : #'Kobuki_msgsExternalPower',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> off [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> on [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> pwr_12v1_5a [
	^3

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> pwr_12v5a [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> pwr_3_3v1a [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> pwr_5v1a [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> rosTypeDefinition [ 
^' int8 PWR_3_3V1A=0
 int8 PWR_5V1A=1
 int8 PWR_12V5A=2
 int8 PWR_12V1_5A=3
 int8 OFF=0
 int8 ON=1
 int8 source
 int8 state
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower class >> rosTypeName [ 
^'kobuki_msgs/ExternalPower'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower >> initialize [
	super initialize.
	 self source: 0. 
	 self state: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower >> source [
	^ self getAt: #source. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower >> source: aValue [
	^ self at: #source put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsExternalPower >> state: aValue [
	^ self at: #state put: aValue. 

]
