Class {
	#name : #'Smach_msgsSmachContainerStructure',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure class >> rosMd5Sum [ 
^'3d3d1e0d0f99779ee9e58101a5dcf7ea'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string path
 string[] children
 string[] internal_outcomes
 string[] outcomes_from
 string[] outcomes_to
 string[] container_outcomes
'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure class >> rosTypeName [ 
^'smach_msgs/SmachContainerStructure'
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure class >> typeCreationOrder [ 
^288
]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> children [
	^ self getAt: #children. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> children: aValue [
	^ self at: #children put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> container_outcomes [
	^ self getAt: #container_outcomes. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> container_outcomes: aValue [
	^ self at: #container_outcomes put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self path: ''. 
	 self children: OrderedCollection new . 
	 self internal_outcomes: OrderedCollection new . 
	 self outcomes_from: OrderedCollection new . 
	 self outcomes_to: OrderedCollection new . 
	 self container_outcomes: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> internal_outcomes [
	^ self getAt: #internal_outcomes. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> internal_outcomes: aValue [
	^ self at: #internal_outcomes put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> outcomes_from [
	^ self getAt: #outcomes_from. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> outcomes_from: aValue [
	^ self at: #outcomes_from put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> outcomes_to [
	^ self getAt: #outcomes_to. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> outcomes_to: aValue [
	^ self at: #outcomes_to put: aValue. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> path [
	^ self getAt: #path. 

]

{ #category : #'as yet unclassified' }
Smach_msgsSmachContainerStructure >> path: aValue [
	^ self at: #path put: aValue. 

]
