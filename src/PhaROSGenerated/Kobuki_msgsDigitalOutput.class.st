Class {
	#name : #'Kobuki_msgsDigitalOutput',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalOutput >> initialize [
	super initialize.
	 self values:  (OrderedCollection new: 4). 
	 self mask:  (OrderedCollection new: 4). 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalOutput >> mask [
	^ self getAt: #mask. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalOutput >> mask: aValue [
	^ self at: #mask put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalOutput >> values [
	^ self getAt: #values. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalOutput >> values: aValue [
	^ self at: #values put: aValue. 

]
