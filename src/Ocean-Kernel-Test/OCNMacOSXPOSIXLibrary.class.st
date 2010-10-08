Class {
	#name : #OCNMacOSXPOSIXLibrary,
	#superclass : #OCNPOSIXLibrary,
	#category : #'Ocean-Libraries'
}

{ #category : #accessing }
OCNMacOSXPOSIXLibrary >> libraryName [
	^'/System/Library/Frameworks/System.framework/System'
]
