Extension { #name : #Alien }

{ #category : #'*Ocean-alien' }
Alien >> strcpyFrom: startIndex ofSize: bytesCount [
 "<Integer> <integer> ^<ByteArray>" 
	| byteArray |
	byteArray := ByteArray new: bytesCount.
	self copyInto: byteArray
		from: 1
		to: bytesCount 
		in: self
		startingAt: startIndex .
	^byteArray
]
