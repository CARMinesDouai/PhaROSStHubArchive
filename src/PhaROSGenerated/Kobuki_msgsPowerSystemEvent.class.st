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
