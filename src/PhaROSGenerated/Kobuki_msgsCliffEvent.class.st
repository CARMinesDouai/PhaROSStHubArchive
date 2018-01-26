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
Kobuki_msgsCliffEvent class >> rosMd5Sum [ 
^'c5b106efbb1427a94f517c5e05f06295'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> rosTypeDefinition [ 
^' int8 LEFT=0
 int8 CENTER=1
 int8 RIGHT=2
 int8 FLOOR=0
 int8 CLIFF=1
 int8 sensor
 int8 state
 uint16 bottom
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> rosTypeName [ 
^'kobuki_msgs/CliffEvent'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsCliffEvent class >> typeCreationOrder [ 
^166
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
