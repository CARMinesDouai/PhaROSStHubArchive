Class {
	#name : #PRCCommandLineRepositoryInstallerHandler,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryInstallerHandler class >> commandName [
	^ 'register-repository'
]

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryInstallerHandler >> realActivate [ 
	| url repository class repo user password|
	
	"
	 usage --url url --package package --directory class --user user --password pass.
	             url package directory --user user --password password
	"
	
	url := (self optionAt: #url ifAbsent: [ self argumentAt: 1 ]).
	repository :=  (self optionAt: #package ifAbsent: [ self argumentAt: 2 ]).
	class :=  (self optionAt: #directory ifAbsent: [ self argumentAt: 3 ]).
	user :=  (self optionAt: #user ifAbsent: [ '' ]).
	user isEmpty ifFalse:[
		password :=  (self optionAt: #password ifAbsent: [ user:=''. '' ]).
	].

	[
		Gofer it url: url username: user password: password; package: repository; load.
		((Smalltalk at: class asSymbol) respondsTo: #includesPackage: ) ifFalse: [ 
			self error: class, ' must respond to #includesPackage: to be registered'.
		 ]
	] on:Error do: [ 
		:e | self error: 'Error installing repository: ', e messageText.
	 ].

	repo := ((FileLocator workingDirectory / self repositoriesFileName) openWritable: true) writeStream.
	
	repo setToEnd.
	repo nextPutAll: (self repositoryFormat format:{url . repository . class . user . password } ).
	repo close. 
	self stdout nextPutAll: ' repository installed correctly. '.
]

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryInstallerHandler >> repositoryFormat [
	^ 'url={1}|repository={2}|directory={3}|user:{4}|password:{5};'
]
