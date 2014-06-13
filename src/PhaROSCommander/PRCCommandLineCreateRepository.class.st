"
usage
	pharos create-repository PACKAGENAME [ OPTIONS ]
	
	PACKAGENAME	is the name of the project that this directory will represent. By Example PhaROS.
	
	--user name of the user for generation by default is 'Generated'
	--output path to where the script will be dumped. By default is the standar output.
"
Class {
	#name : #PRCCommandLineCreateRepository,
	#superclass : #PRCDisabledCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineCreateRepository class >> commandName [
	^ 'create-repository'
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateRepository >> optionAt: anOption ifPresent: aBlock ifAbsent: otherBlock [ 
	^ aBlock value: (self optionAt: anOption ifAbsent: [ ^ otherBlock value ]).

]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateRepository >> outputFor: aPackageName andUser: aUserName [
^
(('Object subclass: #{1}Directory
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''{1}Directory''!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

{1}Directory class
	instanceVariableNames: ''''!

!{1}Directory class methodsFor: ''packages'' stamp: ''{2} {3}''!
exampleMetacelloPackage
	^ ~ 
			#name -> ''example'' .
			#description -> ''Example package'' . 
			#license ->  ''MIT''  .
			#version -> ''0.1.0'' .
			#maintainer -> (~ 
				#name-> ''{2}'' . 
				#email -> ''{2}@mail.com'' 
			?  asDictionary) .
			#author -> (~  
				#name-> ''{2}'' . 
				#email -> ''{2}@mail.com''  
			? asDictionary) .
			#metacello -> (~ 
				#url -> ''http://smalltalkhub.com/mc/{2}/{1}/main'' . 
				#configurationOf -> ''ConfigurationOf{1}'' . 
				#package -> ''{1}''  
			? asDictionary)
		 ? asDictionary 
	! !
!{1}Directory class methodsFor: ''packages'' stamp: ''{2} {3}''!
exampleMonticelloPackage
	^ ~ 
			#name -> ''example'' .
			#description -> ''Example package'' . 
			#license ->  ''MIT''  .
			#version -> ''0.1.0'' .
			#maintainer -> (~ 
				#name-> ''{2}'' . 
				#email -> ''{2}@mail.com'' 
			?  asDictionary) .
			#author -> (~  
				#name-> ''{2}'' . 
				#email -> ''{2}@mail.com''  
			? asDictionary) .
			#monticello -> (~ 
				#url -> ''http://smalltalkhub.com/mc/{2}/{1}/main'' . 
				#package -> ''{1}''  
			? asDictionary)
		 ? asDictionary 
	! !


!{1}Directory class methodsFor: ''archetypes'' stamp: ''{2} {3}''!
archetypeExample
	^ ~ 
			#archetype -> ''{1}-archetype'' .
			#description -> ''description'' . 
			#license ->  ''MIT''  .
			#version -> ''0.1.0'' .
			#maintainer -> (~ 
				#name-> ''arechetype-default-user'' . 
				#email -> ''arechetype-default-user@email.com'' 
			?  asDictionary) .
			#author -> (~  
				#name-> ''arechetype-default-user'' . 
				#email -> ''arechetype-default-user@email.com''  
			? asDictionary) .
			#metacello -> (~ 
				#url -> ''http://smalltalkhub.com/mc/{2}/{1}/main'' . 
				#configurationOf -> ''ConfigurationOf{1}'' . 
				#package -> ''{1}-archetype''  
			? asDictionary)
		 ? asDictionary 
	! !


!{1}Directory class methodsFor: ''util'' stamp: ''{2} {3}''!
deployUnitFor: aCriteria
	^ self deployUnits detect: aCriteria ifNone: [ self error: ''There is not unit for the given criteria'' ].! !

!{1}Directory class methodsFor: ''util'' stamp: ''{2} {3}''!
deployUnitForPackage: aPackageName 
		^ self deployUnitFor: [ : d | d isArchetype ifFalse: [d packageName = aPackageName] 
														ifTrue: [ d archetype = aPackageName ]  ]! !

!{1}Directory class methodsFor: ''util'' stamp: ''{2} {3}''!
deployUnits
	^ self deployUnitsMetadata collect: [ :m | 
		(Smalltalk at:#MDPharoDeployUnit) forMetadata: m.
	].! !

!{1}Directory class methodsFor: ''util'' stamp: ''{2} {3}''!
deployUnitsMetadata

	^ ~ 
	
		self exampleMetacelloPackage.
		self exampleMonticelloPackage.
		self archetypeExample.
	
	 ?! !

!{1}Directory class methodsFor: ''util'' stamp: ''{2} {3}''!
includesPackage: aPackageName 
	^ self deployUnits anySatisfy:  [ : d | d isArchetype ifFalse: [d packageName = aPackageName] 
														ifTrue: [ d archetype = aPackageName ]  ]! !
'format: { aPackageName . aUserName . DateAndTime now asString }) copyReplaceAll: '~' with: '{')  copyReplaceAll: '?' with: '}' 
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateRepository >> realActivate [ 
	
	| packageName user output |
	
	packageName := self argumentAt: 1.
	(RBCondition isValidClassName: packageName) check ifFalse:[
		self error: packageName, ' is not a valid name for a package. It must start with uppercase. ThisIsACorrectPackageName '	
	].
	user := self optionAt: 'user' ifAbsent:[ 'Generated' ].
	output := self optionAt: 'output' ifPresent:[ : filePath | (filePath asFileReference openWritable: true) writeStream ] ifAbsent:[ self stdout  ].
	
	output nextPutAll: (
		self outputFor: packageName andUser: user
	).
	
	output = self stdout ifFalse: [ output flush; close. ].
]
