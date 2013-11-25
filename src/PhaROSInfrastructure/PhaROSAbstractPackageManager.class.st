Class {
	#name : #PhaROSAbstractPackageManager,
	#superclass : #Object,
	#classInstVars : [
		'installedPackages'
	],
	#category : #'PhaROSInfrastructure-CatkinPackage'
}

{ #category : #sync }
PhaROSAbstractPackageManager class >> catkinPackageFor: aClass [
	^ self installedPackages detect: [ : p | p pharosPackage = aClass] ifNone: [ nil ] 
]

{ #category : #'as yet unclassified' }
PhaROSAbstractPackageManager class >> installedPackages [
	^ installedPackages ifNil: [ installedPackages := Set new  ].
]

{ #category : #sync }
PhaROSAbstractPackageManager class >> isInstalled: aClass [
	^ (self catkinPackageFor: aClass) notNil.
]

{ #category : #sync }
PhaROSAbstractPackageManager class >> itsAPackage: aClass andItsAScript: aSelector [
	^ ((aClass inheritsFrom: PhaROSPackage ) and: [ (self isInstalled: aClass) and: [ aSelector beginsWith: 'script'] ]  )
]

{ #category : #'as yet unclassified' }
PhaROSAbstractPackageManager class >> register: aPackage [
	self installedPackages add: aPackage.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractPackageManager class >> registeredCatckinPackagesFor: aPhaROSPackage [
	^ self installedPackages select:[ : catkn | catkn pharosPackage = aPhaROSPackage ] 
]

{ #category : #sync }
PhaROSAbstractPackageManager class >> removeScript: aSelector of: aClass [
	(self isInstalled: aClass) ifTrue: [ 
			FileSystem disk delete: ((self catkinPackageFor: aClass) scripts, '/',( aSelector asString copyFrom: 'script' size) asLowercase).
		
	 ].


]

{ #category : #sync }
PhaROSAbstractPackageManager class >> scriptSyncronizer: aClass selector: aSelector [
	(self itsAPackage: aClass andItsAScript: aSelector ) ifTrue: [
		(PhaROSPackageManager registeredCatckinPackagesFor: aClass)  do: [ :p | p installScript: aSelector.]	
	]
]

{ #category : #private }
PhaROSAbstractPackageManager >> catkinCreateCommandFor: aPackage [
	^ 'cd {1}; catkin_create_pkg {2} {3} -D "{4}" -a "{5}" -m "{5}" -V "{6}"' format: { aPackage location . aPackage packageName . aPackage rosDependenciesString . aPackage description . aPackage author . aPackage version  }
]

{ #category : #create }
PhaROSAbstractPackageManager >> create: aPackage [
	 | baseImage changes sources |
	
	baseImage := (CommandLineUIManager default chooseFullFileNameMatching: { '*.image'} label: 'Choose the base image for installing / deploying the package') asFileReference.
	changes := baseImage parent / baseImage base,'changes'.
	sources := baseImage parent / 'PharoV10.sources'.
	
	 self 	create: aPackage  
			linkingVM: Smalltalk vm vmFileName 
			copyingImage: baseImage  pathString
			changes: changes  pathString
			andSource: sources pathString.
			
	
]

{ #category : #create }
PhaROSAbstractPackageManager >> create: aPackage linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFilePath [

	 (FileSystem disk exists: aPackage path)  ifFalse: [	
		OSProcess command: (self catkinCreateCommandFor: aPackage) .
		(Delay forMilliseconds: 2000 ) wait.

		self makeUpFolder: aPackage  linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFilePath .
		
		 self class register: aPackage.
		 aPackage deploy.
	].
  
]

{ #category : #create }
PhaROSAbstractPackageManager >> extension [	
	^ ''.
]

{ #category : #private }
PhaROSAbstractPackageManager >> inflatePackage: aPackage [  
	| make | 
	
		
		(StandardFileStream forceNewFileNamed: aPackage mainBinary) nextPutAll: '#!/bin/bash',String lf, aPackage vm, ' ', aPackage image, ' st scripts/$1.st', String lf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainHeadless) nextPutAll: '#!/bin/bash',String lf,aPackage vm, ' -vm-display-X11 -headless ', aPackage image, ' st scripts/$1.st', String lf ; close.
		(StandardFileStream forceNewFileNamed: aPackage mainEdit) nextPutAll: '#!/bin/bash',String lf,aPackage vm, ' ', aPackage image,  String lf ; close.
		
		OSProcess command: ('chmod 777 {1}' format: { aPackage bin, '/*' }).
		
		aPackage pharosPackage dependencies do: [ : dep | dep installOn: aPackage ].
		
		make := OSProcess command: ('cd {1}; cd .. ; catkin_make' format: { aPackage location }).
		self class register: aPackage.
		self installScripts: aPackage.
		
		[ make isComplete  ] whileFalse: [ 1 hz wait ].
		
]

{ #category : #install }
PhaROSAbstractPackageManager >> install: aPackage [
| baseImage changes sources |

	baseImage := (CommandLineUIManager default chooseFullFileNameMatching: { '*.image'} label: 'Choose the base image for installing / deploying the package') asFileReference.
	changes := baseImage parent / baseImage base,'changes'.
	sources := baseImage parent / 'PharoV10.sources'.


	 self install: aPackage  
			linkingVM: Smalltalk vm vmFileName 
			copyingImage: baseImage  pathString
			changes: changes  pathString
			andSource: sources pathString.
	
	
]

{ #category : #install }
PhaROSAbstractPackageManager >> install: aPackage linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFile [
	
	 (FileSystem disk exists: aPackage path)  ifFalse: [	
		
		FileSystem disk createDirectory: aPackage path.
		(StandardFileStream forceNewFileNamed: aPackage cMakeList ) nextPutAll: aPackage cmake withUnixLineEndings  ; close.
		(StandardFileStream forceNewFileNamed: aPackage packageXML ) nextPutAll: aPackage xml withUnixLineEndings ; close.
		
		self makeUpFolder: aPackage linkingVM: aVMBinaryPath copyingImage: anImagePath  changes: aChangesFilePath andSource: aSourceFile . 

		
		self class register: aPackage.
		aPackage deploy.

	]
]

{ #category : #create }
PhaROSAbstractPackageManager >> installScript: aScriptSelector of: aPackage [
	| script  |
		
		
		script := StandardFileStream forceNewFileNamed: (aPackage scripts, '/',( aScriptSelector asString copyReplaceAll: 'script' with:''  ) asLowercase, self extension ).
		script  nextPutAll:  ('Author fullName: ''PhaROS''. {1} new {2}.  ' format: { aPackage pharosPackage name  . aScriptSelector asString }), String crlf.
		script close. 
	
]

{ #category : #create }
PhaROSAbstractPackageManager >> installScripts: aPackage [
	aPackage scriptMethods do: [ : scriptMethod | self installScript: scriptMethod selector of: aPackage. ] 
]

{ #category : #private }
PhaROSAbstractPackageManager >> make: aPackage [
	OSProcess command: ('cd {1}; cd .. ; catkin_make' format: { aPackage location }).
]

{ #category : #private }
PhaROSAbstractPackageManager >> makeUpFolder: aPackage  linkingVM: aVMBinaryPath copyingImage: anImagePath   changes: aChangesFilePath andSource: aSourceFile [
	| copy |


		 { aPackage vmFolder . aPackage imageFolder . aPackage msg . aPackage build . aPackage bin . aPackage scripts . aPackage path, '/include' } 
		do: [ :path | [FileSystem disk createDirectory: path.] on: Error do: [ ]] .  
	

		OSProcess command: ('ln -s {1} {2}' format: { aVMBinaryPath . aPackage vm }).
		OSProcess command: ('cp  {1} {2}' format: { aChangesFilePath  . aPackage changes } ).
		OSProcess command: ('cp  {1} {2}' format: { aSourceFile  . aPackage imageFolder } ).
		copy := OSProcess command: ('cp  {1} {2}' format: { anImagePath  . aPackage image } ).


		[ copy isComplete  ] whileFalse: [ 1 hz wait ].
	
		


]
