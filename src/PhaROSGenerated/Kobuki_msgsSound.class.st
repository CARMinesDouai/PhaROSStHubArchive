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
Kobuki_msgsSound class >> rosMd5Sum [ 
^'dfeab0daae67749c426c1db741a4f420'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> rosTypeDefinition [ 
^' int8 ON=0
 int8 OFF=1
 int8 RECHARGE=2
 int8 BUTTON=3
 int8 ERROR=4
 int8 CLEANINGSTART=5
 int8 CLEANINGEND=6
 int8 value
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsSound class >> rosTypeName [ 
^'kobuki_msgs/Sound'
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
