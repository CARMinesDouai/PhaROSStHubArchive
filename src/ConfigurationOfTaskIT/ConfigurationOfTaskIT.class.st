Class {
	#name : #ConfigurationOfTaskIT,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfTaskIT
}

{ #category : #private }
ConfigurationOfTaskIT class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfTaskIT class >> ensureMetacello [
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
ConfigurationOfTaskIT class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfTaskIT class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfTaskIT class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #loading }
ConfigurationOfTaskIT class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #'metacello tool support' }
ConfigurationOfTaskIT class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfTaskIT class >> project [

	^self new project
]

{ #category : #loading }
ConfigurationOfTaskIT class >> stable [
	 ^  (self project version: #stable) load
]

{ #category : #'unloading metacello' }
ConfigurationOfTaskIT class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfTaskIT >> baseline10: spec [
	<version:'1.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			spec project: 'Ghost' with: [
				spec 
					className: 'ConfigurationOfGhost';
					file: 'ConfigurationOfGhost' ;
					repository: 'http://ss3.gemstone.com/ss/Ghost'
			].
			spec package: 'TaskIT' with: [
				spec requires: #('Ghost').
			].
			spec group: 'default'  with: #( 'TaskIT' ).
	].


]

{ #category : #baselines }
ConfigurationOfTaskIT >> baselineStable01: spec [
	<version:'0.1-baseline-stable'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			spec group: 'default'  with: #( 'TaskIT' ).
			spec group: 'experimental'  with: #( 'TaskIT' ).
	].


]

{ #category : #accessing }
ConfigurationOfTaskIT >> project [

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
ConfigurationOfTaskIT >> stable: spec [
	<symbolicVersion: #'stable'>
	spec for: #'pharo1.4.x' version: '0.1'.
	spec for: #'pharo2.x' version: '0.1'.
	
]

{ #category : #versions }
ConfigurationOfTaskIT >> version01: spec [ 
	<version: '0.1' imports: #('0.1-baseline-stable') >
	
	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '15/11/2013 12:00'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.20'.
	].


]

{ #category : #versions }
ConfigurationOfTaskIT >> version10: spec [ 
	<version: '1.0' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #experimental.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '15/11/2013 12:00'.

	].


]
