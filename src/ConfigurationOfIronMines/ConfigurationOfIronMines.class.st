Class {
	#name : #ConfigurationOfIronMines,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfIronMines
}

{ #category : #private }
ConfigurationOfIronMines class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfIronMines class >> ensureMetacello [
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
ConfigurationOfIronMines class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfIronMines class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfIronMines class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #loading }
ConfigurationOfIronMines class >> load: aPackage [
	(self project version: #bleedingEdge) load: aPackage.
]

{ #category : #loading }
ConfigurationOfIronMines class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #'metacello tool support' }
ConfigurationOfIronMines class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfIronMines class >> project [

	^self new project
]

{ #category : #'unloading metacello' }
ConfigurationOfIronMines class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfIronMines >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/CAR/Ironmines/main'.
		spec project: 'PhaROS' with: [
				spec
					className: #ConfigurationOfPhaROS;
					versionString: #'bleedingEdge';
					loads: #('PhaROS' 'PhaROSControllers' 'PhaROSNodeletsTF');
					repository: 'http://car.mines-douai.fr/squeaksource/PhaROS' ].
		spec 
			package: 'IronMines' with: [
				spec requires: #('PhaROS' ). ];
			package: 'IronMinesTest' with: [
				spec requires: #('IronMines' ). ].
		spec 
			group: 'default' with: #('IronMines' 'IronMinesTest' );
			group: 'core' with: #('IronMines' );
			group: 'core+test' with: #('IronMines' 'IronMinesTest' ). ].

]

{ #category : #'symbolic versions' }
ConfigurationOfIronMines >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfIronMines >> project [

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
ConfigurationOfIronMines >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0'.

]

{ #category : #versions }
ConfigurationOfIronMines >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0 used for competition 2014'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '11/27/2014 11:53'.
		spec project: 'PhaROS' with: '1.1-Beta1'.
		spec 
			package: 'IronMines' with: 'IronMines-pharos.185';
			package: 'IronMinesTest' with: 'IronMinesTest-pharos.13'. ].

]
