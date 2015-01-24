"
usage: pharos create PACKAGE [OPTIONS]
 
Options:
          --help	Shows this text
          --location	Absolute path to a valid catkin workspace (not source folder. The workspace. By example /home/user/workspace ). 
                              Default value is the current directory.		
          --silent	{ true | false }. If silent is false you will be able to see the installation of the output image. 
                              Default value is true. 
          --version	{ 20 | 30 | 40 | Stable | Alpha}.  pharo version to use. 
                              Default value is Stable
          --archetype	Indicates the name of the archetype to use for creating things. 
                              Default is basic-archetype.
          --author	Indicates the name of the author
          --maintainer	Indicates the name of the maintainer
                              Default value is the indicated in author

          --author-email	Indicates the email  of the author
          --maintainer-email	Indicates the email of the maintainer 
                              Default value is the indicated in author-email
          --description	Indicates the description of the package
	    --pharo-user	Indicates the user name for the result image.
          --force-new	DELETE the package if it exists in the pointed location. 

"
Class {
	#name : #PRCCommandLineCreateHandler,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #accessing }
PRCCommandLineCreateHandler class >> commandName [
	^ 'create'
]

{ #category : #help }
PRCCommandLineCreateHandler class >> shortHelpText [
	^ 'Creates a new package based on an archetype'
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> archetype [

	^ (self optionAt: #archetype ifAbsent: [  'basic-archetype' ] )
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> author [

	^  (self optionAt: #author ifAbsent: [  'pharos' ] ).
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> authorEmail [

	^  (self optionAt: #'author-email' ifAbsent: [  'author@mail.com' ] ).
]

{ #category : #utilities }
PRCCommandLineCreateHandler >> chmod: rights ofFile: stringPath [
	^ #OSProcess asClass command: ('chmod {1} {2}' format: { rights . stringPath }).
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> description [

	^  (self optionAt: #'description' ifAbsent: [  ' A PhaROS package '  ] ).
]

{ #category : #'generating - scripts' }
PRCCommandLineCreateHandler >> editScriptForPhaROSPackageNamed: packageName [

^('#!/usr/bin/env bash
DIR=`rospack find {1}`
	
$DIR/vm/pharo $DIR/image/{1}.image' format: { packageName }) withUnixLineEndings
]

{ #category : #'generation - catkin directory' }
PRCCommandLineCreateHandler >> generateCatkinDirectoryNamed: package atLocation: catkinPackageDirectory [

	| editScript headlessScript pharosScript |
	FileStream stdout nextPutAll: ('Generating catkin package for {1}' format: { package }) ; lf.
	self forceNewIfNeededAt: catkinPackageDirectory.
	{ 'bin' . 'image' . 'image/scripts'  . 'build' . 'include' . 'msg' . 'srv' } do: [  :dirName |
		(catkinPackageDirectory / dirName) createDirectory ].	
	
	editScript := catkinPackageDirectory / 'bin' / 'edit'.
	editScript writeStreamDo:
		[:stream | stream << (self editScriptForPhaROSPackageNamed: package) ].
	
	headlessScript := catkinPackageDirectory / 'bin' / 'headless'.
	headlessScript writeStreamDo:
		[:stream | stream << (self headlessScriptForPhaROSPackageNamed: package) ].

	pharosScript := catkinPackageDirectory / 'bin' / 'pharos'.
	pharosScript writeStreamDo:
		[:stream | stream << (self pharosScriptForPhaROSPackageNamed: package) ].
	
	FileStream stdout nextPutAll: ('Copying pharo vm from {1} to {2}' format: { (Smalltalk imageDirectory / 'pharo-vm') pathString.  (catkinPackageDirectory / 'vm' ) pathString}) ; lf.
	(Smalltalk imageDirectory / 'pharo-vm') copyAllTo: (catkinPackageDirectory / 'vm' ).
	
	{editScript .  headlessScript . pharosScript. catkinPackageDirectory / 'vm' / 'pharo'} do: [ :f |
		self chmod: '775' ofFile: f pathString ].
]

{ #category : #'generating - classes' }
PRCCommandLineCreateHandler >> generatePhaROSClassesCodeIn: stream forPhaROSPackageNamed: phaROSPackageClassName andNodeletNamed: phaROSNodeletClassName [

	stream <<	
		('#PhaROSPackage asClass
			subclass: #{1}
			instanceVariableNames: ''''
			classVariableNames: ''''
			poolDictionaries: ''''
			category: ''{1}''.' format: {phaROSPackageClassName}) withUnixLineEndings ; lf;lf.
	
	stream <<
		('#PhaROSStaticNodelet asClass
			subclass: #{1}
			instanceVariableNames: ''''
			classVariableNames: ''''
			poolDictionaries: ''''
			category: ''{2}-Nodelets''.' format: { phaROSNodeletClassName .  phaROSPackageClassName}) withUnixLineEndings ; lf ;lf.
	
	stream <<	
		('#{1} asClass
		compile:
			''buildController
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message."
	
	^ self nodeletInjectionExample: super buildController. ''
 		classified: ''private - configuration''.' format: { phaROSPackageClassName }) withUnixLineEndings; lf;lf.
		
	stream <<	
		('#{1}  asClass
		compile:
			(''nodeletInjectionExample: aController
	
		"Nodelets are units objects responsible for solving common problems, meaning that there are reusable. 
	In order to access to a nodelet from a package we use a simple mechanism of dependency injection, so we 
	can easily change one implementation for other. 
		The main problem is the management of name for registration. Try to be clean and obvious with names. Comment and make them visible.
	For know more about nodelets go to the reference or check subclasses (PhaROSTransformationNodelet is a cool place to go"

	aController nodelets use: #{2} asClass as: #example.
	aController nodelets example isKindOf: #{2} asClass.
	^ aController. '')
		classified: ''private - configuration''.' format: {phaROSPackageClassName . phaROSNodeletClassName}) withUnixLineEndings;lf;lf

		
]

{ #category : #'generating - scripts' }
PRCCommandLineCreateHandler >> headlessScriptForPhaROSPackageNamed: packageName [

^('#!/usr/bin/env bash
DIR=`rospack find {1}`
	
$DIR/vm/pharo --nodisplay  $DIR/image/{1}.image st $DIR/scripts/$1.st' format: { packageName }) withUnixLineEndings
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> maintainer [

	^  (self optionAt: #'maintainer' ifAbsent: [ self author] ).
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> maintainerEmail [

	^  (self optionAt: #'maintainer-email' ifAbsent: [  self authorEmail  ] ).
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> package [
	| p |
	p := (self argumentAt: 1).
	(p indexOf: $-) = 1 ifTrue: [ ^ self error: 'The package name is not optional and it must be the first parameter' ].
	^ p.
]

{ #category : #utilities }
PRCCommandLineCreateHandler >> pharosClassNameForCatkinPackageNamed: catkinPackageName [
	^ catkinPackageName capitalized , 'Package'
]

{ #category : #'generating - scripts' }
PRCCommandLineCreateHandler >> pharosScriptForPhaROSPackageNamed: packageName [

^('#!/usr/bin/env bash
DIR=`rospack find {1}`
	
$DIR/vm/pharo $DIR/image/{1}.image st $DIR/scripts/$1.st' format: { packageName }) withUnixLineEndings
]

{ #category : #activation }
PRCCommandLineCreateHandler >> realActivate [

	| location package archetype  version silent   author authorEmail maintainer maintainerEmail description    pharoImage loadingScriptName loadingScript phaROSPackageClassName phaROSNodeletClassName catkinWorskpaceDirectory catkinPackageDirectory    |
	
	package := self package. "name of the catkin package to create"
	location := self location. "catkinWorskpaceDirectory (~/PhaROS-ws)"
	version := self version. "version of Pharo to use (Stable)"
	
	"remove these 2"
	archetype := self archetype. "name of the group to load in the ConfigurationOfPhaROS (basic-archetype)"
	silent := self silent. "true or false"
	
	author := self author.
	authorEmail := self authorEmail.
	maintainer := self maintainer.
	maintainerEmail := self maintainerEmail.
	description := self description.
	
	catkinWorskpaceDirectory := location asFileReference. 
	catkinPackageDirectory :=  catkinWorskpaceDirectory / 'src' / package.
	
"Create the catkin package structure and files"
	self generateCatkinDirectoryNamed: package atLocation: catkinPackageDirectory.
	
"Create the PhaROSimage for this new package"
	loadingScript := WriteStream on: (String new: 500).
	
	loadingScript << 'Smalltalk saveAs: ''' << package asString << '''.'; lf. 
	loadingScript << 'SystemWindow allInstances do: #close.';lf.
	loadingScript << 'Author fullName: ''' << author asString<< '''.'; lf. 

	"Load PhaROS project"
	loadingScript lf ; << 'FileStream stdout nextPutAll: ''Loading ConfigOfPhaROS load: basic-archetype'', String lf.' ; lf.
	loadingScript << '(Gofer it url: ''http://smalltalkhub.com/mc/CAR/PhaROS/main''; package: ''ConfigurationOfPhaROS'') load.' ; lf.	
	loadingScript << ('#ConfigurationOfPhaROS asClass load: ''{1}'' .' format: {archetype}); lf.
	
	loadingScript lf ; << ('FileStream stdout nextPutAll: ''Generating classes for {1}'', String lf.' format: { package }) ; lf;lf.
	phaROSPackageClassName := self pharosClassNameForCatkinPackageNamed: package.	
	phaROSNodeletClassName := package capitalized , 'Nodelets'.	"nodelet"	
	self generatePhaROSClassesCodeIn: loadingScript forPhaROSPackageNamed: phaROSPackageClassName andNodeletNamed: phaROSNodeletClassName.

self flag: #todo.
"CMakeLists.txt MUST contain the ros types of the PhaROS packages"
"move RCDLifeCycle to PhaROS and rename it: ROSCatkinDeployer
and we should only generate: ROSCatkinDeployer generateCMakeListsTxt
"

(catkinPackageDirectory / 'CMakeLists.txt') writeStreamDo: [ :stream |
		stream nextPutAll: 'cmake_minimum_required(VERSION 2.8.3)
project(testpackage)
find_package(catkin REQUIRED)
catkin_package()' ].

"we should only generate: ROSCatkinDeployer generatePackageXml"
(catkinPackageDirectory / 'package.xml') writeStreamDo: [ :stream |
		stream nextPutAll:  ('<?xml version="1.0"?>
<package>
<name>{1}</name>
  <version>{2}</version>
  <description>{3}</description>
  <maintainer email="{4}">{5}</maintainer>
  <license>{6}</license>
  <author email="{7}">{8}</author> 
  <buildtool_depend>catkin</buildtool_depend>
</package>' format: { 
	package. 
	'0.1.0'. "Stable is not allowed by catkin"
	description.
	maintainerEmail.
	maintainer.
	'MIT'.
	authorEmail.
	author.
 }) withUnixLineEndings].

#OSProcess asClass command: ('cd {1} && catkin_make' format: { catkinWorskpaceDirectory pathString }).

"	RCDLifeCycle>>installAllScripts"
"same here we should generate: ROSCatkinDeployer generateScriptsForAllPackages"	
	
"	RCDLifeCycle>>installResident"
"same here we should generate: ROSCatkinDeployer installAnnoucementsToAutomaticallyGenerateScripts"	

	loadingScript lf ; << 'FileStream stdout lf; nextPutAll: ''Prepare windows '', String lf.';lf.
	
	"Open browser on newly created PhaROS package class"
	loadingScript  << ('#{1} asClass browse.' format: { self pharosClassNameForCatkinPackageNamed: package });lf.
	
	self flag: #todo.
	loadingScript  << 'Smalltalk at: #PhaROSDoc ifPresent: [ :doc | doc open ].';lf.

	loadingScript lf ; << 'Smalltalk snapshot: true andQuit: true.' ; lf.

	"save the script"
	loadingScriptName := Smalltalk imageDirectory / 'loadingScript.st'.
	loadingScriptName ensureDelete.
	loadingScriptName	writeStreamDo: [ :stream |
		stream nextPutAll: loadingScript contents ].
	
	"remove <packageName>.image <packageName>.changes if exists"
	(Smalltalk imageDirectory / package, '.image') ensureDelete.
	(Smalltalk imageDirectory / package, '.changes') ensureDelete.
	
	"download Pharo<version>.image  if needed"
	pharoImage := Smalltalk imageDirectory / ('Pharo', version asString, '.image').
	pharoImage exists ifFalse: [ 
		"download it" 
		self flag: #todo.
	].

	"make the <package>.image execute the loadingScriptName and move the resulting image"
	FileStream stdout lf ; nextPutAll: ('Executing the loading script') ; lf.
	#OSProcess asClass command: ('./pharo {1} st {2} && mv {3}.image {3}.changes {4}/image/' format: {pharoImage pathString. loadingScriptName pathString. package asString. catkinPackageDirectory pathString}).
	
	


]
