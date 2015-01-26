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
   --pharo-user=...           Indicates the user name for the result image.
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

{ #category : #utilities }
PRCCommandLineCreateHandler >> chmod: rights ofFile: stringPath [
	^ #OSProcess asClass command: ('chmod {1} {2}' format: { rights . stringPath }).
]

{ #category : #utilities }
PRCCommandLineCreateHandler >> generateCatkinDirectoryNamed: package atLocation: catkinPackageDirectory [
	"
		create this structure:
		
		catkinPackageDirectory/
			|- image/
			|-vm/
				|- pharo
	"
	FileStream stdout nextPutAll: ('Generating catkin package for {1}' format: { package }) ; lf.
	self forceNewIfNeededAt: catkinPackageDirectory.
	(catkinPackageDirectory / 'image' ) createDirectory.
		
	FileStream stdout nextPutAll: ('Copying pharo vm from {1} to {2}' format: { (Smalltalk imageDirectory / 'pharo-vm') pathString.  (catkinPackageDirectory / 'vm' ) pathString}) ; lf.
	(Smalltalk imageDirectory / 'pharo-vm') copyAllTo: (catkinPackageDirectory / 'vm' ).
	
	self chmod: '775' ofFile: (catkinPackageDirectory / 'vm' / 'pharo') pathString.
]

{ #category : #accessing }
PRCCommandLineCreateHandler >> loadBleedingEdge [
	^ self hasOption: 'dev'
	
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

{ #category : #activation }
PRCCommandLineCreateHandler >> realActivate [

	| location package  version silent  pharoImage loadingScriptName loadingScript   catkinWorskpaceDirectory catkinPackageDirectory    versionToLoad pharoUser catkinPackageImageDirectory  pharoVersionString |
	
	package := self package. "name of the catkin package to create"
	location := self location. "catkinWorskpaceDirectory (~/PhaROS-ws by default)"
	version := self version. "version of Pharo to use (Stable)"
	pharoUser := self pharoUser.
		
	self loadBleedingEdge 
		ifTrue: [ versionToLoad := 'loadBleedingEdgeFromCommander' ] 
		ifFalse: [ versionToLoad := 'loadStableFromCommander' ].
	
	"remove all below"
	silent := self silent. "true or false"

	catkinWorskpaceDirectory := location asFileReference. 
	catkinPackageDirectory :=  catkinWorskpaceDirectory / 'src' / package.
	catkinPackageImageDirectory := catkinPackageDirectory / 'image'.
	
	"Create the PhaROSimage for this new package"
	loadingScript := WriteStream on: (String new: 500).
	
	"rename the image to not pollute the cached one"
	loadingScript << 'Smalltalk saveAs: ''' << package asString << '''.'; lf. 
	loadingScript << 'Author fullName: ''' << pharoUser asString<< '''.'; lf. 

	OSEnvironment default at: 'http_proxy' ifPresent: [ : httpProxyString | 
		loadingScript <<  ('NetworkSystemSettings useHTTPProxy: true; httpProxyServer: ''{1}''; httpProxyPort: {2}.' format: (('http://10.1.1.3:8080/' subStrings: '/') second   subStrings: ':')) ;lf.
	].

	"Load PhaROS project"
	loadingScript << '(Gofer it url: ''http://smalltalkhub.com/mc/CAR/PhaROS/main''; package: ''ConfigurationOfPhaROS'') load.' ; lf.	
	loadingScript lf ; <<('FileStream stdout nextPutAll: ''Loading ConfigOfPhaROS {1}'', String lf.' format: { versionToLoad }) ; lf.
	loadingScript << ('#ConfigurationOfPhaROS asClass {1}.' format: {versionToLoad}); lf.

	"save the image in the catkin directory"
	loadingScript << 'Smalltalk saveAs: ''' << (catkinPackageImageDirectory pathString, '/', package asString) << '''.'; lf. 

	loadingScript lf ; << ('FileStream stdout nextPutAll: ''Generating catkin files: package.xml, CMakeFileLists.txt...'', String lf.' format: { package }) ; lf;lf.
	"setup image for the catkin package in which the Pharo image is saved"
	loadingScript lf ; << '#PhaROSCatkinDeployer asClass setupImageForCurrentCatkinPackage.' ; lf ; lf.
	
	loadingScript lf ; << 'Smalltalk snapshot: true andQuit: true.' ; lf.

	"Create the catkin package structure and files"
	self generateCatkinDirectoryNamed: package atLocation: catkinPackageDirectory.

	"save the script in the catkin directory"
	loadingScriptName := catkinPackageImageDirectory / (package, 'ImageCreationScript.st').
"	loadingScriptName ensureDelete."
	loadingScriptName	writeStreamDo: [ :stream |
		stream nextPutAll: loadingScript contents ].
	
	"remove <packageName>.image <packageName>.changes if exists"
	(Smalltalk imageDirectory / package, '.image') ensureDelete.
	(Smalltalk imageDirectory / package, '.changes') ensureDelete.
	
	
	"download Pharo<version>.image  if needed"
	pharoVersionString := version asString translateToLowercase.
	pharoImage := Smalltalk imageDirectory / ('Pharo',pharoVersionString, '.image').
	((pharoImage exists not) or: [ pharoVersionString = 'alpha' ]) ifTrue: [ 
		OSProcess waitForCommand: ('curl get.pharo.org/{1} | bash && mv Pharo.image Pharo{1}.image && mv Pharo.changes Pharo{1}.changes' format: {pharoVersionString})
	].

	"make the <package>.image execute the loadingScriptName and move the resulting image"
	FileStream stdout lf ; nextPutAll: ('Executing the ImageCreationScript.st script') ; lf.
	OSProcess 
		waitForCommand: ('{1}/pharo {2} st {3} ; rm -f {1}/{4}.image {1}/{4}.changes' 
							format: {Smalltalk imageDirectory pathString . pharoImage pathString. loadingScriptName pathString. package asString}).
	
	4 seconds wait.
	OSProcess waitForCommand: 'echo "Press ENTER now for happyness..."'
		
]
