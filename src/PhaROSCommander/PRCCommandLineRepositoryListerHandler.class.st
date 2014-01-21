"
list the repositories from repository file. If there is any problem, delete the repository file by hand
"
Class {
	#name : #PRCCommandLineRepositoryListerHandler,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryListerHandler class >> commandName [
	^ 'list-repositories'
]

{ #category : #'as yet unclassified' }
PRCCommandLineRepositoryListerHandler >> realActivate [ 
	self stdout nextPutAll: String lf.
	self stdout nextPutAll:( '-------',String lf).
	self readRepositories do:[
		:repo |
		repo keysAndValuesDo: [ :k :v | self stdout nextPutAll: (('{1} = {2}' format:{k.v}), String lf) ].
		self stdout nextPutAll:( '-------',String lf).
	].
	self stdout nextPutAll: String lf.
]
