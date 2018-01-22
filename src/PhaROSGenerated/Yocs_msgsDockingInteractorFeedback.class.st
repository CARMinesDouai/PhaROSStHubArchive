Class {
	#name : #'Yocs_msgsDockingInteractorFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback class >> debug [
	^1

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback class >> error [
	^8

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback class >> info [
	^2

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback class >> warn [
	^4

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback >> initialize [
	super initialize.
	 self level: 0. 
	 self message: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback >> level [
	^ self getAt: #level. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback >> level: aValue [
	^ self at: #level put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorFeedback >> message: aValue [
	^ self at: #message put: aValue. 

]
