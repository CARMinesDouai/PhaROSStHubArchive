Class {
	#name : #PhaROSFrameContainer,
	#superclass : #Object,
	#instVars : [
		'frames',
		'interested'
	],
	#category : #'PhaROS-Packages-TF'
}

{ #category : #'as yet unclassified' }
PhaROSFrameContainer >> at: aFrameID [
	^ frames at: aFrameID ifAbsentPut: [ PhaROSTFFrame id: aFrameID ]
]

{ #category : #'as yet unclassified' }
PhaROSFrameContainer >> finalize [ 
	frames removeAll.
	interested removeAll.
	
]

{ #category : #'as yet unclassified' }
PhaROSFrameContainer >> initialize [ 
	frames := Dictionary new.
	interested := Dictionary new. 
	
]

{ #category : #'as yet unclassified' }
PhaROSFrameContainer >> process: aTFMessage from: aChn [
	
	aTFMessage transforms do: [ : t | 
		(self at: t child_frame_id ) updateFrom: t using: self broadcaster: aChn owner.
	].
	
	interested valuesDo: [ : announcer | 
		[announcer inform.] on: PhaROSTFError do: [: e | Transcript show: e messageText; cr. ].	
	].
]

{ #category : #'as yet unclassified' }
PhaROSFrameContainer >> pseudoTopicBetween:  aFrameID and: anOtherFrameID [ 
	^ interested at: (aFrameID, anOtherFrameID) ifAbsentPut: [
		PhaROSFrameRelativePoseAnnouncer from: (self at: aFrameID) to: (self at: anOtherFrameID).
	]. 
	
]
