Class {
	#name : #'Kobuki_msgsDockInfraRed',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> far_center [
	^8

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> far_left [
	^16

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> far_right [
	^32

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> near_center [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> near_left [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> near_right [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> rosTypeDefinition [ 
^' int8 NEAR_LEFT=1
 int8 NEAR_CENTER=2
 int8 NEAR_RIGHT=4
 int8 FAR_LEFT=16
 int8 FAR_CENTER=8
 int8 FAR_RIGHT=32
 std_msgs/Header header
 int8[] data
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed class >> rosTypeName [ 
^'kobuki_msgs/DockInfraRed'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsDockInfraRed >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self data: OrderedCollection new . 

]
