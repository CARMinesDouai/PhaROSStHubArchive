Extension { #name : #FileReference }

{ #category : #'*PhaROSCommander' }
FileReference >> deleteRecursively [
	self isDirectory ifTrue: [
		self directories do: #deleteRecursively.
		self files do:#delete.
	].
	self delete.
]
