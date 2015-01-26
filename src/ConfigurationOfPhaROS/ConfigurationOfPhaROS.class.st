"
ConfigurationOfPhaROS loadStable.

ConfigurationOfPhaROS loadBleedingEdge.
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
ConfigurationOfPhaROS class >> load: aPackage [
	(self project version: #stable) load: aPackage.
]

{ #category : #loading }
ConfigurationOfPhaROS class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #loading }
ConfigurationOfPhaROS class >> loadBleedingEdgeForTest [
	(self project version: #bleedingEdge) load:'default+tests'.
]

{ #category : #'loading from PhaROSCommander' }
ConfigurationOfPhaROS class >> loadBleedingEdgeFromCommander [
	^ (self project version: #bleedingEdge) load: 'all'
]

{ #category : #loading }
ConfigurationOfPhaROS class >> loadESUG [
	(self project version: #'1.0-Beta3') load.
]

{ #category : #loading }
ConfigurationOfPhaROS class >> loadStable [
	(self project version: #stable) load.
]

{ #category : #'loading from PhaROSCommander' }
ConfigurationOfPhaROS class >> loadStableFromCommander [
	^ (self project version: '1.3.1') load: 'all'

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
	^ #( 
		'PhaROSTest' 'PhaROSTestROS-Kernel' 
	 ).
]

{ #category : #'unloading metacello' }
ConfigurationOfPhaROS class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfPhaROS >> baseline10: spec [
	<version:'1.0-baseline'>
	"BASE LINE WITHOUT KOM"
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
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
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			].
		    
			spec package: 'TaskIT' with: [
				spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
				
			spec package: 'PhaROS' with: [
				spec requires: #('XMLRPC' 'CommonTraits' 'PaulLePoulpe' 'OSProcess' 'TaskIT' ).
			].
		   
			spec group: 'default'  with: #( 'PhaROS' ).
	].


]

{ #category : #baselines }
ConfigurationOfPhaROS >> baseline10b: spec [

	<version:'1.0b-baseline'>
	" BASELINE WITH KOM SERVER "
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
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
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			].
		    
			spec package: 'TaskIT' with: [
				spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
		
			spec project: 'Kom' with: [
					spec	className: 'ConfigurationOfKomHttpServer';
							versionString: '1.0.9';
							file: 'ConfigurationOfKomHttpServer';
							repository: 'http://www.squeaksource.com/MetacelloRepository' 
			].
		
		
			spec package: 'PhaROS' with: [
				spec requires: #('XMLRPC' 'CommonTraits' 'PaulLePoulpe' 'OSProcess' 'TaskIT' 'Kom').
			].
		   
			spec group: 'default'  with: #( 'PhaROS' ).
	].


]

{ #category : #baselines }
ConfigurationOfPhaROS >> baseline11: spec [
	<version:'1.1-baseline'>
	"BASELINE WITH ConfigurationOfTaskIT - it requieres Ghost proxies "
	


	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
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
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			].
		
			spec project: 'TaskIT' with: [
				spec 
					className: 'ConfigurationOfTaskIT';
					file: 'ConfigurationOfTaskIT' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
		
		
		
		
			"Testing"
			spec package: 'PhaROSTest' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSTestROS' with: [ spec requires: #('PhaROS')].
			
			"Cool tools"
			spec package: 'PhaROSControllers' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSExperiments' with: [ spec requires: #('PhaROS')].
			
			"Infrastructure: deployment and generation of code"
			
			
			spec package: 'PhaROSInfrastructure' with: [ spec requires: #('PhaROS')].
			
			
			
			spec package: 'PhaROSDeploymentDirectory'.
			
			
			
			"Some already implemented nodelets"
			
			spec package: 'PhaROSNodeletsAction' 	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsLocalizer'	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsMerger' 	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsMoveBase' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsOdometry' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsPosition'	 with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsRPC' 		with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsTF' 		with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsTurtlebot' with: [ spec requires: #('PhaROS')].
			
			spec package: 'PhaROSNodeletsTurtlesim' with: [ spec requires: #('PhaROS')].
			
			spec package: 'PhaROSNodeletsPoseTracker' with: [
				spec requires: #('PhaROS' 'PhaROSNodeletsLocalizer')	
			].
			
			"Some already implemented Packages"
			
			
			spec package: 'PhaROSPackageEsug' with: [
				spec requires:#('PhaROS' 'PhaROSControllers' 'PhaROSNodeletsTurtlesim' 'PhaROSNodeletsTF' )	
			].
		
			spec package: 'ChatterPackage' with: [
				spec requires:#('PhaROS' 'PhaROSControllers'  )	
			].
			
			spec package: 'DonatelloPackage' with: [
				spec requires:#('PhaROS' 'PhaROSControllers' 'PhaROSNodeletsTF'  )	
			].
		
			"PhaROS Configuration"	
			
			spec package: 'PhaROS' with: [
				spec requires: #('XMLRPC' 'CommonTraits' 'PaulLePoulpe' 'OSProcess' 'TaskIT').
			].
		
		
		
			spec 	group: 'default' with: #( 'PhaROS' 'PhaROSControllers' 'PhaROSInfrastructure'  );
	 				group: 'default+tests' with: #( 'PhaROS' 'PhaROSTest' 'PhaROSTestROS' 'PhaROSControllers' 'PhaROSInfrastructure' );
					group: 'core' with: #('PhaROS' );
					group: 'core+tests' with: #('PhaROS' 'PhaROSTest' 'PhaROSTestROS' );
				
					group: 'nodelets-ros-controllers' with: #( 'PhaROSNodeletsAction' 'PhaROSNodeletsMoveBase' 'PhaROSNodeletsTF' 'PhaROSNodeletsPosition' 'PhaROSNodeletsTurtlesim' 'PhaROSNodeletsTurtlebot');
					group: 'nodelets-behavior' with: #( 'PhaROSNodeletsLocalizer' 'PhaROSNodeletsMerger' 'PhaROSNodeletsOdometry' 'PhaROSNodeletsPoseTracker' 'PhaROSNodeletsRPC');
					group: 'nodelets' with: #('nodelets-ros-controllers' 'nodelets-behavior');
					group: 'all' with: #('default+tests' 'nodelets').
		
			
			spec group: 'full-archetype' with: #('all' ).
			spec group: 'basic-archetype' with: #('PhaROS' 'PhaROSControllers' 'PhaROSNodeletsTurtlesim' 'PhaROSNodeletsTF' ).
			spec group: 'core-archetype' with: #('PhaROS' ).
		
	
	].
	
		
	
]

{ #category : #baselines }
ConfigurationOfPhaROS >> baseline12: spec [
	<version:'1.2-baseline'>
	
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			
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
						repository: 'http://ss3.gemstone.com/ss/PaulLePoulpe';
						versionString: #bleedingEdge.
			].
		
			spec project: 'OSProcess' with: [
				spec 
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess' ;
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main'; 
					versionString: #stable.
			].
			
			spec package: 'CommonTraits' with: [
				spec repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main'
			].
			spec package: 'Equals' with: [
				spec repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main'
			].
	
			spec project: 'TaskITProject' with: [
				spec 
					className: 'ConfigurationOfTaskIT';
					file: 'ConfigurationOfTaskIT' ;
					repository: 'http://smalltalkhub.com/mc/CAR/TaskIT/main';
					versionString:  #stable
			].
		
			"Testing"
			spec package: 'PhaROSTest' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSTestROS' with: [ spec requires: #('PhaROS')].
			
			"Cool tools"
			spec package: 'PhaROSControllers' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSExperiments' with: [ spec requires: #('PhaROS')].
			
			"Infrastructure: deployment and generation of code"
			spec package: 'PhaROSInfrastructure' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSDeploymentDirectory'.
		
			"Some already implemented nodelets"	
			spec package: 'PhaROSNodeletsAction' 	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsLocalizer'	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsMerger' 	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsMoveBase' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsOdometry' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsPosition'	 with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsRPC' 		with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsTF' 		with: [ spec requires: #('PhaROS')].
			
			spec package: 'PhaROSNodeletsTurtlesim' with: [ spec requires: #('PhaROS')].
			
			spec package: 'PhaROSNodeletsPoseTracker' with: [
				spec requires: #('PhaROS' 'PhaROSNodeletsLocalizer')	
			].
			
			"PhaROS Configuration"
			spec package: 'PhaROS' with: [
				spec requires: #('XMLRPC' 'CommonTraits' 'Equals' 'PaulLePoulpe' 'OSProcess' 'TaskITProject').
			].
	
			"PhaROSInfrastructure is deprecated? but ROSLaunch still used?"
			spec 
				group: 'default' with: #('PhaROS'  'PhaROSControllers' 'PhaROSInfrastructure' 'PhaROSNodeletsAction' 'PhaROSNodeletsMoveBase' 'PhaROSNodeletsTF' 'PhaROSNodeletsPosition'   'PhaROSNodeletsLocalizer' 'PhaROSNodeletsMerger' 'PhaROSNodeletsOdometry' 'PhaROSNodeletsPoseTracker' 'PhaROSNodeletsRPC' );
				
				group: 'examples' with: #( 'PhaROSNodeletsTurtlesim'  );
					
				group: 'tests' with: #('PhaROSTest'  'PhaROSTestROS').
				
			spec group: 'basic-archetype' with: #( 'default' 'examples' 'tests').
			
			
	].
	
		
	
]

{ #category : #baselines }
ConfigurationOfPhaROS >> baseline13: spec [
	<version:'1.3-baseline'>
	
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			
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
						repository: 'http://ss3.gemstone.com/ss/PaulLePoulpe';
						versionString: #bleedingEdge.
			].
		
			spec project: 'OSProcess' with: [
				spec 
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess' ;
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main'; 
					versionString: #stable.
			].
			
			spec package: 'CommonTraits' with: [
				spec repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main'
			].
			spec package: 'Equals' with: [
				spec repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main'
			].
	
			spec project: 'TaskITProject' with: [
				spec 
					className: 'ConfigurationOfTaskIT';
					file: 'ConfigurationOfTaskIT' ;
					repository: 'http://smalltalkhub.com/mc/CAR/TaskIT/main';
					versionString:  #stable
			].
		
			"Testing"
			spec package: 'PhaROSTest' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSTestROS' with: [ spec requires: #('PhaROS')].
			
			spec package: 'PhaROSControllers' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSExperiments' with: [ spec requires: #('PhaROS')].
			
			"Infrastructure: deployment and generation of code"
			spec package: 'PhaROSInfrastructure' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSDeploymentDirectory'.
		
			"Some already implemented nodelets"	
			spec package: 'PhaROSNodeletsAction' 	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsLocalizer'	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsMerger' 	with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsMoveBase' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsOdometry' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsPosition'	 with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsRPC' 		with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROSNodeletsTF' 		with: [ spec requires: #('PhaROS')].
			
			"examples"
			spec package: 'PhaROSNodeletsTurtlesim' with: [ spec requires: #('PhaROS')].
			spec package: 'PhaROS-PackageExample' with: [ spec requires: #('PhaROS')].
			
			"doc"
			spec package: 'PhaROS-Doc'.
			
			spec package: 'PhaROSNodeletsPoseTracker' with: [
				spec requires: #('PhaROS' 'PhaROSNodeletsLocalizer')	
			].
			
			"PhaROS Configuration"
			spec package: 'PhaROS' with: [
				spec requires: #('XMLRPC' 'CommonTraits' 'Equals' 'PaulLePoulpe' 'OSProcess' 'TaskITProject').
			].
	
			"groups"
			spec 
				group: 'default' with: #('PhaROS'  'PhaROSControllers' 'PhaROSInfrastructure' 'PhaROSNodeletsAction' 'PhaROSNodeletsMoveBase' 'PhaROSNodeletsTF' 'PhaROSNodeletsPosition'   'PhaROSNodeletsLocalizer' 'PhaROSNodeletsMerger' 'PhaROSNodeletsOdometry' 'PhaROSNodeletsPoseTracker' 'PhaROSNodeletsRPC' );
				
				group: 'examples' with: #( 'PhaROS-PackageExample' 'PhaROSNodeletsTurtlesim' 'PhaROS-Doc' );
					
				group: 'tests' with: #('PhaROSTest'  'PhaROSTestROS') ;
				
				"this group is currently used by the pharos commander"
				group: 'all' with: #( 'default' 'examples' 'tests').
	].
	
		
	
]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> pharosRoboshop1: spec [
	"symbolic version name used in the RoboShop deliverable 1"
	<symbolicVersion: #pharosRoboshop1>
	spec for: #'pharo1.4.x' version: '1.0-Beta1'.
	spec for: #common version: #notDefined.
]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> pharosRoboshop2: spec [
	"symbolic version name used in the RoboShop deliverable 1"
	<symbolicVersion: #pharosRoboshop2>
	spec for: #'pharo1.4.x' version: '1.0-Beta2'.
	spec for: #common version: #notDefined.
]

{ #category : #'old fixed versions' }
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

{ #category : #'symbolic versions' }
ConfigurationOfPhaROS >> stable: spec [
	<symbolicVersion: #'stable'>

]

{ #category : #'old fixed versions' }
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
			package: 'PhaROS' with: 'PhaROS-SantiagoBragagnolo.131'.
spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'			
		].


]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> version100Beta1: spec [ 
	<version: '1.0-Beta1' imports: #('1.0b-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'LucFabresse'.
		spec timestamp: '19/04/2013 16:00'.
		spec 
			project: 'XMLRPC' with: '1.0-Beta6';
			 project: 'PaulLePoulpe' with: '1.0.1'.
		spec
			package: 'PhaROS' with: 'PhaROS-NouryBouraqadi.86'.
			spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'.
		].


]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> version100Beta2: spec [ 
	<version: '1.0-Beta2' imports: #('1.0b-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'JannikLaval'.
		spec timestamp: '12/07/2013 12:00'.
		spec 
			project: 'XMLRPC' with: '1.0-Beta6';
			 project: 'PaulLePoulpe' with: '1.0.1'.
		spec
			package: 'PhaROS' with: 'PhaROS-NouryBouraqadi.147'.
			spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'.
		].


]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> version100Beta3: spec [ 
	<version: '1.0-Beta3' imports: #('1.0b-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '12/09/2013 12:00'.
		spec 
			project: 'XMLRPC' with: '1.0-Beta6';
			 project: 'PaulLePoulpe' with: '1.0.1'.
		spec
			package: 'PhaROS' with: 'PhaROS-SantiagoBragagnolo.202'.
			spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'
		].


]

{ #category : #versions }
ConfigurationOfPhaROS >> version121: spec [ 
	<version: '1.2.1' imports: #('1.2-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v1.2.1 - after moving most of PhaROS to sthub'.
		spec author: 'LucFabresse'.
		spec timestamp: '18/06/2014 16:00'.
		spec project: 'XMLRPC' with: '1.01'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-PabloEstefo.709'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'
	]
]

{ #category : #versions }
ConfigurationOfPhaROS >> version122: spec [ 
	<version: '1.2.2' imports: #('1.2-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v1.2.2 - adapt to new taskit'.
		spec author: 'LucFabresse'.
		spec timestamp: '1/07/2014 16:00'.
		spec project: 'XMLRPC' with: '1.01'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-PabloEstefo.709'.
		spec project: 'TaskIT' with: '2.1' 
	]
]

{ #category : #versions }
ConfigurationOfPhaROS >> version123: spec [ 
	<version: '1.2.3' imports: #('1.2-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v1.2.3'.
		spec author: 'LucFabresse'.
		spec timestamp: '24/01/2015 16:00'.
		spec project: 'XMLRPC' with: '1.01'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-pharos.730'.
		spec project: 'TaskIT' with: '2.1' 
	]
]

{ #category : #versions }
ConfigurationOfPhaROS >> version131: spec [ 
	<version: '1.3.1' imports: #('1.3-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v1.3.1'.
		spec author: 'LucFabresse'.
		spec timestamp: '26/01/2015 16:00'.
		spec project: 'XMLRPC' with: '1.01'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-pharos.742'.
		spec project: 'TaskIT' with: '2.2'
	]
]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> versionDemo2: spec [ 
	<version: 'Demo-2' imports: #('1.0b-baseline') >
	
	spec for: #common do: [
		spec blessing: #demo.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '17/10/2013 15:15'.
		spec project: 'XMLRPC' with: '1.0-Beta6'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-SantiagoBragagnolo.267'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'
	].


]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> versionDemo: spec [ 
	<version: 'Demo' imports: #('1.0b-baseline') >
	
	spec for: #common do: [
		spec blessing: #demo.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '17/10/2013 15:15'.
		spec project: 'XMLRPC' with: '1.0-Beta6'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-SantiagoBragagnolo.demo.sg.kp'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'
	].


]

{ #category : #'old fixed versions' }
ConfigurationOfPhaROS >> versionDemoRobulab: spec [ 
	<version: 'DemoRobulab' imports: #('1.0b-baseline') >
	
	spec for: #common do: [
		spec blessing: #demo.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '17/10/2013 15:15'.
		spec project: 'XMLRPC' with: '1.0-Beta6'.
		spec project: 'PaulLePoulpe' with: '1.0.1'.
		spec package: 'PhaROS' with: 'PhaROS-SantiagoBragagnolo.666'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'
	].


]
