Class {
	#name : #'Smach_msgsSmachContainerStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus class >> rosMd5Sum [ 
^'5ba2bb79ac19e3842d562a191f2a675b'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string path
 string[] initial_states
 string[] active_states
 string local_data
 string info
'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus class >> rosTypeName [ 
^'smach_msgs/SmachContainerStatus'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus class >> typeCreationOrder [ 
^287
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> active_states [
	^ self getAt: #active_states. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> active_states: aValue [
	^ self at: #active_states put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> info [
	^ self getAt: #info. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> info: aValue [
	^ self at: #info put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> initial_states [
	^ self getAt: #initial_states. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> initial_states: aValue [
	^ self at: #initial_states put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self path: ''. 
	 self initial_states: OrderedCollection new . 
	 self active_states: OrderedCollection new . 
	 self local_data: ''. 
	 self info: ''. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> local_data [
	^ self getAt: #local_data. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> local_data: aValue [
	^ self at: #local_data put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> path [
	^ self getAt: #path. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStatus >> path: aValue [
	^ self at: #path put: aValue. 

]
