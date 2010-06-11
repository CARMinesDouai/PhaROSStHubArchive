Class {
	#name : #OCNShell,
	#superclass : #Object,
	#instVars : [
		'stdInWriter',
		'stdOutReader',
		'process',
		'commandLine'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'command line' }
OCNShell >> arguments [
	^self commandLine substrings copyWithoutFirst
]

{ #category : #'execution-internal' }
OCNShell >> attachableFileStreamNamed: aString attachedTo: aHandle writable: aBoolean [
 	^AttachableFileStream
							name: aString
							attachTo: aHandle
							writable: aBoolean 
]

{ #category : #'command line' }
OCNShell >> commandLine [
	^commandLine
]

{ #category : #'command line' }
OCNShell >> commandLine: commandLineString [
	commandLine := commandLineString
]

{ #category : #'execution-public' }
OCNShell >> exec: commandLineString [ 
	| stdInHandles stdInReader stdOutHandles stdOutWriter |
	self commandLine: commandLineString.
	
stdInHandles := OSProcess accessor makePipeHandles. 
stdInReader := self readerAttachedTo: stdInHandles first. 
stdInWriter := self writerAttachedTo: stdInHandles second.
stdOutHandles := OSProcess accessor makePipeHandles. 
stdOutReader := self readerAttachedTo: stdOutHandles first. 
stdOutWriter := self writerAttachedTo: stdOutHandles second.

process := ExternalUnixOSProcess new
		programName: self programName;
		arguments: self arguments;
		initialEnvironment: nil.

process initialStdIn: stdInReader.
process initialStdOut: stdOutWriter.
process initialStdErr: stdOutWriter. "Err -> OUT"
process value.
]

{ #category : #testing }
OCNShell >> isTerminated [
	^self process isComplete 
]

{ #category : #accessing }
OCNShell >> process [
	^ process
]

{ #category : #accessing }
OCNShell >> process: anObject [
	process := anObject
]

{ #category : #'command line' }
OCNShell >> programName [
	^self commandLine substrings first
]

{ #category : #'execution-internal' }
OCNShell >> readerAttachedTo: aHandle [
 	^self attachableFileStreamNamed: 'Reader'
							attachedTo: aHandle
							writable: false 
]

{ #category : #accessing }
OCNShell >> stdOut [
	^stdOutReader 
]

{ #category : #'execution-public' }
OCNShell >> waitForTermination [
	self waitForTerminationTimeOutMilliseconds: 500
]

{ #category : #'execution-public' }
OCNShell >> waitForTerminationTimeOutMilliseconds: duration [
	(Delay forMilliseconds: duration) wait.
	self isTerminated ifFalse: [OCNTimeOutException signal: 'Shell not terminated yet!']
]

{ #category : #'execution-internal' }
OCNShell >> writerAttachedTo: aHandle [
 	^self attachableFileStreamNamed: 'Writer'
							attachedTo: aHandle
							writable: true 
]
