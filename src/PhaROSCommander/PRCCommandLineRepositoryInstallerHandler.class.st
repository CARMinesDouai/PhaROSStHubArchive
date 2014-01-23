"
usage: pharos register-repository --url=anUrl --package=aPackage [ OPTIONS ]


Options: 

          --url		[ MANDATORY ] url of a monticello repository
          --package	[ MANDATORY ] monticello package name.
          --directory	Name of the class that works as directory This class must implement  
                               - #includesPackage: 
                               - #deployUnitForPackage: 
                              Default value - the value given for package. 
          --user	Username for the monticello repository
                              Default value - empty
          --password	Password for the monticello repository
                              Default value - empty
	
	
 The directory class needs to implement

- #includesPackage: aPackageName
	this method receive a name of package and return a boolean indicating if package is included by this directory 
	
- #deployUnitForPackage: aPackageName
	this methods receive a name of package and return a kind of MDPharoDeployUnit. 

For more information checkout the package PhaROSDeploymentDirectory from the squeaksource repository located at:
	http://car.mines-douai.fr/squeaksource/PhaROS

	
"
Class {
	#name : #PRCCommandLineRepositoryInstallerHandler,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryInstallerHandler class >> commandName [
	^ 'repository-register'
]

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryInstallerHandler >> realActivate [ 
	| url repository class repo user password|
	
	"
	 usage --url url --package package --directory class --user user --password pass.
	             url package directory --user user --password password
	"
	
	url := (self optionAt: #url ifAbsent: [ self error: 'URL is not an optional parameter. (--url url)' ]).
	repository :=  (self optionAt: #package ifAbsent: [ 'Monticello package is not an optional parameter. (--package package)' ]).
	class :=  (self optionAt: #directory ifAbsent: [ repository ]).
	user :=  (self optionAt: #user ifAbsent: [ '' ]).
	password := ''.
	
	user isEmpty ifFalse:[
		password :=  (self optionAt: #password ifAbsent: [ user:=''. '' ]).
	].

	[
		Gofer it url: url username: user password: password; package: repository; load.
		((Smalltalk at: class asSymbol) respondsTo: #includesPackage: ) ifFalse: [ 
			self error: class, ' must respond to #includesPackage: to be registered'.
		 ]
	
	] on:Error do: [ 
		:e | self error: 'Error installing repository: ', e messageText, String lf.
	 ].

	repo := ((FileLocator workingDirectory / self repositoriesFileName) openWritable: true) writeStream.
	
	repo setToEnd.
	repo nextPutAll: (self repositoryFormat format:{url . repository . class . user . password } ), String lf.
	repo close. 
	self stdout nextPutAll: ' repository installed correctly. ', String lf.
]

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryInstallerHandler >> repositoryFormat [
	^ 'url={1}|repository={2}|directory={3}|user={4}|password={5};'
]
