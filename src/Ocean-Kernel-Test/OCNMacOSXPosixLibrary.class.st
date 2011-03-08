Class {
	#name : #OCNMacOSXPosixLibrary,
	#superclass : #OCNPosixLibrary,
	#category : #'Ocean-Libraries-Posix'
}

{ #category : #accessing }
OCNMacOSXPosixLibrary >> libraryName [
	^'libSystem.dylib'
]
