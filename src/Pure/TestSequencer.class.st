Class {
	#name : #TestSequencer,
	#superclass : #TestCase,
	#category : #'Pure-Tests-RobotIndependent'
}

{ #category : #'as yet unclassified' }
TestSequencer >> testSequencer [
	| index indexHexa |

	index := 1.
	indexHexa := '01'.
	PureSequencer reset.
	257 timesRepeat: [
		((index printStringBase: 16) size = 1)
		ifTrue: [indexHexa:= ('0',(index printStringBase: 16))asString ]
		ifFalse: [indexHexa:= (index printStringBase: 16)].
		self assert: (PureSequencer instance consumeRequestId = indexHexa).
		index := index + 1.
		(index = 255)ifTrue: [index:= 1 ]
	].
      
	
]
