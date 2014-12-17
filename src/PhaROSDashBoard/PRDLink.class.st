Class {
	#name : #PRDLink,
	#superclass : #Object,
	#instVars : [
		'rosMsgType',
		'from',
		'to'
	],
	#category : #'PhaROSDashBoard-model'
}

{ #category : #'as yet unclassified' }
PRDLink class >> from: aNodeOrTopic to: anotherNodeOrTopic [
	|lnk|
	lnk := self new.
	lnk from: aNodeOrTopic.
	lnk to: anotherNodeOrTopic.
	^ lnk
]

{ #category : #'as yet unclassified' }
PRDLink class >> from: aNodeOrTopic to: anotherNodeOrTopic type: aMessageType [
	|lnk|
	lnk := self new.
	lnk from: aNodeOrTopic.
	lnk to: anotherNodeOrTopic.
	lnk rosMsgType: aMessageType.
	^ lnk
]

{ #category : #accessing }
PRDLink >> from [
	^ from
]

{ #category : #accessing }
PRDLink >> from: anObject [
	from := anObject
]

{ #category : #accessing }
PRDLink >> key [
	^ from
]

{ #category : #accessing }
PRDLink >> rosMsgType [
	^ rosMsgType
]

{ #category : #accessing }
PRDLink >> rosMsgType: anObject [
	rosMsgType := anObject
]

{ #category : #accessing }
PRDLink >> to [
	^ to
]

{ #category : #accessing }
PRDLink >> to: anObject [
	to := anObject
]

{ #category : #accessing }
PRDLink >> value [
	^ to
]
