Extension { #name : #ByteString }

{ #category : #'*PhaROSDashboard' }
ByteString >> colorIsPingable [

	^(PhaROSSystemInfo instance pingNode: self) size = 3 
		ifTrue:[Color green]
		ifFalse: [Color gray].
]
