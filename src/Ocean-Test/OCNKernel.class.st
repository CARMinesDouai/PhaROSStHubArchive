Class {
	#name : #OCNKernel,
	#superclass : #Object,
	#classInstVars : [
		'debug'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNKernel class >> debug [
	^ debug ifNil: [ debug := false ]
]

{ #category : #accessing }
OCNKernel class >> debug: anObject [
	debug := anObject
]

{ #category : #GUI }
OCNKernel class >> displayReadMe [
	^self displayWorkspace: 'OCEAN ReadMe' withContents: self readMe highlight: false
		

]

{ #category : #GUI }
OCNKernel class >> displaySnippets [
	^self displayWorkspace: 'OCEAN Snippets' withContents: self usefulSnippets highlight: true
		

]

{ #category : #GUI }
OCNKernel class >> displayWorkspace: title withContents: aString highlight: highlightOn [
	| window |
	SHWorkspace stylingActive: highlightOn.
	window := SHWorkspace new 
		acceptContents: aString; 
		openLabel: title ;
		yourself.
	
	
]

{ #category : #initialization }
OCNKernel class >> initialize [
	super initialize.
	self displayReadMe.
	self displaySnippets 
]

{ #category : #documentation }
OCNKernel class >> readMe [
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
OCNKernel class >> socketLibrary [ 
	^ self socketLibraryClass uniqueInstance 
]

{ #category : #constants }
OCNKernel class >> socketLibraryClass [
	^ debug ifTrue: [ OCNDebugSysSocketLibrary ]
		ifFalse: [OCNSysSocketLibrary ]

]

{ #category : #accessing }
OCNKernel class >> toggleDebug [
	OCNKernel debug: (OCNKernel debug not)
]

{ #category : #documentation }
OCNKernel class >> usefulSnippets [
	^'
OCNDebugSysSocketLibrary forgetUniqueInstance.
OCNSysSocketLibrary forgetUniqueInstance.

OCNKernel debug.
OCNKernel toggleDebug.
'
]
