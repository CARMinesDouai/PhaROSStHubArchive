"
usage: pharos ros-install 

It installs a ROS in the machine. (Valid just for ubuntu).


Options: 

         --version			version of ROS. { fuerte | groovy | hydro }. Default: groovy.
	   --type-installation		Type of ros installation { desktop | desktop-full | ros-base }. Default: desktop.
	   --configure			Indicates if the installation should be configured (modifiy .bashrc file ).{true|false} Default: true.
	   --create-workspace		Indicates if a workspace should be created. It will create a workspace at ~/ros/worskpace. { true|false }. Default: true.
			
		
	
"
Class {
	#name : #PRCCommandLineROSInstallHandler,
	#superclass : #PRCCommandLineHandler,
	#instVars : [
		'configurations'
	],
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler class >> commandName [
	^ 'ros-install'
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> defaultShellPath [
	| path |
	path := '/bin/bash'.
	(OSProcess fileExists: path)
		ifTrue: [^ path]
		ifFalse: [self notify: path, ' not found']
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> execute: aCommand [

	(ExternalUnixOSProcess forkAndExec: self defaultShellPath arguments: (Array with: '-c' with: aCommand)  environment: nil descriptors: {
		FileStream stdin .
		FileStream stdout .
		FileStream stderr .	
	}) waitUntilComplete.
	 
	
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> initialize [
	super initialize.
	configurations := { 
		#lucid -> { #fuerte } .
		#oneiric -> { #fuerte . #groovy  } .
		#precise -> { #fuerte . #groovy . #hydro} .
		#quantal -> { #groovy . #hydro} .
		#raring -> { #hydro } 
	 }asDictionary 
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> realActivate [ 
	| version sourceit ubuntu workspace source type |
	
	
	version := self rosVersion.
	type := self typeInstallation. 
	
	sourceit := self sourceIt.
	ubuntu := self release asSymbol. 	
	workspace := self workspace .
	
	
	((configurations at: ubuntu ) includes: version) ifFalse: [ 
		self error: ('{1} version is not available for: {2}' format:{ version . ubuntu}).
	 ].

	({ #desktop . #'desktop-full' . #'ros-base' } includes: type) ifFalse: [ 
		self error: ('{1} is not a valid type of installation. { desktop | desktop-full | ros-base }' format: {type}).
	 ].
	
	source := ('source /opt/ros/{1}/setup.bash' format: { version }).
	
	self execute: ('sudo sh -c ''echo "deb http://packages.ros.org/ros/ubuntu {1} main" > /etc/apt/sources.list.d/ros-latest.list''' format: { ubuntu }).
	self execute: 'wget http://packages.ros.org/ros.key -O - | sudo apt-key add -'.
	self execute: 'sudo apt-get update'.
	self execute: ('sudo apt-get install ros-{1}-{2}' format: { version . type }).
	
	
	
	self execute: 'sudo rosdep init'.
	self execute: 'rosdep update'.
	self execute: 'sudo apt-get install python-rosinstall'.
	
	
	workspace ifTrue: [ 
		self execute: 'mkdir -p ~/ros/workspace/src'.
		self execute: source, '; cd ~/ros/workspace/src ; catkin_init_workspace ; cd ~/ros/workspace ; catkin_make' .	
	 ].

	sourceit ifTrue:[
		self execute: ' echo ''', source, '''>> ~/.bashrc '.
		self execute: ' echo ''export ROS_HOSTNAME=localhost''  >> ~/.bashrc '.
		self execute: ' echo ''export ROS_MASTER_URI=http://localhost:11311''  >> ~/.bashrc '.
		workspace ifTrue: [
			self execute: ' echo ''source ~/ros/workspace/devel/setup.bash''  >> ~/.bashrc '.
		]
	].
	
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> release [
	| stream releaseVal tag |
	stream := ('/etc/lsb-release' asFileReference openWritable: false) readStream.
	releaseVal := stream upToEnd.
	stream close.
	tag := 'DISTRIB_CODENAME='.
	^ (ReadStream on: releaseVal from: (releaseVal indexOfSubCollection: tag) + tag size to: releaseVal size) upTo: Character lf.
	
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> rosVersion [
	^  (self optionAt: #'version' ifAbsent: [  'groovy' ] ) asSymbol.
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> sourceIt [
	| val | 
	val := (self optionAt: #'configure' ifAbsent: [  'true' ] ) .

	^  self checkBoolean: (val )  ifFail: [ 
		 self error: val asString, ' is not a valid value for --silent. It should be true or false'.
	].
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> typeInstallation [
	^  (self optionAt: #'type-installation' ifAbsent: [  'desktop' ] ) asSymbol.
]

{ #category : #'as yet unclassified' }
PRCCommandLineROSInstallHandler >> workspace [
	| val | 
	val := (self optionAt: #'create-workspace' ifAbsent: [  'true' ] ) .

	^  self checkBoolean: (val )  ifFail: [ 
		 self error: val asString, ' is not a valid value for --silent. It should be true or false'.
	].
]
