Extension { #name : #ExternalUnixOSProcess }

{ #category : #'*PhaROS' }
ExternalUnixOSProcess >> finalize [
	self sigterm.
	self spin: 10.
	self sigkill.
	super finalize.
]

{ #category : #'*PhaROS' }
ExternalUnixOSProcess >> spin: times [
	times timesRepeat: [
		(times * 100) timesRepeat: [].
		(Delay forMilliseconds: 100) wait.
	]

	
]

{ #category : #'*PhaROS' }
ExternalUnixOSProcess >> waitUntilComplete [
	

	[ self isComplete ] whileFalse: [ self waitUntilCompleteRate wait]
]

{ #category : #'*PhaROS' }
ExternalUnixOSProcess >> waitUntilCompleteRate [
	^ 0.5hz.
]
