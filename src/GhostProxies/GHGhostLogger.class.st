Class {
	#name : #GHGhostLogger,
	#superclass : #Object,
	#classVars : [
		'ProxiesLoggerHolder'
	],
	#category : #GhostProxies
}

{ #category : #'change loggers' }
GHGhostLogger class >> changeToFileLogger [
	"ProxiesLogger changeToFileLogger"
	^ self initialize
]

{ #category : #'change loggers' }
GHGhostLogger class >> changeToTranscriptLogger [
	| logger |
	logger := SimpleLogger new.
	logger strategy: TranscriptLoggerStrategy new. 
	logger startLogging.
	ProxiesLoggerHolder := logger.
]

{ #category : #'initialize-release' }
GHGhostLogger class >> createAndSetLogger [
	ProxiesLoggerHolder := self createLogger.
]

{ #category : #'initialize-release' }
GHGhostLogger class >> createLogger [
	| logger |
	logger := SimpleLogger new.
	logger strategy: (FixesFileNameLoggerStrategy named: 'GhostLog.txt'). 
	logger startLogging.
	^ logger
]

{ #category : #'change loggers' }
GHGhostLogger class >> disableLogging [
	| logger |
	logger := SimpleLogger new.
	logger strategy: NullLoggerStrategy new. 
	logger startLogging.
	ProxiesLoggerHolder := logger.
]

{ #category : #examples }
GHGhostLogger class >> example [
	MyAppLogger logger mareaLog: 'zaraza'
	"Actually the idae is that you can create a method *MyAppLogger in Object that does:
	log: anObject
		MyAppLogger logger log: anObject
	
	So after, everywhere in your app you can just do self log: 'something'.
	"
	
]

{ #category : #'initialize-release' }
GHGhostLogger class >> initialize [ 
	ProxiesLoggerHolder := self createLogger.
	Smalltalk addToShutDownList: self.
	Smalltalk addToStartUpList: self.
]

{ #category : #accessing }
GHGhostLogger class >> logger [
	ProxiesLoggerHolder
		ifNil: [ProxiesLoggerHolder := self createLogger].
	^ ProxiesLoggerHolder
]

{ #category : #'initialize-release' }
GHGhostLogger class >> reopenStreamIfExists [
	self logger reopenStreamIfClosed
]

{ #category : #'initialize-release' }
GHGhostLogger class >> shutDown [

]

{ #category : #'initialize-release' }
GHGhostLogger class >> startUp [
	self reopenStreamIfExists
]

{ #category : #seeClassSide }
GHGhostLogger >> seeClassSide [ 
]
