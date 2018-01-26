Class {
	#name : #'Kobuki_msgsPowerSystemEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> battery_critical [
	^5

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> battery_low [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> charge_completed [
	^3

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> plugged_to_adapter [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> plugged_to_dockbase [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> rosMd5Sum [ 
^'f6464657d6c911b00c7bc7b43a154bf8'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> rosTypeDefinition [ 
^' int8 UNPLUGGED=0
 int8 PLUGGED_TO_ADAPTER=1
 int8 PLUGGED_TO_DOCKBASE=2
 int8 CHARGE_COMPLETED=3
 int8 BATTERY_LOW=4
 int8 BATTERY_CRITICAL=5
 int8 event
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> rosTypeName [ 
^'kobuki_msgs/PowerSystemEvent'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> typeCreationOrder [ 
^175
]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent class >> unplugged [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent >> event [
	^ self getAt: #event. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent >> event: aValue [
	^ self at: #event put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsPowerSystemEvent >> initialize [
	super initialize.
	 self event: 0. 

]
