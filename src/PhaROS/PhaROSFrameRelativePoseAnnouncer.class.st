Class {
	#name : #PhaROSFrameRelativePoseAnnouncer,
	#superclass : #PhaROSTopicFlux,
	#instVars : [
		'fromFrame',
		'toFrame'
	],
	#category : #'PhaROS-Nodelets-TF'
}

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer class >> from: aFrame to: anOtherFrame [
	^ self new from: aFrame; to: anOtherFrame; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> checkFrame: aFrame [
	self checkStamp: aFrame.
	aFrame isBeingBroadcasted ifFalse: [
		PhaROSTFError signal: aFrame name, ' is not being broadcasted. '.	
	].


]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> checkStamp: aFrame [
	self flag: #uncommentThisAndCheckWTFIsgoingONWithSyncro.
	
	
	"	| now st | 
	
	now := DateAndTime now.
	st := aFrame stamp timestamp.
	((aFrame stamp - now) asMilliSeconds < self threshold) ifFalse: [
		self halt.
		PhaROSTFError signal: aFrame name, ' data is too old '.
	]."
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> fetchStamp: aPose [
	^ fromFrame stamp max: toFrame stamp.
	
	
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> for: aCallback [
	callback add: aCallback 
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> from: aFrame [
	fromFrame := aFrame
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> inform [

	self checkFrame: fromFrame.
	self checkFrame: toFrame.
	
	self receive: (fromFrame poseRelativeTo: toFrame) from: self. 
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> initialize [
	super initialize. 
	callback := Set new.
	condition := PhaROSTopicFlux defaultConditional.
	adapter := PhaROSTopicFlux defaultAdapter adaptToAdapter.
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> redirect: anAdaptedMessage from: aChannel at: aTimeStamp [ 
	callback do: [
		: cb |
		cb cull: anAdaptedMessage cull: aChannel cull: aTimeStamp.	
	].
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> threshold [ 
	^ 500 "milliseconds"
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseAnnouncer >> to: aFrame [ 
	toFrame := aFrame.
]
