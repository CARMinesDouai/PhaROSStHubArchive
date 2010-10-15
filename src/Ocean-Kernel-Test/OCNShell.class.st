Class {
	#name : #OCNShell,
	#superclass : #Object,
	#instVars : [
		'stdInWriter',
		'stdInReader',
		'stdOutReader',
		'process',
		'commandLine',
		'stdOutWriter'
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
	self commandLine: commandLineString.
	self setupStdIn.
	self setupStdOut.
	process := (ExternalUnixOSProcess new)
		programName: self programNameWithFullPath;
		arguments: self arguments;
		initialEnvironment: nil.
	process initialStdIn: stdInReader.
	process initialStdOut: stdOutWriter.
	process initialStdErr: stdOutWriter.	"Err -> OUT"
	process value
]

{ #category : #'Path Environment' }
OCNShell >> fileExists: path [
	^ ((OSProcess accessor fileStat: path) isKindOf: String) not
]

{ #category : #'Path Environment' }
OCNShell >> fullExecutablePath: stringCommandName [
	"OCNShell new fullExecutablePath:'lsZ' "

	| allPossiblesFullCommand |
	
	(self fileExists: stringCommandName) ifTrue: [ ^ stringCommandName ].
	allPossiblesFullCommand := (ThisOSProcess thisOSProcess path findTokens: ':')
		collect: [ :directory | directory , FileDirectory pathNameDelimiter asString , stringCommandName ].
	^ allPossiblesFullCommand detect: [ :path | self fileExists: path ] ifNone: [ '' ]
]

{ #category : #testing }
OCNShell >> isStopped [
	self process ifNil: [ ^true ].
	^ self process isComplete 
]

{ #category : #'execution-public' }
OCNShell >> kill [
	self isStopped ifTrue: [^self]. 
	self process ifNotNil: [self process terminate]
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

{ #category : #'command line' }
OCNShell >> programNameWithFullPath [
	^self fullExecutablePath: self programName 
]

{ #category : #'execution-internal' }
OCNShell >> readerAttachedTo: aHandle [
 	^self attachableFileStreamNamed: 'Reader'
							attachedTo: aHandle
							writable: false 
]

{ #category : #'execution-internal' }
OCNShell >> setupStdIn [
	| stdInHandles |
	stdInHandles := OSProcess accessor makePipeHandles.
	stdInReader := self readerAttachedTo: stdInHandles first.
	stdInWriter := self writerAttachedTo: stdInHandles second.
]

{ #category : #'execution-internal' }
OCNShell >> setupStdOut [
	| stdOutHandles |
	stdOutHandles := OSProcess accessor makePipeHandles. 
	stdOutReader := self readerAttachedTo: stdOutHandles first. 
	stdOutWriter := self writerAttachedTo: stdOutHandles second.
	self stdOut setNonBlocking. "Allows sending upToEnd and reading the contents without blocking"

]

{ #category : #accessing }
OCNShell >> stdIn [
	^stdInWriter 
]

{ #category : #accessing }
OCNShell >> stdOut [
	^stdOutReader 
]

{ #category : #'execution-public' }
OCNShell >> waitForStop [
	self waitForStopTimeOutMilliseconds: 500
]

{ #category : #'execution-public' }
OCNShell >> waitForStopTimeOutMilliseconds: duration [
	(Delay forMilliseconds: duration) wait.
	self isStopped ifFalse: [OCNTimeOutException signal: 'Shell not terminated yet!']
]

{ #category : #'execution-internal' }
OCNShell >> writerAttachedTo: aHandle [
 	^self attachableFileStreamNamed: 'Writer'
							attachedTo: aHandle
							writable: true 
]
