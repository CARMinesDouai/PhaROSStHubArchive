Class {
	#name : #'Kobuki_msgsLed',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsLed class >> black [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsLed class >> green [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsLed class >> orange [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsLed class >> red [
	^3

]

{ #category : #'as yet unclassified' }
Kobuki_msgsLed >> initialize [
	super initialize.
	 self value: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsLed >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsLed >> value: aValue [
	^ self at: #value put: aValue. 

]
