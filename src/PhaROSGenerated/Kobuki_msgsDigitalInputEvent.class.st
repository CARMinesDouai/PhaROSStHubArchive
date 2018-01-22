Class {
	#name : #'Kobuki_msgsDigitalInputEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalInputEvent class >> rosTypeDefinition [ 
^' bool[4]  values
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalInputEvent class >> rosTypeName [ 
^'kobuki_msgs/DigitalInputEvent'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalInputEvent >> initialize [
	super initialize.
	 self values:  (OrderedCollection new: 4). 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalInputEvent >> values [
	^ self getAt: #values. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDigitalInputEvent >> values: aValue [
	^ self at: #values put: aValue. 

]
