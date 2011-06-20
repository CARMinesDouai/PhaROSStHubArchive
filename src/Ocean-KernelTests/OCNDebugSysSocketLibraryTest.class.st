"
""ignore these tests""

isAbstract 
"
Class {
	#name : #OCNDebugSysSocketLibraryTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #'as yet unclassified' }
OCNDebugSysSocketLibraryTest class >> isAbstract [ 
"ignore these tests"	
	^true
]

{ #category : #'setUp-tearDown' }
OCNDebugSysSocketLibraryTest >> setUp [
	super setUp.
	OCNMacOSXPosixDebugLibrary deleteAllGeneratedFiles
]

{ #category : #'setUp-tearDown' }
OCNDebugSysSocketLibraryTest >> tearDown [
	super tearDown.
	OCNMacOSXPosixDebugLibrary rebuildDebugSysSocketLibraryDylibFile
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testCCodeGeneration [
	OCNMacOSXPosixDebugLibrary generateDebugSysSocketLibraryCFile.
	FileDirectory default entryAt: OCNMacOSXPosixDebugLibrary debugSysSocketLibraryCFileName ifAbsent: [self fail]
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileBuild [
	OCNMacOSXPosixDebugLibrary generateDebugSysSocketLibraryCFile.
	OCNMacOSXPosixDebugLibrary buildDebugSysSocketLibraryDylibFile.
	FileDirectory default entryAt: OCNMacOSXPosixDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail]
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileRebuildAfterBuild [
	| firstDynlibDirEntry firstDynlibModifTime secondDynlibDirEntry secondDynlibModifTime |
	OCNMacOSXPosixDebugLibrary rebuildDebugSysSocketLibraryDylibFile.
	firstDynlibDirEntry := FileDirectory default entryAt: OCNMacOSXPosixDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail].
	firstDynlibModifTime := firstDynlibDirEntry modificationTime.
	(Delay forMilliseconds: 1000) wait.
	OCNMacOSXPosixDebugLibrary rebuildDebugSysSocketLibraryDylibFile.
	secondDynlibDirEntry := FileDirectory default entryAt: OCNMacOSXPosixDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail].
	secondDynlibModifTime := secondDynlibDirEntry modificationTime.
	self assert: secondDynlibModifTime > firstDynlibModifTime
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileRebuildFromScratch [
	OCNMacOSXPosixDebugLibrary rebuildDebugSysSocketLibraryDylibFile.
	FileDirectory default entryAt: OCNMacOSXPosixDebugLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail]
]
