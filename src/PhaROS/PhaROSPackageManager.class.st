"
PhaROSPackageManager is an object that allows to install a package into a ros system, its based on catkin package constructor. 
"
Class {
	#name : #PhaROSPackageManager,
	#superclass : #Object,
	#category : #'PhaROS-PackageManager'
}

{ #category : #'as yet unclassified' }
PhaROSPackageManager class >> initialize [
	SystemAnnouncer announcer weak
		on: MethodModified send: #methodModified: to: self;
		on: MethodRemoved send: #methodRemoved: to: self;
		on: MethodAdded send: #methodAdded: to: self.
		
]

{ #category : #sync }
PhaROSPackageManager class >> itsAPackage: aClass andItsAScript: aSelector [
	^ ((aClass inheritsFrom: PhaROSPackage ) and: [ aClass isInstalled and: [ aSelector beginsWith: 'script'] ]  )
]

{ #category : #events }
PhaROSPackageManager class >> methodAdded: anEvent [
	self scriptSyncronizer: 	anEvent item classBinding value selector: anEvent item selector.
]

{ #category : #events }
PhaROSPackageManager class >> methodModified: anEvent [
	self scriptSyncronizer: anEvent item classBinding value selector: anEvent item selector.
]

{ #category : #events }
PhaROSPackageManager class >> methodRemoved: anEvent [
	(self itsAPackage: anEvent item classBinding value andItsAScript: anEvent item selector) ifTrue: [
		anEvent item classBinding value removeScript:  anEvent item selector
	]
]

{ #category : #sync }
PhaROSPackageManager class >> scriptSyncronizer: aClass selector: aSelector [
	(self itsAPackage: aClass andItsAScript: aSelector ) ifTrue: [
		aClass  installScript: aSelector.	
	]
]

{ #category : #private }
PhaROSPackageManager >> catkinCreateCommandFor: aPackage [
	^ 'cd {1}; catkin_create_pkg {2} {3} -D "{4}" -a "{5}" -m "{5}" -V "{6}"' format: { aPackage location . aPackage packageName . aPackage rosDependenciesString . aPackage description . aPackage author . aPackage version  }
]

{ #category : #create }
PhaROSPackageManager >> create: aPackage [
	^ self 	create: aPackage  
			linkingVM: Smalltalk vm vmFileName 
			copyingImage:  Smalltalk imageName asFileReference pathString
			changes: Smalltalk changesName asFileReference pathString
			andSource: Smalltalk sourcesName asFileReference pathString
	
]

{ #category : #create }
PhaROSPackageManager >> create: aPackage linkinVM: aVMBinaryPath [
	^ self 	create: aPackage  
			linkingVM: aVMBinaryPath 
			copyingImage:  Smalltalk imageName asFileReference pathString
			changes: Smalltalk changesName asFileReference pathString
			andSource: Smalltalk sourcesName asFileReference pathString
	 
]

{ #category : #create }
PhaROSPackageManager >> create: aPackage linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFilePath [

	 (FileSystem disk exists: aPackage path)  ifFalse: [	
		OSProcess command: (self catkinCreateCommandFor: aPackage) .
		(Delay forMilliseconds: 2000 ) wait.

		self inflatePackage: aPackage  linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFilePath .

	]
]

{ #category : #private }
PhaROSPackageManager >> inflatePackage: aPackage  linkingVM: aVMBinaryPath copyingImage: anImagePath   changes: aChangesFilePath andSource: aSourceFile [

		 { aPackage vmFolder . aPackage imageFolder . aPackage msg . aPackage build . aPackage bin . aPackage scripts . aPackage path, '/include' } 
		do: [ :path | FileSystem disk createDirectory: path.].  
	

		OSProcess command: ('ln -s {1} {2}' format: { aVMBinaryPath . aPackage vm }).
		OSProcess command: ('cp  {1} {2}' format: { anImagePath  . aPackage image } ).
		OSProcess command: ('cp  {1} {2}' format: { aChangesFilePath  . aPackage changes } ).
		OSProcess command: ('cp  {1} {2}' format: { aSourceFile  . aPackage imageFolder } ).

		(StandardFileStream forceNewFileNamed: aPackage mainBinary) nextPutAll: '#!/bin/bash',String lf, aPackage vm, ' ', aPackage image, ' scripts/$1', String lf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainHeadless) nextPutAll: '#!/bin/bash',String lf,aPackage vm, ' --nodisplay ', aPackage image, ' scripts/$1', String lf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainEdit) nextPutAll: '#!/bin/bash',String lf,aPackage vm, ' ', aPackage image,  String lf ; close.

		OSProcess command: ('chmod 777 {1}' format: { aPackage bin, '/*' }).
		OSProcess command: ('cd {1}; cd .. ; catkin_make' format: { aPackage location }).
]

{ #category : #install }
PhaROSPackageManager >> install: aPackage [
	^ self 	install: aPackage  
			linkingVM: Smalltalk vm vmFileName 
			copyingImage:  Smalltalk imageName asFileReference pathString
			changes: Smalltalk changesName asFileReference pathString
			andSource: Smalltalk sourcesName asFileReference pathString
	 
]

{ #category : #install }
PhaROSPackageManager >> install: aPackage linkinVM: aVMBinaryPath [
	^ self 	install: aPackage  
			linkingVM: aVMBinaryPath 
			copyingImage:  Smalltalk imageName asFileReference pathString
			changes: Smalltalk changesName asFileReference pathString
			andSource: Smalltalk sourcesName asFileReference pathString
	 
]

{ #category : #install }
PhaROSPackageManager >> install: aPackage linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFile [

	 (FileSystem disk exists: aPackage path)  ifFalse: [	
		
		FileSystem disk createDirectory: aPackage path.
		(StandardFileStream forceNewFileNamed: aPackage cMakeList ) nextPutAll: aPackage cmake withUnixLineEndings  ; close.
		(StandardFileStream forceNewFileNamed: aPackage packageXML ) nextPutAll: aPackage xml withUnixLineEndings ; close.
		
		self inflatePackage: aPackage linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFile . 

		aPackage installScripts.
	

	]
]

{ #category : #private }
PhaROSPackageManager >> make: aPackage [
	OSProcess command: ('cd {1}; cd .. ; catkin_make' format: { aPackage location }).
]
