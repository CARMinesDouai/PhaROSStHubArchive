Class {
	#name : #'Kobuki_msgsCliffEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> center [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> cliff [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> floor [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> left [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> right [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> bottom [
	^ self getAt: #bottom. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> bottom: aValue [
	^ self at: #bottom put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> initialize [
	super initialize.
	 self sensor: 0. 
	 self state: 0. 
	 self bottom: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> sensor [
	^ self getAt: #sensor. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> sensor: aValue [
	^ self at: #sensor put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent >> state: aValue [
	^ self at: #state put: aValue. 

]
