Class {
	#name : #ConfigurationOfPeripherics,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfPeripherics
}

{ #category : #private }
ConfigurationOfPeripherics class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfPeripherics class >> ensureMetacello [
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
ConfigurationOfPeripherics class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfPeripherics class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfPeripherics class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #loading }
ConfigurationOfPeripherics class >> load: aPackage [
	(self project version: #bleedingEdge) load: aPackage.
]

{ #category : #loading }
ConfigurationOfPeripherics class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #'metacello tool support' }
ConfigurationOfPeripherics class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfPeripherics class >> project [

	^self new project
]

{ #category : #loading }
ConfigurationOfPeripherics class >> stable [
	 ^  (self project version: #stable) load
]

{ #category : #'unloading metacello' }
ConfigurationOfPeripherics class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfPeripherics >> baseline10: spec [
	<version:'1.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main'.
			
			spec project: 'TaskIT' with: [
				spec 
					className: 'ConfigurationOfTaskIT';
					file: 'ConfigurationOfTaskIT' ;
					versionString: #bleedingEdge;
					repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			].
		
			spec project: 'PhaROS' with: [
				spec 
					className: 'ConfigurationOfPhaROS';
					file: 'ConfigurationOfPhaROS' ;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'; 
					versionString: #bleedingEdge;
					loads: #( 'PhaROS' 'PhaROSControllers' 'PhaROSInfrastructure' 'PhaROSNodeletsTF' 'PhaROSNodeletsMerger').
			].
		
			spec package: 'StarGazer' with: [
				spec requires: #('TaskIT').
			].
			spec package: 'StarGazerTest' with: [
				spec requires: #('StarGazer').
			].
		
			spec package: 'StarGazerROS' with: [
				spec requires: #('StarGazer' 'PhaROS').
			].
			spec package: 'PeriphericsDirectory'.
			
			
			spec group: 'default'  with: #( 'TaskIT' ).
	].


]

{ #category : #baselines }
ConfigurationOfPeripherics >> baseline11: spec [
	<version:'1.1-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main'.
			
			spec project: 'TaskIT' with: [
				spec 
					className: 'ConfigurationOfTaskIT';
					file: 'ConfigurationOfTaskIT' ;
					repository: 'http://smalltalkhub.com/mc/CAR/TaskIT/main';
					versionString:  #stable
			].
		
			spec project: 'PhaROS' with: [
				spec 
					className: 'ConfigurationOfPhaROS';
					file: 'ConfigurationOfPhaROS' ;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'; 
					versionString: #bleedingEdge;
					loads: #( 'PhaROS' 'PhaROSInfrastructure' 'PhaROSNodeletsTF' 'PhaROSNodeletsMerger').
			].
		
			spec package: 'StarGazer' with: [
				spec requires: #('TaskIT').
			].
			spec package: 'StarGazerTest' with: [
				spec requires: #('StarGazer').
			].
		
			spec package: 'StarGazerROS' with: [
				spec requires: #('StarGazer' 'PhaROS').
			].
			spec package: 'PeriphericsDirectory'.
			
			
			spec group: 'default'  with: #( 'TaskIT' ).
	].


]

{ #category : #accessing }
ConfigurationOfPeripherics >> project [

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
ConfigurationOfPeripherics >> stable: spec [
	<symbolicVersion: #'stable'>
	spec for: #'pharo1.4.x' version: '0.1'.
	spec for: #'pharo2.x' version: '0.1'.
	
]
