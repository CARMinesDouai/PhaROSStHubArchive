"
ConfigurationOfPhaROSCommander loadBleedingEdge
"
Class {
	#name : #ConfigurationOfPhaROSCommander,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfPhaROSCommander
}

{ #category : #private }
ConfigurationOfPhaROSCommander class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfPhaROSCommander class >> ensureMetacello [
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
ConfigurationOfPhaROSCommander class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfPhaROSCommander class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #load }
ConfigurationOfPhaROSCommander class >> load: aVersion [
	(self project version: aVersion asSymbol) load.
]

{ #category : #load }
ConfigurationOfPhaROSCommander class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
]

{ #category : #load }
ConfigurationOfPhaROSCommander class >> loadBleedingEdgeForTest [
	(self project version: #bleedingEdge) load:'core+test'.
]

{ #category : #load }
ConfigurationOfPhaROSCommander class >> loadStable [
	(self project version: #stable) load.
]

{ #category : #'metacello tool support' }
ConfigurationOfPhaROSCommander class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfPhaROSCommander class >> project [

	^self new project
]

{ #category : #'unload metacello' }
ConfigurationOfPhaROSCommander class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfPhaROSCommander >> baseline10: spec [
	<version:'1.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			
			spec project: 'ROSCatkinDeployer' with: [
				spec 
					className: 'ConfigurationOfROSCatkinDeployer';
					file: 'ConfigurationOfROSCatkinDeployer' ;
					repository: 'http://smalltalkhub.com/mc/CAR/PhaROS/main'.
			].
		
			spec package: 'PhaROSCommander' with: [ spec requires: #('ROSCatkinDeployer' ) ].
			spec package: 'PhaROSCommanderTests' with: [ spec requires: #('PhaROSCommander' ) ].
			spec group: 'default'  with: #( 'PhaROSCommander' ).
			spec group: 'core'  with: #( 'PhaROSCommander' ).
			spec group: 'core+tests'  with: #( 'PhaROSCommanderTests' ).
			
	].


]

{ #category : #accessing }
ConfigurationOfPhaROSCommander >> project [

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
ConfigurationOfPhaROSCommander >> stable: spec [
	<symbolicVersion: #'stable'>
	spec for: #'common' version: '1.0.4'
	
]

{ #category : #versions }
ConfigurationOfPhaROSCommander >> version101: spec [ 
	<version: '1.0.1' imports: #('1.0-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v0.1 - after moving most of PhaROS to sthub'.
		spec author: 'LucFabresse'.
		spec timestamp: '18/06/2014 16:00'.
		spec project: 'ROSCatkinDeployer' with: '1.0-baseline'. "bleeding..."
		spec package: 'PhaROSCommander' with: 'PhaROSCommander-LucFabresse.63'.
		spec package: 'PhaROSCommanderTests' with: 'PhaROSCommanderTest-SantiagoBragangolo.1'.
	]
]

{ #category : #versions }
ConfigurationOfPhaROSCommander >> version102: spec [ 
	<version: '1.0.2' imports: #('1.0-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v0.1 - after moving most of PhaROS to sthub'.
		spec author: 'LucFabresse'.
		spec timestamp: '19/06/2014 16:00'.
		spec project: 'ROSCatkinDeployer' with: '1.0-baseline'. "bleeding..."
		spec package: 'PhaROSCommander' with: 'PhaROSCommander-PabloEstefo.65'.
		spec package: 'PhaROSCommanderTests' with: 'PhaROSCommanderTest-SantiagoBragangolo.1'.
	]
]

{ #category : #versions }
ConfigurationOfPhaROSCommander >> version103: spec [ 
	<version: '1.0.3' imports: #('1.0-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v0.1 - after moving most of PhaROS to sthub'.
		spec author: 'LucFabresse'.
		spec timestamp: '23/10/2014 21:40'.
		spec project: 'ROSCatkinDeployer' with: '1.0-baseline'. "bleeding..."
		spec package: 'PhaROSCommander' with: 'PhaROSCommander-NouryBouraqadi.67'.
		spec package: 'PhaROSCommanderTests' with: 'PhaROSCommanderTest-SantiagoBragangolo.1'.
	]
]

{ #category : #versions }
ConfigurationOfPhaROSCommander >> version104: spec [ 
	<version: '1.0.4' imports: #('1.0-baseline') >
	
	spec for: #common do: [ 
		spec blessing: #'v0.1 - after moving most of PhaROS to sthub'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '12/11/2014 12:07'.
		spec project: 'ROSCatkinDeployer' with: '1.0-baseline'. "bleeding..."
		spec package: 'PhaROSCommander' with: 'PhaROSCommander-NouryBouraqadi.70'.
		spec package: 'PhaROSCommanderTests' with: 'PhaROSCommanderTest-SantiagoBragangolo.1'.
	]
]
