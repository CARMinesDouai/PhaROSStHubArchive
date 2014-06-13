"
usage: pharos install PACKAGE [OPTIONS]
 
Options:
          --help	Shows this text
          --location	Absolute path to a valid catkin workspace (not source folder. The workspace. By example /home/user/workspace ). 
                              Default value is the current directory.		
          --silent	{ true | false }. If silent is false you will be able to see the installation of the output image. 
                              Default value is true. 
          --version	{ 1.4 | 2.0 | 3.0 }. It indicates the version of pharo to download. It will not count if you are in a not silent session. 
                              Default value is 2.0
          --ros-distro	Indicates the distribution of ROS that you want to use. By default is groovy { groovy | hydro | fuerte } 	
          --package	Indicates the name of the package to install (If you use <<pharos install aPackage --package=otherPackage>> the one to be installed is otherPackage ).
          --package-version	Indicates the package version. By default it takes the latest one.
          --pharo-user	Indicates the user name for the result image.
          --force-new	DELETE the package if it exists in the pointed location. 

"
Class {
	#name : #PRCCommandLineInstallHandler,
	#superclass : #PRCDisabledCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineInstallHandler class >> commandName [
	^ 'install'
]

{ #category : #'as yet unclassified' }
PRCCommandLineInstallHandler class >> description [ 
	^ 'PhaROS installing utility'
]

{ #category : #'as yet unclassified' }
PRCCommandLineInstallHandler >> packageVersion [
	^ commandLine optionAt: #'package-version' ifAbsent:[ '' ].
	

]

{ #category : #'as yet unclassified' }
PRCCommandLineInstallHandler >> realActivate [

	| location package version silent deployer sourceFolder packageVersion rosDistro |
	
	
	version := self version.
	location := self location.
	silent := self silent.
	
	package := self package.
	packageVersion := self packageVersion. 
	rosDistro := self rosDistro. 
	
	sourceFolder := location asFileReference / #src.
	
	self forceNewIfNeededAt: sourceFolder / package.
	
	deployer := silent ifTrue: [
		RCDDeployerFactory silentDeployerFor:  sourceFolder pathString withPharoVersion:  version.
	] ifFalse:[
		RCDDeployerFactory interactiveDeployerFor: sourceFolder pathString  withPharoVersion:  version.
	].
	deployer codeGenerator registerPreProcess: (' Author fullName: ''{1}'' ' format:{ self pharoUser }).
	
	deployer codeGenerator registerPostProcess: ( '(Smalltalk at:#PhaROSSystemLauncher) distro: ''{1}'' asSymbol. ' format: { rosDistro } ).
	
	
	packageVersion ifEmpty: [ 
		deployer deploy:  (PRCCommandPackageRegistry  deployUnitForPackage:  package).
	 ] ifNotEmpty:[
		deployer deploy:  (PRCCommandPackageRegistry  deployUnitForPackage:  package) withVersion: packageVersion.
	] 
	









]
