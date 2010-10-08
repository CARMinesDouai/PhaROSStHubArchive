Class {
	#name : #OCNDebugSysSocketLibraryTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'setUp-tearDown' }
OCNDebugSysSocketLibraryTest >> setUp [
	super setUp.
	OCNMacOSXPOSIXDebugLibrary deleteAllGeneratedFiles
]

{ #category : #'setUp-tearDown' }
OCNDebugSysSocketLibraryTest >> tearDown [
	super tearDown.
	OCNMacOSXPOSIXDebugLibrary rebuildDebugSysSocketLibraryDylibFile
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testCCodeGeneration [
	OCNMacOSXPOSIXDebugLibrary generateDebugSysSocketLibraryCFile.
	FileDirectory default entryAt: OCNMacOSXPOSIXDebugLibrary debugSysSocketLibraryCFileName ifAbsent: [self fail]
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileBuild [
	OCNMacOSXPOSIXDebugLibrary generateDebugSysSocketLibraryCFile.
	OCNMacOSXPOSIXDebugLibrary buildDebugSysSocketLibraryDylibFile.
	FileDirectory default entryAt: OCNMacOSXPOSIXDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail]
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileRebuildAfterBuild [
	| firstDynlibDirEntry firstDynlibModifTime secondDynlibDirEntry secondDynlibModifTime |
	OCNMacOSXPOSIXDebugLibrary rebuildDebugSysSocketLibraryDylibFile.
	firstDynlibDirEntry := FileDirectory default entryAt: OCNMacOSXPOSIXDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail].
	firstDynlibModifTime := firstDynlibDirEntry modificationTime.
	(Delay forMilliseconds: 1000) wait.
	OCNMacOSXPOSIXDebugLibrary rebuildDebugSysSocketLibraryDylibFile.
	secondDynlibDirEntry := FileDirectory default entryAt: OCNMacOSXPOSIXDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail].
	secondDynlibModifTime := secondDynlibDirEntry modificationTime.
	self assert: secondDynlibModifTime > firstDynlibModifTime
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileRebuildFromScratch [
	OCNMacOSXPOSIXDebugLibrary rebuildDebugSysSocketLibraryDylibFile.
	FileDirectory default entryAt: OCNMacOSXPOSIXDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail]
]
