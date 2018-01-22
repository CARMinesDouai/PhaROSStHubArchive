Class {
	#name : #'Kobuki_msgsSound',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> button [
	^3

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> cleaningend [
	^6

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> cleaningstart [
	^5

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> error [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> off [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> on [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> recharge [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound >> initialize [
	super initialize.
	 self value: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound >> value: aValue [
	^ self at: #value put: aValue. 

]
