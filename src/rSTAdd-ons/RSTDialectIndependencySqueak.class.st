"
Deprecated class
"
Class {
	#name : #RSTDialectIndependencySqueak,
	#superclass : #RSTDialectIndependency,
	#instVars : [
		'loggingMutex',
		'logFile'
	],
	#category : 'rSTAdd-ons'
}

{ #category : #initialization }
RSTDialectIndependencySqueak >> closeLogFile [
	"mp 4/28/2006 10:28"
	
	logFile close.
	logFile := nil
]

{ #category : #initialization }
RSTDialectIndependencySqueak >> createLogFile [
	"mp 4/28/2006 10:28"
	
	logFile := FileDirectory default forceNewFileNamed: 'rST-debug.log'.
	logFile ensureOpen  "file reports to be closed on windows..."
]

{ #category : #initialization }
RSTDialectIndependencySqueak >> initialize [
	super initialize.
	loggingMutex := Semaphore forMutualExclusion.
	self createLogFile
]

{ #category : #logging }
RSTDialectIndependencySqueak >> logMessage: aBlock [ 
	"mp 4/21/2006 12:22"
	"log to a file"
	self flag: #deprecated.
	
	loggingMutex critical: [
		logFile ifNil: [self createLogFile].
		logFile
			cr;
			nextPutAll: (Date today printFormat: #(3 2 1 $/ 1 1 2 ));
			space;
			nextPutAll: Time now print24;
			nextPut: $:;
			space;
			nextPutAll: aBlock value asString;
			cr]
]
