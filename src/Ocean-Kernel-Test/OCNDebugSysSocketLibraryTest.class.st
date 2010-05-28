Class {
	#name : #OCNDebugSysSocketLibraryTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
OCNDebugSysSocketLibraryTest >> setUp [
	super setUp.
	OCNDebugSysSocketLibrary deleteAllGeneratedFiles
]

{ #category : #'setUp-tearDown' }
OCNDebugSysSocketLibraryTest >> tearDown [
	super tearDown.
	OCNDebugSysSocketLibrary rebuildDebugSysSocketLibraryDylibFile
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testCCodeGeneration [
	OCNDebugSysSocketLibrary generateDebugSysSocketLibraryCFile.
	FileDirectory default entryAt: OCNDebugSysSocketLibrary debugSysSocketLibraryCFileName ifAbsent: [self fail]
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileBuild [
	OCNDebugSysSocketLibrary generateDebugSysSocketLibraryCFile.
	OCNDebugSysSocketLibrary buildDebugSysSocketLibraryDylibFile.
	FileDirectory default entryAt: OCNDebugSysSocketLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail]
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileRebuildAfterBuild [
	| firstDynlibDirEntry firstDynlibModifTime secondDynlibDirEntry secondDynlibModifTime |
	OCNDebugSysSocketLibrary rebuildDebugSysSocketLibraryDylibFile.
	firstDynlibDirEntry := FileDirectory default entryAt: OCNDebugSysSocketLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail].
	firstDynlibModifTime := firstDynlibDirEntry modificationTime.
	OCNDebugSysSocketLibrary rebuildDebugSysSocketLibraryDylibFile.
	secondDynlibDirEntry := FileDirectory default entryAt: OCNDebugSysSocketLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail].
	secondDynlibModifTime := secondDynlibDirEntry modificationTime.
	self assert: secondDynlibModifTime > firstDynlibModifTime
]

{ #category : #testing }
OCNDebugSysSocketLibraryTest >> testDynlibFileRebuildFromScratch [
	OCNDebugSysSocketLibrary rebuildDebugSysSocketLibraryDylibFile.
	FileDirectory default entryAt: OCNDebugSysSocketLibrary debugSysSocketLibraryDylibFileName ifAbsent: [self fail]
]
