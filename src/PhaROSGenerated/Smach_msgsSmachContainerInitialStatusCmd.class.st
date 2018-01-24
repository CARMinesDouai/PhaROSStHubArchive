Class {
	#name : #'Smach_msgsSmachContainerInitialStatusCmd',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd class >> rosMd5Sum [ 
^'45f8cf31fc29b829db77f23001f788d6'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd class >> rosTypeDefinition [ 
^' string path
 string[] initial_states
 string local_data
'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd class >> rosTypeName [ 
^'smach_msgs/SmachContainerInitialStatusCmd'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> initial_states [
	^ self getAt: #initial_states. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> initial_states: aValue [
	^ self at: #initial_states put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> initialize [
	super initialize.
	 self path: ''. 
	 self initial_states: OrderedCollection new . 
	 self local_data: ''. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> local_data [
	^ self getAt: #local_data. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> local_data: aValue [
	^ self at: #local_data put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> path [
	^ self getAt: #path. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerInitialStatusCmd >> path: aValue [
	^ self at: #path put: aValue. 

]
