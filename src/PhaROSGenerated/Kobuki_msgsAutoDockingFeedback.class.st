Class {
	#name : #'Kobuki_msgsAutoDockingFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback class >> rosMd5Sum [ 
^'03343b6aa0067ce6251bcc08bf318388'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback class >> rosTypeDefinition [ 
^' string state
 string text
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback class >> rosTypeName [ 
^'kobuki_msgs/AutoDockingFeedback'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback >> initialize [
	super initialize.
	 self state: ''. 
	 self text: ''. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback >> state: aValue [
	^ self at: #state put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback >> text [
	^ self getAt: #text. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingFeedback >> text: aValue [
	^ self at: #text put: aValue. 

]
