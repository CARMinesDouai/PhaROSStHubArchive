Class {
	#name : #'Yocs_msgsNavigateToFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback class >> status_error [
	^23

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback class >> status_inprogress [
	^22

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback class >> status_retry [
	^21

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> initialize [
	super initialize.
	 self message: ''. 
	 self distance: 0.0. 
	 self remain_time: 0.0. 
	 self status: 0. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> message: aValue [
	^ self at: #message put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> remain_time [
	^ self getAt: #remain_time. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> remain_time: aValue [
	^ self at: #remain_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
