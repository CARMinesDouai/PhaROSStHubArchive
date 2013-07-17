"
(ConfigurationOfPhaROS project version: #pharosRoboshop1) load
"
Class {
	#name : #ConfigurationOfPhaROS,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfPhaROS
}

{ #category : #private }
ConfigurationOfPhaROS class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfPhaROS class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), load latest mcz file for ConfigurationOfMetacello (using old 
	 Gofer API), then load the latest version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [ | error |
		"list of repositories to try, in case primary repository is not accessible"
		(Array 
			with: 'http://www.squeaksource.com/MetacelloRepository' 
			with: 'http://seaside.gemstone.com/ss/metacello') do: [:repositoryUrl |
				([
					Smalltalk at: #Gofer ifAbsent: [
					"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
						self bootstrapPackage: 'Gofer-Core-lr.115' from: repositoryUrl ].
					Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
						gofer := goferClass new
							url: repositoryUrl;
							yourself.
						[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
						gofer load ]]
							on: Error
							do: [ :ex |
								error := ex.
								Transcript 
									cr; 
									show: 'failed ensureMetacello: ';
									show: ex description printString;
									show: '...retrying'.
								"try again"
								ex return: nil ]) ~~ nil
					ifTrue: [
						"load 'default' group of Metacello"
						(Smalltalk at: #ConfigurationOfMetacello) perform: #load.
						^self ]].
		"shouldn't get here unless the load failed ... throw an error"
		self error: 'retry with alternate repository failed: ', error description printString ]
]

{ #category : #'metacello tool support' }
ConfigurationOfPhaROS class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfPhaROS class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfPhaROS class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #loading }
ConfigurationOfPhaROS class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #loading }
ConfigurationOfPhaROS class >> loadBleedingEdgeWithPeripherics [
	(self project version: #bleedingEdge) load.
]

{ #category : #'metacello tool support' }
ConfigurationOfPhaROS class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfPhaROS class >> project [

	^self new project
]

{ #category : #'unloading metacello' }
ConfigurationOfPhaROS class >> testCategoriesForJenkins [
	self flag: #weMustInstallARosInJenkinsServer. 
	^ #( 'RoSt-Kernel-Tcp-Test' 'RoSt-Kernel-Types-Test').
]

{ #category : #'unloading metacello' }
ConfigurationOfPhaROS class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfPhaROS >> baseline10: spec [
	<version:'1.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://car.mines-douai.fr/squeaksource/PhaROS'.
			spec project: 'XMLRPC' with: [
				spec 
					className: 'ConfigurationOfXMLRPC';
					file: 'ConfigurationOfXMLRPC' ;
					repository: 'http://ss3.gemstone.com/ss/XMLRPC'; 
					versionString: #bleedingEdge;
					loads: #('XMLRPC-Client-Core' 'XMLRPC-Client-Tests' 'XMLRPC-Server-Core' 'XMLRPC-Server-Tests')
			].
			spec project: 'PaulLePoulpe' with: [ 
				spec 	className: 'ConfigurationOfPaulLePoulpe'; 
						loads: #('default' );
						file: 'ConfigurationOfPaulLePoulpe';
						repository: 'http://ss3.gemstone.com/ss/PaulLePoulpe'. 
			]	.
			spec project: 'OSProcess' with: [
				spec 
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess' ;
					repository: 'http://www.squeaksource.com/MetacelloRepository'; 
					versionString: #stable.
			].
			spec project: 'CommonTraits' with: [
				spec 
					className: 'ConfigurationOfCommonTraits';
					file: 'ConfigurationOfCommonTraits' ;
					versionString: #bleedingEdge;
					repository: 'http://car.mines-douai.fr/squeaksource/PhaROS'.
			].
		      spec package: 'StarGazer' with: [
				spec repository: 'http://car.mines-douai.fr/squeaksource/Peripherics'.
			].
			spec package: 'TaskIT' with: [
				spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
		
			spec package: 'PhaROS' with: [
				spec requires: #('XMLRPC' 'CommonTraits' 'PaulLePoulpe' 'OSProcess' 'TaskIT').
			].
		      spec group: 'PhaROS-Peripherics' with: #( 'PhaROS' 'StarGazer').
			
			spec group: 'default'  with: #( 'PhaROS' ).
	].


]

{ #category : #versions }
ConfigurationOfPhaROS >> pharosRoboshop1: spec [
	"symbolic version name used in the RoboShop deliverable 1"
	<symbolicVersion: #pharosRoboshop1>
	spec for: #'pharo1.4.x' version: '1.0-Beta1'.
	spec for: #common version: #notDefined.
]

{ #category : #versions }
ConfigurationOfPhaROS >> pharosRoboshop2: spec [
	"symbolic version name used in the RoboShop deliverable 1"
	<symbolicVersion: #pharosRoboshop2>
	spec for: #'pharo1.4.x' version: '1.0-Beta2'.
	spec for: #common version: #notDefined.
]

{ #category : #versions }
ConfigurationOfPhaROS >> pharosStage1: spec [
	"symbolic version name used in the RoboShop deliverable 1"
	<symbolicVersion: #pharosStage1>
	spec for: #'pharo1.4.x' version: '1.0-Beta1'.
	spec for: #common version: #notDefined.
]

{ #category : #accessing }
ConfigurationOfPhaROS >> project [

	^ project ifNil: [
		 | constructor |
		
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project 
	].


]

{ #category : #versions }
ConfigurationOfPhaROS >> version100Beta11: spec [ 
	<version: '1.1-Beta1' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '09/07/2013 12:00'.
		spec 
			project: 'XMLRPC' with: '1.0-Beta6';
			 project: 'PaulLePoulpe' with: '1.0.1'.
		spec
			package: 'PhaROS' with: 'PhaROS-SantiagoBragagnolo.131'
		].


]

{ #category : #versions }
ConfigurationOfPhaROS >> version100Beta1: spec [ 
	<version: '1.0-Beta1' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'LucFabresse'.
		spec timestamp: '19/04/2013 16:00'.
		spec 
			project: 'XMLRPC' with: '1.0-Beta6';
			 project: 'PaulLePoulpe' with: '1.0.1'.
		spec
			package: 'PhaROS' with: 'PhaROS-NouryBouraqadi.86'
		].


]

{ #category : #versions }
ConfigurationOfPhaROS >> version100Beta2: spec [ 
	<version: '1.0-Beta2' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'JannikLaval'.
		spec timestamp: '12/07/2013 12:00'.
		spec 
			project: 'XMLRPC' with: '1.0-Beta6';
			 project: 'PaulLePoulpe' with: '1.0.1'.
		spec
			package: 'PhaROS' with: 'PhaROS-NouryBouraqadi.147'
		].


]
