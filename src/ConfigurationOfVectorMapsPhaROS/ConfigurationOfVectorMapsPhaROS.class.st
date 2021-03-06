Class {
	#name : #ConfigurationOfVectorMapsPhaROS,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfVectorMapsPhaROS
}

{ #category : #'development support' }
ConfigurationOfVectorMapsPhaROS class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfVectorMapsPhaROS class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #private }
ConfigurationOfVectorMapsPhaROS class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfVectorMapsPhaROS class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfVectorMapsPhaROS class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfVectorMapsPhaROS class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfVectorMapsPhaROS class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfVectorMapsPhaROS class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfVectorMapsPhaROS class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfVectorMapsPhaROS class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfVectorMapsPhaROS >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/CAR/VectorMaps/main'.
		spec project: 'VectorMaps' with: [
				spec
					className: #ConfigurationOfVectorMaps;
					versionString: #'bleedingEdge';
					repository: 'http://www.smalltalkhub.com/mc/CAR/VectorMaps/main' ].
		spec package: 'VectorMaps_PhaROS'. ].

]

{ #category : #baselines }
ConfigurationOfVectorMapsPhaROS >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/CAR/VectorMaps/main'.
		
		spec project: 'PhaROS' with: [
				spec
					className: #ConfigurationOfPhaROS;
					versionString: #'stable';
					repository: 'http://www.smalltalkhub.com/mc/CAR/PhaROS/main';
					loads: #('all') ].
		
		spec project: 'VectorMaps' with: [
				spec
					className: #ConfigurationOfVectorMaps;
					versionString: #'bleedingEdge';
					repository: 'http://www.smalltalkhub.com/mc/CAR/VectorMaps/main' ].				
		
		spec package: 'VectorMaps_PhaROS' with: [
			spec requires: #('PhaROS' 'VectorMaps') ].
		
		spec package: 'ScantovmapPackage' with: [
			spec requires: #('VectorMaps_PhaROS') ].
		
		spec 
			group: 'default' with: #('VectorMaps_PhaROS') ;
			group: 'ScanToVmap' with: #( 'ScantovmapPackage' )
			
	].

]

{ #category : #accessing }
ConfigurationOfVectorMapsPhaROS >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #'symbolic versions' }
ConfigurationOfVectorMapsPhaROS >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfVectorMapsPhaROS >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]
