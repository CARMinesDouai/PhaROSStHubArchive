"
PhaROSCatkinDeployer is used to manage the generation of files of a PhaROSPackage in its corresponding catkin package.

It is responsible to generate: 
- CMakeFileLists.txt
- package.xml

To recompile the catkin workspace using catkin_make

To automatically generate scripts files for script methods added in the PhaROSPackage class.

A singleton instance of this class is created and configured by the PhaROSCommander when the PhaROS image is set up. The commander execute the following code:

PhaROSCatkinDeployer setupImageForCurrentCatkinPackage

"
Class {
	#name : #PhaROSCatkinDeployer,
	#superclass : #Object,
	#instVars : [
		'deployedTypes',
		'dependencies',
		'deployedServices',
		'phaROSPackageClass'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-Catkin'
}

{ #category : #private }
PhaROSCatkinDeployer class >> assertThisPhaROSImageIsStoredInACatkinWorkspace [

	"Ensure that we are inside the known directory layout of a catkin package. The image must be stored inside the image folder.
		
		catkin-ws/
			src/
				package-name/
					image/
						scripts/ 		
	"
	|errorText currentDirectory|
	
	errorText := '{1} can only be instantiated if the Pharo image is correctly stored in a catkin package directory because the scripts and types generation relies on the directories structure.' format: { self class name }.
	
	currentDirectory := Smalltalk imageDirectory asFileReference.
	
	"all assertions below must be statisfied"
	self assert: (({  
			currentDirectory basename = 'image'.
			currentDirectory parent parent basename = 'src'
			} asSet includes: false) not)   
		description: errorText.
		
]

{ #category : #'generating - PhaROSPackage' }
PhaROSCatkinDeployer class >> editScriptForPhaROSPackageNamed: packageName [

^('#!/usr/bin/env bash
DIR=`rospack find {1}`
	
$DIR/vm/pharo $DIR/image/{1}.image
' format: { packageName }) withUnixLineEndings
]

{ #category : #'generating - PhaROSPackage' }
PhaROSCatkinDeployer class >> generateBinScripts [
	|catkinPackageDirectory package editScript headlessScript pharosScript |
	
	catkinPackageDirectory := Smalltalk imageDirectory parent.
	package := catkinPackageDirectory basename.
	
	editScript := catkinPackageDirectory / 'bin' / 'edit'.
	editScript writeStreamDo:
		[:stream | stream << (self editScriptForPhaROSPackageNamed: package) ].
	
	headlessScript := catkinPackageDirectory / 'bin' / 'headless'.
	headlessScript writeStreamDo:
		[:stream | stream << (self headlessScriptForPhaROSPackageNamed: package) ].

	pharosScript := catkinPackageDirectory / 'bin' / 'pharos'.
	pharosScript writeStreamDo:
		[:stream | stream << (self pharosScriptForPhaROSPackageNamed: package) ].

	OSProcess command: ('chmod 755 {1}/*' format: { (catkinPackageDirectory / 'bin') pathString }).
	
]

{ #category : #'generating - PhaROSPackage' }
PhaROSCatkinDeployer class >> generateDirectoryStructure [
	|catkinPackageDirectory|
	
	catkinPackageDirectory := Smalltalk imageDirectory parent.
	
	{ 'bin' . 'image/scripts'  . 'build' . 'include' . 'msg' . 'srv' } do: [  :dirName |
		(catkinPackageDirectory / dirName) ensureCreateDirectory ].	
	

]

{ #category : #'generating - PhaROSPackage' }
PhaROSCatkinDeployer class >> generatePhaROSPackageClassForCatkinName: catkinPackageName [

	| newPhaROSPackageClassName codeExample |
	
	newPhaROSPackageClassName := catkinPackageName capitalized, 'Package'.
	
	PhaROSPackage 
			subclass: newPhaROSPackageClassName asSymbol 
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: newPhaROSPackageClassName.
	
	"add a script method as an example"
	codeExample := 'scriptExample
		"please load the package PhaROS-PackageExample from PhaROS repository "'.
	
	Smalltalk globals at: #PhaROSExamplePackage ifPresent: [ :exampleClass | 
		codeExample := (exampleClass>>#scriptTopicSubscribingExample) sourceCode ].
	
	newPhaROSPackageClassName asClass
		compile: codeExample
 		classified: 'scripts'. 

	^ newPhaROSPackageClassName asClass

]

{ #category : #'generating - PhaROSPackage' }
PhaROSCatkinDeployer class >> headlessScriptForPhaROSPackageNamed: packageName [

^('#!/usr/bin/env bash
DIR=`rospack find {1}`
	
$DIR/vm/pharo --nodisplay  $DIR/image/{1}.image st $DIR/image/scripts/$1.st
' format: { packageName }) withUnixLineEndings
]

{ #category : #accessing }
PhaROSCatkinDeployer class >> instance [
	^ instance
	
]

{ #category : #'instance creation' }
PhaROSCatkinDeployer class >> new [ 
	"use the singleton #instance or create a new one using #setupImageForCurrentCatkinPackage"
	self shouldNotImplement 
]

{ #category : #'generating - PhaROSPackage' }
PhaROSCatkinDeployer class >> pharosScriptForPhaROSPackageNamed: packageName [

^('#!/usr/bin/env bash
DIR=`rospack find {1}`
	
$DIR/vm/pharo $DIR/image/{1}.image st $DIR/image/scripts/$1.st
' format: { packageName }) withUnixLineEndings
]

{ #category : #'API for PhaROSCommander' }
PhaROSCatkinDeployer class >> setupImageForCurrentCatkinPackage [

	| phaROSPackageClass catkinPackageImageDirectory catkinPackageDirectory catkinPackageName |
	
	self assertThisPhaROSImageIsStoredInACatkinWorkspace.
	
	catkinPackageImageDirectory := Smalltalk imageDirectory.
	catkinPackageDirectory := catkinPackageImageDirectory parent.
	catkinPackageName := catkinPackageDirectory basename.
		
	SystemWindow allInstances do: #close.
	
	phaROSPackageClass := self generatePhaROSPackageClassForCatkinName: catkinPackageName.
	
	phaROSPackageClass browse.
	
	self generateDirectoryStructure.
	self generateBinScripts.
	
	instance := self basicNew initialize.
	instance 
		phaROSPackageClass: phaROSPackageClass;
		generateAllCatkinArtefacts.
	
	Smalltalk globals at: #PhaROSDoc ifPresent: [ :doc | doc open  ].
	Smalltalk globals at: #EUWorkspace ifPresent: [ :workspace | workspace open  ].
]

{ #category : #actions }
PhaROSCatkinDeployer class >> uninstall [
	instance := nil.
]

{ #category : #'generating - CMakeListsTxt' }
PhaROSCatkinDeployer >> cMakeListsTxt [
	^ self makeFileFor: self phaROSPackageClass 
]

{ #category : #utils }
PhaROSCatkinDeployer >> catkinMake [
	" catkin_make must be executed in the catkin workspace folder "
	OSProcess command: ('cd {1} && catkin_make' format: { self catkinWorskpaceDirectory pathString }).
]

{ #category : #accessing }
PhaROSCatkinDeployer >> catkinPackageDirectory [
	"assuming that this PhaROS image is correctly stored in 
		catkin-ws / src / <packageName> / image / <packageName>.image
	"
	^ Smalltalk imageDirectory parent 
]

{ #category : #accessing }
PhaROSCatkinDeployer >> catkinWorskpaceDirectory [
	"assuming that this PhaROS image is correctly stored in 
		catkin-ws / src / <packageName> / image / <packageName>.image
	"
	^ Smalltalk imageDirectory parent parent parent
]

{ #category : #'generating - CMakeListsTxt' }
PhaROSCatkinDeployer >> dependenciesForMake [
	^ dependencies 
	
]

{ #category : #'generating - packageXml' }
PhaROSCatkinDeployer >> dependenciesForPackageXml [
	^ dependencies , {'message_runtime'}.
]

{ #category : #'generating - types' }
PhaROSCatkinDeployer >> deployType:  aDefinition [
	
	| path extension |
	
	path := aDefinition isServiceType ifTrue: [ self servicesDirectory ] ifFalse: [ self typesDirectory ].
	extension := aDefinition isServiceType ifTrue: [ 'srv' ] ifFalse: [ 'msg' ].
	
	self newFile: aDefinition shortName ,'.',extension 
			   at: path
			with: aDefinition rosdefinition.
			
	aDefinition isServiceType ifTrue: [ 
		deployedServices add:  aDefinition shortName 
	] ifFalse:[
		deployedTypes add:  aDefinition shortName 
	].
	dependencies addAll: aDefinition dependencies.
	
]

{ #category : #'generating - scripts methods' }
PhaROSCatkinDeployer >> filenameFor: aSelector [
	|filename|
	 
	filename := aSelector copyReplaceAll: 'script' with: '' .
	filename at:1 put: ((filename at:1) asLowercase).
	
	[filename indexOfFirstUppercaseCharacter = 0] whileFalse: [
		| upper |
		upper := (filename at: filename indexOfFirstUppercaseCharacter) asString.
		filename := filename copyReplaceAll: upper with: '_', upper asLowercase .
	].
	^ filename.
]

{ #category : #'generating - scripts methods' }
PhaROSCatkinDeployer >> filenameFor: selector inClass: aPackageClass [

	|filename|
	 
	filename := selector copyReplaceAll: 'script' with: '' .
	filename at:1 put: ((filename at:1) asLowercase).
	
	[filename indexOfFirstUppercaseCharacter = 0] whileFalse: [
		| upper |
		upper := (filename at: filename indexOfFirstUppercaseCharacter) asString.
		filename := filename copyReplaceAll: upper with: '_', upper asLowercase .
	].
	^ (aPackageClass name asString asLowercase, '_' , filename, '.st' )
]

{ #category : #'public api' }
PhaROSCatkinDeployer >> generateAllCatkinArtefacts [
	self 
		installAllTypes ; 
		installAllScripts ; 
		installResident.
]

{ #category : #'initialize-release' }
PhaROSCatkinDeployer >> initialize [
	deployedTypes := OrderedCollection new.
	deployedServices := OrderedCollection new. 
	dependencies := Set new .
	
]

{ #category : #'public api' }
PhaROSCatkinDeployer >> installAllScripts [
	
	self phaROSPackageClass ifNotNil: [			
		self phaROSPackageClass methodDict keys select: [ : selector | (selector beginsWith: 'script') and: (selector indexOf: $: ) = 0 ] thenDo: [
			:selector | 
	self 
		newFile: (self filenameFor: selector inClass: self phaROSPackageClass ) 
		at: self scriptsDirectory with: ('{1} new {2}. ' 
		format: { self phaROSPackageClass name asString. selector asString}).
		]
	]
]

{ #category : #'public api' }
PhaROSCatkinDeployer >> installAllTypes [
	
	| allTypes |
	deployedTypes removeAll.
	deployedServices removeAll.
	dependencies removeAll.
	
	allTypes := #PhaROSPackage asClass allSubclasses flatCollect: [ :pharosPackageClass | pharosPackageClass types ].
	allTypes do: [ : definition | self manageType: definition] .
		
	self newFile: 'package.xml' at: self catkinPackageDirectory with: self packageXml ; 
		 newFile: 'CMakeLists.txt' at: self catkinPackageDirectory with: self cMakeListsTxt.
	
	self catkinMake
]

{ #category : #'public api' }
PhaROSCatkinDeployer >> installResident [
	" Install residents mean that we want to be able to automatize the types generation and scripts installation for the given installation. 
	"
	
	SystemAnnouncer uniqueInstance weak 
		when: MethodModified send: #methodModified: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: MethodAdded send: #methodAdded: to: self.
	
	
	 
	
	
]

{ #category : #'generating - scripts methods' }
PhaROSCatkinDeployer >> installScriptFor: aSelector ofPhaROSPackageClass: aPhaROSPackageClass [

	 ((aSelector beginsWith: 'script') and: [(aSelector indexOf: $:) = 0])  ifFalse: [ ^ self ].

	self 
		newFile: (self filenameFor: aSelector inClass: aPhaROSPackageClass) 
		at: self scriptsDirectory with: ('{1} new {2}. ' 
		format: { aPhaROSPackageClass name asString. aSelector asString}).
	
]

{ #category : #'generating - CMakeListsTxt' }
PhaROSCatkinDeployer >> makeFileFor: aPackage [
^(deployedTypes,deployedServices) isEmpty not ifTrue: [ 	
	' 
cmake_minimum_required({1})
project({2})
find_package(catkin REQUIRED COMPONENTS message_generation message_runtime roscpp rospy )

{3}

add_message_files(
   FILES
   {4}
 )

add_service_files(
   FILES
   {5}
)

generate_messages(
   DEPENDENCIES
  {6}
)
catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS message_runtime
)
		' format: { 
			self makeVersion . 
			aPackage catkinPackageName .
			self dependenciesForMake inject:'' into: [ :acc :type | acc, ' find_package (',type,')', String lf ] .
			deployedTypes inject:'' into: [ :acc :type | acc, type,'.msg', String lf ] .
			deployedServices inject:'' into: [ :acc :type | acc, type,'.srv', String lf ] .
			self dependenciesForMake inject:'' into: [ :acc :type | acc, type, String lf ] .
		 }.	
 ] ifFalse: [ 
'
cmake_minimum_required({1})
project({2})
find_package(catkin REQUIRED)
catkin_package()
' format:{ self makeVersion . aPackage catkinPackageName }.
	

 ]

]

{ #category : #'generating - CMakeListsTxt' }
PhaROSCatkinDeployer >> makeVersion [
	^ 'VERSION 2.8.3'
]

{ #category : #'announcements on methods' }
PhaROSCatkinDeployer >> manageEvent: anEvent [
	((anEvent methodClass inheritsFrom: #PhaROSPackage asClass) and: [ anEvent  selector = #types]) ifTrue: [
		self reinstallAllTypes.	
	]. 
]

{ #category : #'generating - types' }
PhaROSCatkinDeployer >> manageType: definition [
[
	(Smalltalk at: #PhaROSTypeBrowser) instance definition:  definition build typeName. 
] on: Error do: [
	 self deployType: definition
].
	
]

{ #category : #'announcements on methods' }
PhaROSCatkinDeployer >> methodAdded: anEvent [
	
	((anEvent methodClass inheritsFrom: #PhaROSPackage asClass) and: [ (anEvent selector beginsWith: 'script')]) ifTrue:[
		self installScriptFor: anEvent selector ofPhaROSPackageClass: anEvent methodClass
	].

	self manageEvent: anEvent.
	
]

{ #category : #'announcements on methods' }
PhaROSCatkinDeployer >> methodModified: anEvent [
	self methodAdded: anEvent
	
]

{ #category : #'announcements on methods' }
PhaROSCatkinDeployer >> methodRemoved: anEvent [

	((anEvent methodClass inheritsFrom: #PhaROSPackage asClass) and: [ (anEvent selector beginsWith: 'script')]) ifTrue:[
		self removeScriptFor: anEvent selector ofPhaROSPackageClass: anEvent methodClass
	].

	self manageEvent: anEvent.
	
]

{ #category : #utils }
PhaROSCatkinDeployer >> newFile: aName at: aPath with: aContent [ 
	| file | 
	file := StandardFileStream forceNewFileNamed:  (aPath / aName) pathString.
	file nextPutAll: aContent withUnixLineEndings.
	file flush.
	file close. 
	^ self.
]

{ #category : #'generating - packageXml' }
PhaROSCatkinDeployer >> packageXml [

	^ self packagexmlFor: self phaROSPackageClass 
]

{ #category : #'generating - packageXml' }
PhaROSCatkinDeployer >> packagexmlContentFor: aPackage [
	^ ' <name>{1}</name>
  <version>{2}</version>
  <description>{3}</description>
  <maintainer email="{4}">{5}</maintainer>
  <license>{6}</license>
  <author email="{7}">{8}</author> 
  <buildtool_depend>catkin</buildtool_depend>
  <export>
  </export>' format:{ 
	aPackage catkinPackageName. 
	aPackage catkinPackageVersion.
	aPackage catkinPackageDescription.
	aPackage catkinPackageMaintainerEmail.
	aPackage catkinPackageMaintainer.
	aPackage catkinPackageLicense.
	aPackage catkinPackageAuthorEmail.
	aPackage catkinPackageAuthor.
 }
]

{ #category : #'generating - packageXml' }
PhaROSCatkinDeployer >> packagexmlFor: aPackage [

^(deployedServices , deployedTypes ) isEmpty not ifTrue: [ 
				
'<?xml version="1.0"?>
<package>
	 {1}
	  <build_depend>roscpp</build_depend>
	  <build_depend>rospy</build_depend>
	 {2}
	 {3}
</package>' format: {
		self packagexmlContentFor: aPackage. 
		self dependenciesForPackageXml  inject:'' into: [ :acc :type | acc, ('<build_depend>{1}</build_depend>' format: {type}), String lf ] .
		self dependenciesForPackageXml inject:'' into: [ :acc :type | acc, ('<run_depend>{1}</run_depend>' format: {type}), String lf ] .
	 }
] ifFalse: [ 
'<?xml version="1.0"?>
<package>
 {1}
</package>' format: {
	 self packagexmlContentFor: aPackage.   
 }
	
]
]

{ #category : #accessing }
PhaROSCatkinDeployer >> phaROSPackageClass [
	^ phaROSPackageClass
]

{ #category : #accessing }
PhaROSCatkinDeployer >> phaROSPackageClass: aPhaROSPackageClass [
	phaROSPackageClass := aPhaROSPackageClass
]

{ #category : #'public api' }
PhaROSCatkinDeployer >> reinstallAllScripts [
	self scriptsDirectory allFiles do: [ : e| e delete ].
	self installAllScripts.
]

{ #category : #'public api' }
PhaROSCatkinDeployer >> reinstallAllTypes [
	self servicesDirectory allFiles do: [ :e | e delete ]. 
	self typesDirectory allFiles do: [ :e | e delete ].
	self installAllTypes.
]

{ #category : #'generating - scripts methods' }
PhaROSCatkinDeployer >> removeScriptFor:  aSelector ofPhaROSPackageClass: aPhaROSPackageClass [

	 | scriptFileName |
((aSelector beginsWith: 'script') and: [(aSelector indexOf: $:) = 0])  ifFalse: [ ^ self ].

	scriptFileName := self filenameFor: aSelector inClass: aPhaROSPackageClass.
	
	(self scriptsDirectory / scriptFileName) asFileReference ensureDelete 

]

{ #category : #accessing }
PhaROSCatkinDeployer >> scriptsDirectory [
	"assuming that this PhaROS image is correctly stored in 
		catkin-ws / src / <packageName> / image / <packageName>.image
		catkin-ws / src / <packageName> / image / scripts / script*.st
	"
	^ Smalltalk imageDirectory / #scripts 
		
]

{ #category : #accessing }
PhaROSCatkinDeployer >> servicesDirectory [
	"assuming that this PhaROS image is correctly stored in 
		catkin-ws / src / <packageName> / image / <packageName>.image
		catkin-ws / src / <packageName> / srv
	"
	^ Smalltalk imageDirectory / #srv 
		
]

{ #category : #accessing }
PhaROSCatkinDeployer >> typesDirectory [
	"assuming that this PhaROS image is correctly stored in 
		catkin-ws / src / <packageName> / image / <packageName>.image
		catkin-ws / src / <packageName> / msg
	"
	^ Smalltalk imageDirectory / #msg 
		
]
