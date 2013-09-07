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
	^ ((aClass inheritsFrom: PhaROSPackage ) and: [ aSelector beginsWith: 'script' ] )
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

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> catkinCreateCommandFor: aPackage [
	^ 'cd {1}; catkin_create_pkg {2} {3} -D "{4}" -a "{5}" -m "{5}" -V "{6}"' format: { aPackage location . aPackage packageName . aPackage rosDependenciesString . aPackage description . aPackage author . aPackage version  }
]

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> create: aPackage [
	^ self 	create: aPackage  
			linkingVM: Smalltalk vm vmFileName 
			copyingImage:  Smalltalk imageName asFileReference parent pathString
	 
]

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> create: aPackage linkinVM: aVMBinaryPath [
	^ self 	create: aPackage  
			linkingVM: aVMBinaryPath 
			copyingImage:  Smalltalk imageName asFileReference parent pathString
	 
]

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> create: aPackage linkingVM: aVMBinaryPath copyingImage: anImageFolderPath [  

	 (FileSystem disk exists: aPackage path)  ifFalse: [	
		OSProcess command: (self catkinCreateCommandFor: aPackage) .
		
		(Delay forMilliseconds: 2000 ) wait.

		 { aPackage vmFolder . aPackage imageFolder . aPackage msg . aPackage build . aPackage bin . aPackage scripts } do: [ :path | FileSystem disk createDirectory: path.].  
	

		OSProcess command: ('ln -s {1} {2}' format: { aVMBinaryPath . aPackage vm }).
		OSProcess command: ('cp -r  {1} {2}' format: { anImageFolderPath ,'/*' . aPackage imageFolder } ).

		(StandardFileStream forceNewFileNamed: aPackage mainBinary) nextPutAll: '#!/bin/bash',String lf, aPackage vm, ' ', aPackage image, ' scripts/$1', String lf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainHeadless) nextPutAll: '#!/bin/bash',String lf,aPackage vm, ' -headless ', aPackage image, ' scripts/$1', String lf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainEdit) nextPutAll: '#!/bin/bash',String lf,aPackage vm, ' ', aPackage image,  String lf ; close.

		OSProcess command: ('chmod 777 {1}' format: { aPackage mainBinary }).
		OSProcess command: ('cd {1}; cd .. ; catkin_make' format: { aPackage location }).
	]
]

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> install: aPackage [
	^ self 	install: aPackage  
			linkingVM: Smalltalk vm vmFileName 
			copyingImage:  Smalltalk imageName asFileReference parent pathString
	 
]

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> install: aPackage linkinVM: aVMBinaryPath [
	^ self 	install: aPackage  
			linkingVM: aVMBinaryPath 
			copyingImage:  Smalltalk imageName asFileReference parent pathString
	 
]

{ #category : #'as yet unclassified' }
PhaROSPackageManager >> install: aPackage linkingVM: aVMBinaryPath copyingImage: anImageFolderPath [  

	 (FileSystem disk exists: aPackage path)  ifFalse: [	
		
		FileSystem disk createDirectory: aPackage path.

		 { aPackage vmFolder . aPackage imageFolder . aPackage msg . aPackage build . aPackage bin . aPackage scripts } do: [ :path | FileSystem disk createDirectory: path.].  
	

		OSProcess command: ('ln -s {1} {2}' format: { aVMBinaryPath . aPackage vm }).
		OSProcess command: ('cp -r  {1} {2}' format: { anImageFolderPath ,'/*' . aPackage imageFolder } ).
		
		(StandardFileStream forceNewFileNamed: aPackage cMakeList ) nextPutAll: aPackage cmake ; close.
		(StandardFileStream forceNewFileNamed: aPackage packageXML ) nextPutAll: aPackage xml ; close.
		
		(StandardFileStream forceNewFileNamed: aPackage mainBinary) nextPutAll: '#!/bin/bash',String crlf, aPackage vm, ' ', aPackage image, ' scripts/$1', String crlf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainHeadless) nextPutAll: '#!/bin/bash',String crlf,aPackage vm, ' -headless ', aPackage image, ' scripts/$1', String crlf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainEdit) nextPutAll: '#!/bin/bash',String crlf,aPackage vm, ' ', aPackage image,  String crlf ; close.

		OSProcess command: ('chmod 777 {1}' format: { aPackage mainBinary }).

		aPackage installScripts.
	
		OSProcess command: ('cd {1}; cd .. ; catkin_make' format: { aPackage location }).
	]
]
