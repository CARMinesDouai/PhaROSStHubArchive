Class {
	#name : #'Std_msgsHeader',
	#superclass : #PhaROSValue,
	#classInstVars : [
		'mutex',
		'currentId'
	],
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
Std_msgsHeader class >> consumeHeaderId [
	| id |
	mutex critical: [
		id := currentId.
		currentId := currentId +1.
	].
	
	^ id.
]

{ #category : #'as yet unclassified' }
Std_msgsHeader class >> initialize [ 
	mutex := Mutex new. 
	currentId := 1.
]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> initialize [
	super initialize.
	 self seq: Std_msgsHeader consumeHeaderId. 
	 self stamp:  DateAndTime now. 
	 self frame_id: ''. 

]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> seq [
	^ self getAt: #seq. 

]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> seq: aValue [
	^ self at: #seq put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> stamp [
	^ self getAt: #stamp. 

]

{ #category : #'as yet unclassified' }
Std_msgsHeader >> stamp: aValue [
	^ self at: #stamp put: aValue. 

]
