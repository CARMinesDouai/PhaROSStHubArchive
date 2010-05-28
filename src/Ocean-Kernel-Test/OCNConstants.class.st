Class {
	#name : #OCNConstants,
	#superclass : #Object,
	#classInstVars : [
		'debug'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNConstants class >> debug [
	^ debug ifNil: [ debug := false ]
]

{ #category : #accessing }
OCNConstants class >> debug: anObject [
	debug := anObject
]

{ #category : #GUI }
OCNConstants class >> displayReadMe [
	^self displayWorkspace: 'OCEAN ReadMe' withContents: self readMe highlight: false
		

]

{ #category : #GUI }
OCNConstants class >> displaySnippets [
	^self displayWorkspace: 'OCEAN Snippets' withContents: self usefulSnippets highlight: true
		

]

{ #category : #GUI }
OCNConstants class >> displayWorkspace: title withContents: aString highlight: highlightOn [
	| window |
	SHWorkspace stylingActive: highlightOn.
	window := SHWorkspace new 
		acceptContents: aString; 
		openLabel: title ;
		yourself.
	
	
]

{ #category : #initialization }
OCNConstants class >> initialize [
	super initialize.
	self displayReadMe.
	self displaySnippets 
]

{ #category : #documentation }
OCNConstants class >> readMe [
	^'
Object-oriented Cross-platform and Efficient Api for Network

TODO:
	- find a way to commit C code ? (actually OCNDebugSysSocketLibrary class>>debugSysSocketLibraryC)
	- Do portable tests :
		-- do not rely on an external server (launch an echo server from Smalltalk)
		-- do not use absolute PATH in C code for ocean.log ?

Some possible useful links:
 	- http://www.retran.com/beej/syscalls.html#connect'
]

{ #category : #constants }
OCNConstants class >> socketLibrary [ 
	^ self socketLibraryClass uniqueInstance 
]

{ #category : #constants }
OCNConstants class >> socketLibraryClass [
	^ self debug ifTrue: [ OCNDebugSysSocketLibrary ]
		ifFalse: [OCNSysSocketLibrary ]

]

{ #category : #accessing }
OCNConstants class >> toggleDebug [
	OCNConstants debug: (OCNConstants debug not)
]

{ #category : #documentation }
OCNConstants class >> usefulSnippets [
	^'
OCNDebugSysSocketLibrary forgetUniqueInstance.
OCNSysSocketLibrary forgetUniqueInstance.

OCNConstants debug.
OCNConstants toggleDebug.
'
]
