"
ConfigurationOfPureROS loadBleedingEdge

"
Class {
	#name : #ConfigurationOfPureROS,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfPureROS
}

{ #category : #private }
ConfigurationOfPureROS class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfPureROS class >> configurationOfLog [
	<logConfiguration>
	^ [
	     :builder |
	     builder forClass: LoggedExampleCustomized 
			     useLevel:#info 
			     showingLogAs: ('%tag #%class >> %selector [%log]' asPatternFormatter) 
			     into: LogStdoutWriter instance.
	].

]

{ #category : #private }
ConfigurationOfPureROS class >> ensureMetacello [
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
ConfigurationOfPureROS class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfPureROS class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfPureROS class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #load }
ConfigurationOfPureROS class >> load: aByteString [ 
	(self project version: #bleedingEdge) load: aByteString .
]

{ #category : #loading }
ConfigurationOfPureROS class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #loading }
ConfigurationOfPureROS class >> loadDemo [
	(self project version: #'1.0-Beta1') load.
]

{ #category : #'metacello tool support' }
ConfigurationOfPureROS class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfPureROS class >> project [

	^self new project
]

{ #category : #'unloading metacello' }
ConfigurationOfPureROS class >> testCategoriesForJenkins [
	self flag: #weMustInstallARosInJenkinsServer. 
	^ #( 'RoSt-Kernel-Tcp-Test' 'RoSt-Kernel-Types-Test').
]

{ #category : #'unloading metacello' }
ConfigurationOfPureROS class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfPureROS >> baseline10: spec [
	<version:'1.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/Robulab/main'.
			
			
			spec project: 'PhaROS' with: [
				spec 
					className: 'ConfigurationOfPhaROS';
					file: 'ConfigurationOfPhaROS' ;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'; 
					versionString: #bleedingEdge
			].
			
		      spec project: 'PureNG' with: [
				spec 
					className: 'ConfigurationOfPureNG';
					file: 'ConfigurationOfPureNG' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/CAR/Robulab/main'.
			].
			spec package: 'TaskIT' with: [
				spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
		     spec package: 'StarGazer' with: [
				spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main'.
			].
		
			spec package: 'PureROS' with: [
				spec requires: #('PhaROS' 'PureNG' 'TaskIT' 'StarGazer' ).
			].
		
			spec package: 'PureROSExperiments'.
			spec package: 'PureROSNodeletsMovement'.
			spec package: 'PureROSNodeletsKompai'.
			spec package: 'PureROSNodeletsCaire'.
			spec package: 'PureROSPackageKompai'. 
			spec package: 'PureROSPackageRobulab'. 
			spec package: 'PureROSPackageCaire'. 
			
			
	].


]

{ #category : #baselines }
ConfigurationOfPureROS >> baseline11: spec [
	<version:'1.1-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/Robulab/main'.
			
			
			spec project: 'PhaROS' with: [
				spec 
					className: 'ConfigurationOfPhaROS';
					file: 'ConfigurationOfPhaROS' ;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'; 
					versionString: #bleedingEdge;
					loads: #( 'PhaROS' 'PhaROSControllers' 'PhaROSInfrastructure' 'PhaROSNodeletsTF' 'PhaROSNodeletsPosition' 'PhaROSNodeletsLocalizer' 'PhaROSNodeletsMoveBase' 'PhaROSNodeletsPoseTracker' 'PhaROSNodeletsOdometry' 'PhaROSNodeletsRPC' 'PhaROSNodeletsMerger').
			].
			
		      spec project: 'PureNG' with: [
				spec 
					className: 'ConfigurationOfPureNG';
					file: 'ConfigurationOfPureNG' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/CAR/Robulab/main'.
			].
		
			spec project: 'TaskIT' with: [
				spec 
					className: 'ConfigurationOfTaskIT';
					file: 'ConfigurationOfTaskIT' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
		
			spec project: 'StarGazer' with: [
				spec 
					className: 'ConfigurationOfPeripherics';
					file: 'ConfigurationOfPeripherics' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main';
					loads:#('StarGazerROS').
			].
		   
			spec package: 'PureROS' with: [
				spec requires: #('PhaROS' 'PureNG' 'TaskIT' ).
			].
		
			spec package: 'PureROSExperiments'.
			
			spec package: 'PureROSNodeletsMovement'.
			spec package: 'PureROSNodeletsKompai'.
			spec package: 'PureROSNodeletsCaire'.
			
			
			spec package: 'PureROSPackageKompai' with:[
				spec requires: #('PureROSNodeletsKompai' 'PureROS').	
			]. 
			spec package: 'PureROSPackageRobulab' with:[
				spec requires: #('PureROSNodeletsMovement' 'PureROS' 'StarGazer').	
			]. 
			spec package: 'PureROSPackageCaire' with:[
				spec requires: #('PureROSNodeletsCaire' 'PureROS').	
			]. 
			
			
	].


]

{ #category : #baselines }
ConfigurationOfPureROS >> baseline12: spec [
	<version:'1.2-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/Robulab/main'.
			
			
			spec project: 'PhaROS' with: [
				spec 
					className: 'ConfigurationOfPhaROS';
					file: 'ConfigurationOfPhaROS' ;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'; 
					versionString: #bleedingEdge;
					loads: #( 'default' 'tests' ).
			].
			
		      spec project: 'PureNG' with: [
				spec 
					className: 'ConfigurationOfPureNG';
					file: 'ConfigurationOfPureNG' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/CAR/Robulab/main'.
			].
		
			spec project: 'StarGazer' with: [
				spec 
					className: 'ConfigurationOfPeripherics';
					file: 'ConfigurationOfPeripherics' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main';
					loads:#('StarGazerROS').
			].
		   
			spec package: 'PureROS' with: [
				spec requires: #('PhaROS' 'PureNG').
			].
		
			spec package: 'PureROSExperiments'.
			
			spec package: 'PureROSNodeletsMovement'.
			spec package: 'PureROSNodeletsKompai'.
			spec package: 'PureROSNodeletsCaire'.
			
			
			spec package: 'PureROSPackageKompai' with:[
				spec requires: #('PureROSNodeletsKompai' 'PureROS').	
			]. 
			spec package: 'PureROSPackageRobulab' with:[
				spec requires: #('PureROSNodeletsMovement' 'PureROS' 'StarGazer').	
			]. 
			spec package: 'PureROSPackageCaire' with:[
				spec requires: #('PureROSNodeletsCaire' 'PureROS').	
			]. 
			
			spec group: 'core' with: #( 'PureROS' 'PureROSNodeletsKompai')
	].


]

{ #category : #accessing }
ConfigurationOfPureROS >> project [

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
ConfigurationOfPureROS >> version100Beta: spec [ 
	<version: '1.0-Beta1' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #alpha.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '12/09/2013 12:00'.
		spec 
			project: 'PhaROS' with: '1.0-Beta3';
			project: 'PureNG' with: '1.0-Beta';
			package: 'TaskIT' with: 'TaskIT-SantiagoBragagnolo.16';
			package: 'StarGazer' with: 'StarGazer-SantiagoBragagnolo.53'.

		].


]

{ #category : #demo }
ConfigurationOfPureROS >> version100Kompai: spec [ 
	<version: 'kompai' imports: #('1.0-baseline') >
	"Demo for kompai node"
	spec for: #common do: [
		spec blessing: #demo.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '26/02/2014 12:00'.
		spec 
			project: 'PhaROS' with: 'Demo';
			project: 'PureNG' with: '1.0-Beta';
			package: 'TaskIT' with: 'TaskIT-SantiagoBragagnolo.16';
			package: 'StarGazer' with: 'StarGazer-SantiagoBragagnolo.79';
			package: 'PureROS' with: 'PureROS-SantiagoBragagnolo.144'.

		].


]

{ #category : #demo }
ConfigurationOfPureROS >> version100Robulab: spec [ 
	<version: 'robulab' imports: #('1.0-baseline') >
	"Demo for kompai node"
	spec for: #common do: [
		spec blessing: #demo.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '26/02/2014 12:00'.
		spec 
			project: 'PhaROS' with: 'DemoRobulab';
			project: 'PureNG' with: '1.0-Beta';
			package: 'TaskIT' with: 'TaskIT-SantiagoBragagnolo.16';
			package: 'StarGazer' with: 'StarGazer-SantiagoBragagnolo.79';
			package: 'PureROS' with: 'PureROS-SantiagoBragagnolo.666'.

		].


]

{ #category : #demo }
ConfigurationOfPureROS >> version100Stargazer: spec [ 
	<version: 'robulab' imports: #('1.0-baseline') >
	"Demo for kompai node"
	spec for: #common do: [
		spec blessing: #demo.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '26/02/2014 12:00'.
		spec 
			project: 'PhaROS' with: 'Demo';
			project: 'PureNG' with: '1.0-Beta';
			package: 'TaskIT' with: 'TaskIT-SantiagoBragagnolo.16';
			package: 'StarGazer' with: 'StarGazer-SantiagoBragagnolo.demo';
			package: 'PureROS' with: 'PureROS-SantiagoBragagnolo.144'.

		].


]

{ #category : #'versions - demos' }
ConfigurationOfPureROS >> versionDemo2: spec [ 
	<version: 'Demo-2' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #demoCon.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '17/10/2013 15:15'.
		spec 
			project: 'PhaROS' with: 'Demo-2';
			project: 'PureNG' with: '1.0-Beta';
			package: 'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20';
			package: 'StarGazer' with: 'StarGazer-SantiagoBragagnolo.79'.

		].


]
