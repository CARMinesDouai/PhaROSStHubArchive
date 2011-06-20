Class {
	#name : #OCNMacOSXPosixLibrary,
	#superclass : #OCNPosixLibrary,
	#category : #'Ocean-LibraryPosix'
}

{ #category : #accessing }
OCNMacOSXPosixLibrary >> libraryName [
	^'/System/Library/Frameworks/System.framework/System'
]
