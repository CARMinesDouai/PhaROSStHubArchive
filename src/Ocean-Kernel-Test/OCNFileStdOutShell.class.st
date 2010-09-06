Class {
	#name : #OCNFileStdOutShell,
	#superclass : #OCNShell,
	#instVars : [
		'stdOutFileName'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'instance creation' }
OCNFileStdOutShell class >> onStdOutFileNamed: fileNameAndPath [
	^self new
		stdOutFileName: fileNameAndPath;
		yourself 
]

{ #category : #'initialize-release' }
OCNFileStdOutShell >> deleteStdOutFile [
	| file |
	file := FileStream fileNamed: self stdOutFileName.
	file directory deleteFileNamed: file fullName
]

{ #category : #'initialize-release' }
OCNFileStdOutShell >> setupStdOut [
	self deleteStdOutFile.
	stdOutReader := FileStream fileNamed: self stdOutFileName.
	stdOutWriter := FileStream fileNamed: self stdOutFileName
]

{ #category : #accessing }
OCNFileStdOutShell >> stdOut [
	^FileStream fileNamed: self stdOutFileName.
]

{ #category : #accessing }
OCNFileStdOutShell >> stdOutFileName [
	^stdOutFileName 
]

{ #category : #accessing }
OCNFileStdOutShell >> stdOutFileName: filenameAndPath [
	stdOutFileName := filenameAndPath.

]
