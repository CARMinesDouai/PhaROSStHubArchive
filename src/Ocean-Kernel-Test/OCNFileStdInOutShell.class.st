Class {
	#name : #OCNFileStdInOutShell,
	#superclass : #OCNFileStdOutShell,
	#instVars : [
		'stdInFileName'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'as yet unclassified' }
OCNFileStdInOutShell class >> onStdInFileNamed: fileNameAndPath [
	^self new
		stdInFileName: fileNameAndPath;
		yourself 
]

{ #category : #'initialize-release' }
OCNFileStdInOutShell >> deleteStdInFile [
	| file |
	file := FileStream fileNamed: self stdInFileName.
	file directory deleteFileNamed: file fullName
]

{ #category : #'initialize-release' }
OCNFileStdInOutShell >> setupStdIn [
	stdInReader := FileStream fileNamed: self stdInFileName.
	stdInWriter := FileStream fileNamed: self stdInFileName
]

{ #category : #accessing }
OCNFileStdInOutShell >> stdIn [
	^FileStream fileNamed: self stdInFileName.
]

{ #category : #accessing }
OCNFileStdInOutShell >> stdInFileName [
	^ stdInFileName
]

{ #category : #accessing }
OCNFileStdInOutShell >> stdInFileName: anObject [
	stdInFileName := anObject
]
