Class {
	#name : #OCNFileStdOutShell,
	#superclass : #OCNShell,
	#instVars : [
		'stdOutFilename'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'initialize-release' }
OCNFileStdOutShell >> deleteStdOutFile [
	| file |
	file := FileStream fileNamed: self stdOutFilename.
	file directory deleteFileNamed: file fullName
]

{ #category : #'initialize-release' }
OCNFileStdOutShell >> setupStdOut [
	self deleteStdOutFile.
	stdOutReader := FileStream fileNamed: self stdOutFilename.
	stdOutWriter := FileStream fileNamed: self stdOutFilename
]

{ #category : #accessing }
OCNFileStdOutShell >> stdOut [
	^FileStream fileNamed: self stdOutFilename.
]

{ #category : #accessing }
OCNFileStdOutShell >> stdOutFilename [
	^stdOutFilename 
]

{ #category : #accessing }
OCNFileStdOutShell >> stdOutFilename: filenameAndPath [
	stdOutFilename := filenameAndPath.

]
