Extension { #name : #ExternalUnixOSProcess }

{ #category : #'*PhaROS' }
ExternalUnixOSProcess >> spinForRos: times [
	times timesRepeat: [
		(times * 100) timesRepeat: [].
		(Delay forMilliseconds: 100) wait.
	]

	
]
