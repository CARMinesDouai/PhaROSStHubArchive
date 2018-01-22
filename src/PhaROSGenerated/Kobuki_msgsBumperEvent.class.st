Class {
	#name : #'Kobuki_msgsBumperEvent',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> center [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> left [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> pressed [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> released [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> right [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> rosTypeDefinition [ 
^' int8 LEFT=0
 int8 CENTER=1
 int8 RIGHT=2
 int8 RELEASED=0
 int8 PRESSED=1
 int8 bumper
 int8 state
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent class >> rosTypeName [ 
^'kobuki_msgs/BumperEvent'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent >> bumper [
	^ self getAt: #bumper. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent >> bumper: aValue [
	^ self at: #bumper put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent >> initialize [
	super initialize.
	 self bumper: 0. 
	 self state: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsBumperEvent >> state: aValue [
	^ self at: #state put: aValue. 

]
