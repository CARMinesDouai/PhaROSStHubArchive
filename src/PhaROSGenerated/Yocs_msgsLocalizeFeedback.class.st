Class {
	#name : #'Yocs_msgsLocalizeFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeFeedback class >> rosTypeDefinition [ 
^' string message
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeFeedback class >> rosTypeName [ 
^'yocs_msgs/LocalizeFeedback'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeFeedback >> initialize [
	super initialize.
	 self message: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeFeedback >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeFeedback >> message: aValue [
	^ self at: #message put: aValue. 

]
