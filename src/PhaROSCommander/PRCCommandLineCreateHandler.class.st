"
usage: pharos create PACKAGE [OPTIONS]
 
Options:
   --help                     Shows this text
   --location=...             Absolute path to a valid catkin workspace (not source folder. 
                              The workspace. By example /home/user/workspace ). 
                              Default value is ~/Pharo-ws/
   --silent={true|false}      If silent is false you will be able to see the installation of the output image 
                              Default value is true. 
   --version={ 20 | 30 | 40 | stable | alpha}  Pharo version to use. 
                                               Default value is stable
    --force-new                DELETE the package if it exists in the pointed location. 
   --dev                      Load the bleedingEdge version of PhaROS
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

{ #category : #'phaROS images' }
PRCCommandLineCreateHandler >> buildNewPhaROSImageNamed: phaROSImageName usingPharoVersion: pharoVersionString [ 
	
	| pharoImage loadingScript launchCommandString |
	pharoImage := self pharoImageFileForVersion: pharoVersionString.	
	
	loadingScript := WriteStream on: (String new: 500).	
	loadingScript << 'Smalltalk saveAs: ''' << phaROSImageName base << '''.'.
	
	"set the same proxy as here in the pacakge image"
	NetworkSystemSettings useHTTPProxy ifTrue: [ 
			loadingScript << ('NetworkSystemSettings useHTTPProxy: true; httpProxyServer: ''{1}''; httpProxyPort: {2}.'
								format: {NetworkSystemSettings httpProxyServer. NetworkSystemSettings httpProxyPort})].	
				
	"Load/Update PhaROS project"
	loadingScript << '(Gofer it url: ''http://smalltalkhub.com/mc/CAR/PhaROS/main''; package: ''ConfigurationOfPhaROS'') load.'.
	loadingScript << 'VTermOutputDriver stdout yellow: ''Loading ConfigurationOfPhaROS loadStableFromCommander''; lf.'.
	loadingScript << ('#ConfigurationOfPhaROS asClass {1}.' format: {self phaROSVersionNameToLoad}).	
	loadingScript << 'Smalltalk snapshot: true andQuit: true.'.
	
	"make the Pharo<version>.image execute the loadingScriptName"
	launchCommandString := '{1}/pharo {2} eval "{3}"'
				format:
					{(Smalltalk imageDirectory pathString).
					(pharoImage pathString).
					(loadingScript contents)}.

	self stdout: launchCommandString.

	OSProcess waitForCommand: launchCommandString.
"	3 seconds wait	""here we wait for OSProcess commands executing in background to finish"""
]

{ #category : #utilities }
PRCCommandLineCreateHandler >> chmod: rights ofFile: stringPath [
	^ OSProcess command: ('chmod {1} {2}' format: { rights . stringPath }).
]

{ #category : #'pharo images' }
PRCCommandLineCreateHandler >> downloadPharoVersionNamed: pharoVersionString [ 

	OSProcess waitForCommand: ('cd {1} && curl get.pharo.org/{2} | bash && mv Pharo.image Pharo{2}.image && mv Pharo.changes Pharo{2}.changes'
								format: { Smalltalk imageDirectory pathString. 
											pharoVersionString})
]

{ #category : #catkin }
PRCCommandLineCreateHandler >> generateCatkinDirectoryNamed: package atLocation: catkinPackageDirectory [
	"
		create this structure:
		
		catkinPackageDirectory/
			|- image/
			|-vm/
				|- pharo
	"
	self stdout lf.
	self stdout: ('Generating catkin package for {1}' format: { package }).
	self forceNewIfNeededAt: catkinPackageDirectory.
	(catkinPackageDirectory / 'image' ) createDirectory.
		
	self stdout: ('Copying pharo vm from {1} to {2}' format: { (Smalltalk imageDirectory / 'pharo-vm') pathString.  (catkinPackageDirectory / 'vm' ) pathString}).
	(Smalltalk imageDirectory / 'pharo-vm') copyAllTo: (catkinPackageDirectory / 'vm' ).
	
	self chmod: '775' ofFile: (catkinPackageDirectory / 'vm' / 'pharo') pathString.
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> package [
	| p |
	p := (self argumentAt: 1).
	(p indexOf: $-) = 1 ifTrue: [ ^ self exitFailure: 'The package name is not optional and it must be the first parameter' ].
	^ p.
]

{ #category : #'phaROS images' }
PRCCommandLineCreateHandler >> phaROSImageFileForPharoVersion: pharoVersionString [
	
	| pharosSuffix phaROSImage |
	
	self shouldLoadBleedingEdge 
		ifTrue: [ pharosSuffix := 'PhaROS-BleedingEdge' ]
		ifFalse: [ pharosSuffix := 'PhaROS-Stable' ].
	
	phaROSImage := Smalltalk imageDirectory / ('Pharo' , pharoVersionString , '-', pharosSuffix, '.image').
	
	self shouldLoadBleedingEdge ifTrue: [ 
		phaROSImage ensureDelete.
		(Smalltalk imageDirectory / ('Pharo' , pharoVersionString , '-', pharosSuffix, '.changes')) ensureDelete ].
	
	phaROSImage exists not 
		ifTrue: [ self buildNewPhaROSImageNamed: phaROSImage usingPharoVersion: pharoVersionString ].

	^ phaROSImage
]

{ #category : #'phaROS images' }
PRCCommandLineCreateHandler >> phaROSVersionNameToLoad [
	| versionToLoad |
	self shouldLoadBleedingEdge
		ifTrue: [ versionToLoad := 'loadBleedingEdgeFromCommander' ]
		ifFalse: [ versionToLoad := 'loadStableFromCommander' ].
	^ versionToLoad
]

{ #category : #'pharo images' }
PRCCommandLineCreateHandler >> pharoImageFileForVersion: pharoVersionString [

	| pharoImage |
	pharoImage := Smalltalk imageDirectory / ('Pharo' , pharoVersionString , '.image').
	
	(pharoVersionString = 'alpha') ifTrue: [  
		pharoImage ensureDelete.
		(Smalltalk imageDirectory / ('Pharo' , pharoVersionString , '.changes')) ensureDelete ].
	
	pharoImage exists not ifTrue: [ self downloadPharoVersionNamed: pharoVersionString ].

	^ pharoImage
]

{ #category : #catkin }
PRCCommandLineCreateHandler >> pharosClassNameForCatkinPackageNamed: catkinPackageName [
	^ catkinPackageName capitalized , 'Package'
]

{ #category : #activation }
PRCCommandLineCreateHandler >> realActivate [
	| location package version silent loadingScriptName loadingScript catkinWorskpaceDirectory catkinPackageDirectory   catkinPackageImageDirectory pharoVersionString launchCommandString  phaROSImage |
	
	package := self package.	"name of the catkin package to create"
	location := self location.	"catkinWorskpaceDirectory (~/PhaROS-ws by default)"
	version := self version.	"version of Pharo to use (Stable)"
	silent := self silent.	"true or false"

	catkinWorskpaceDirectory := location asFileReference.
	catkinPackageDirectory := catkinWorskpaceDirectory / 'src' / package.
	catkinPackageImageDirectory := catkinPackageDirectory / 'image'.	
	
	"download Pharo<version>.image if needed"
	pharoVersionString := version asString translateToLowercase.
		
	"use (or build) Pharo<version>-PhaROS<dev>.image if needed"
	phaROSImage := self phaROSImageFileForPharoVersion: pharoVersionString.	
	
	"rename the image to not pollute the cached one"
	loadingScript := WriteStream on: (String new: 500).	

	"save the image in the catkin directory"
	(loadingScript << 'Smalltalk saveAs: ''' << (catkinPackageImageDirectory pathString , '/' , package asString)) << '''.'; lf.
	loadingScript lf; << ('VTermOutputDriver stdout lf ; yellow: ''Generating catkin files: package.xml, CMakeFileLists.txt...'' ; lf.' format: {package});	lf.
				
	"set the same proxy as here in the pacakge image"
	NetworkSystemSettings useHTTPProxy ifTrue: [ 
			loadingScript << ('NetworkSystemSettings useHTTPProxy: true; httpProxyServer: ''{1}''; httpProxyPort: {2}.'
								format: {NetworkSystemSettings httpProxyServer. NetworkSystemSettings httpProxyPort}); lf ].	
					
	"setup image for the catkin package in which the Pharo image is saved"
	loadingScript lf; << 'Author useAuthor: ''pharos'' during: [ #PhaROSCatkinDeployer asClass setupImageForCurrentCatkinPackage ].'; lf. 
	loadingScript lf; << 'Smalltalk snapshot: true andQuit: true'; 	lf.	
	
	"Create the catkin package structure and files"
	self generateCatkinDirectoryNamed: package atLocation: catkinPackageDirectory.
	loadingScriptName := catkinPackageImageDirectory / (package , 'ImageCreationScript.st').	
	loadingScriptName writeStreamDo: [ :stream | stream nextPutAll: loadingScript contents ].	
	
	"make the Pharo<version>.image execute the loadingScriptName"
	launchCommandString := '{1}/pharo {2} st {3}'
				format:
					{(Smalltalk imageDirectory pathString).
					(phaROSImage pathString).
					(loadingScriptName pathString).
					(package asString)}.

	self stdout: launchCommandString.

	OSProcess waitForCommand: launchCommandString.
	3 seconds wait	"here we wait for OSProcess commands executing in background to finish"
		
]
