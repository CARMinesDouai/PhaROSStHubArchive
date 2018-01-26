Class {
	#name : #'Yocs_msgsNavigationControlStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> cancelled [
	^4

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> completed [
	^3

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> error [
	^-1

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> idling [
	^0

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> paused [
	^2

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> rosMd5Sum [ 
^'f97c2c5903b273dd04cfb815fadb9f56'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> rosTypeDefinition [ 
^' int8 ERROR=-1
 int8 IDLING=0
 int8 RUNNING=1
 int8 PAUSED=2
 int8 COMPLETED=3
 int8 CANCELLED=4
 int8 status
 string status_desc
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> rosTypeName [ 
^'yocs_msgs/NavigationControlStatus'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> running [
	^1

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus class >> typeCreationOrder [ 
^450
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus >> initialize [
	super initialize.
	 self status: 0. 
	 self status_desc: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus >> status: aValue [
	^ self at: #status put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus >> status_desc [
	^ self getAt: #status_desc. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControlStatus >> status_desc: aValue [
	^ self at: #status_desc put: aValue. 

]
