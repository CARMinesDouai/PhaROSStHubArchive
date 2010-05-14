Class {
	#name : #DebugSysSocketLibrary,
	#superclass : #SysSocketLibrary,
	#category : #'Ocean-Kernel'
}

{ #category : #'socket functions' }
DebugSysSocketLibrary >> connectFunctionName [
	^'connect_for_debug'
]

{ #category : #accessing }
DebugSysSocketLibrary >> libraryName [
	^'/usr/lib/client_for_alien.dylib'
]
