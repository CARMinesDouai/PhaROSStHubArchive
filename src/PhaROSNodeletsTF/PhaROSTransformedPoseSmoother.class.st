Class {
	#name : #PhaROSTransformedPoseSmoother,
	#superclass : #Object,
	#instVars : [
		'posesStamps',
		'callback',
		'lastTimeStamp',
		'lastPose'
	],
	#category : #PhaROSNodeletsTF
}

{ #category : #'as yet unclassified' }
PhaROSTransformedPoseSmoother >> cull: aPose cull: aChannel cull: aTimeStamp [ 

	(lastTimeStamp isNil or: [aTimeStamp > lastTimeStamp ])ifTrue: [
		self register: aPose at: aTimeStamp. 
	].
	^ callback cull: self pose cull: aChannel cull: aTimeStamp.
]

{ #category : #'as yet unclassified' }
PhaROSTransformedPoseSmoother >> for: aCallback [ 
	callback := aCallback
]

{ #category : #'as yet unclassified' }
PhaROSTransformedPoseSmoother >> initialize [ 
	posesStamps := Dictionary new.
	lastTimeStamp := DateAndTime now - 10 minutes.
]

{ #category : #'as yet unclassified' }
PhaROSTransformedPoseSmoother >> pose [
	| position orientation  poses |
	poses := posesStamps values, { lastPose . lastPose . lastPose }.
	
	position := 	(poses collect: #position ) sum / poses size.
	orientation  := 	(poses  collect: #orientation ) sum / poses size.
	^ PhaROSPose position: position orientation: orientation.
	
]

{ #category : #'as yet unclassified' }
PhaROSTransformedPoseSmoother >> redirect: aPose from: aChannel at: aTimeStamp [ 
	aTimeStamp > lastTimeStamp ifTrue: [
		self register: aPose at: aTimeStamp 
	].
	^ callback cull: self pose cull: aChannel cull: aTimeStamp.
]

{ #category : #'as yet unclassified' }
PhaROSTransformedPoseSmoother >> register: aPose at: aTimeStamp [ 
	| now |
	now := DateAndTime now.
	
	posesStamps keys select: [ : stamp |  (now - stamp) asMilliSeconds > 1000 ] thenDo: [ : stamp | posesStamps removeKey: stamp ].
	posesStamps at: aTimeStamp put: aPose. 
	lastPose := aPose.
	lastTimeStamp := aTimeStamp.
]
