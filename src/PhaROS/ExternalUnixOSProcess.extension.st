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
