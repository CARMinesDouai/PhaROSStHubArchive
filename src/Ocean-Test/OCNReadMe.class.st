Class {
	#name : #OCNReadMe,
	#superclass : #Object,
	#category : #'Ocean-Kernel'
}

{ #category : #'as yet unclassified' }
OCNReadMe class >> displayReadMe [
	SHWorkspace new 
		acceptContents: self readMe ;
		openLabel: 'OCEAN readMe' ;
		toggleStylingActive 
	

]

{ #category : #'as yet unclassified' }
OCNReadMe class >> initialize [
	super initialize.
	self displayReadMe
]

{ #category : #'as yet unclassified' }
OCNReadMe class >> readMe [
	^'
Object-oriented Cross-platform and Efficient Api for Network

TODO:
	- Uniformize tests to use the same local server
		not apache one time and an echo server another time
	- Extract hard refs to SysSocketLibrary to be easily changed by DebugSysSocketLibrary 
	- find a way to commit C code ?
	- Do portable tests :
		-- do not rely on an external server (launch an echo server from Smalltalk)
		-- do not use absolute PATH in C code for ocean.log

On the Web:
 	- http://www.retran.com/beej/syscalls.html#connect'
]
