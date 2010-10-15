Class {
	#name : #OCNMacOSXPosixLibrary,
	#superclass : #OCNPosixLibrary,
	#category : #'Ocean-Libraries'
}

{ #category : #accessing }
OCNMacOSXPosixLibrary >> libraryName [
	^'/System/Library/Frameworks/System.framework/System'
]
