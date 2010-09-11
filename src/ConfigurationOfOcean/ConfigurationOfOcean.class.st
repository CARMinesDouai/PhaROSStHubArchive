Class {
	#name : #ConfigurationOfOcean,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfOcean
}

{ #category : #private }
ConfigurationOfOcean class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfOcean class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello tool support' }
ConfigurationOfOcean class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfOcean class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfOcean class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfOcean class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfOcean class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfOcean class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfOcean >> baseline01: spec [
	<version: '0.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.

		spec project: 'OSProcess' with: [
			spec 
				className: 'ConfigurationOfOSProcess' ;
				file: 'ConfigurationOfOSProcess';
				repository: 'http://www.squeaksource.com/OSProcess'
		].

		spec project: 'Alien' with: [
			spec 
				className: 'ConfigurationOfAlien' ; 
				loads: {'Core' . 'Tests' . 'LibC' . 'MacOSX'}; 
				file: 'ConfigurationOfAlien';
				repository: 'http://www.squeaksource.com/Alien'
		].

		spec package: 'Ocean' with: [
			spec requires: #('Alien' 'OSProcess' ).
			spec repository: 'http://www.squeaksource.com/Ocean'.
		].
	]
]

{ #category : #baselines }
ConfigurationOfOcean >> baseline02: spec [
	<version: '0.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.

		spec package: 'OSProcess' with: [
			spec repository: 'http://www.squeaksource.com/OSProcess'.
		].

		spec package: 'OSProcess-Tests' with: [
			spec repository: 'http://www.squeaksource.com/OSProcess';
				requires: 'OSProcess'
		].

		spec project: 'Alien' with: [
			spec 
				className: 'ConfigurationOfAlien' ; 
				loads: {'Core' . 'Tests' . 'LibC' . 'MacOSX'}; 
				file: 'ConfigurationOfAlien';
				repository: 'http://www.squeaksource.com/Alien'
		].

		spec package: 'Ocean' with: [
			spec requires: #('Alien' 'OSProcess' ).
			spec repository: 'http://www.squeaksource.com/Ocean'.
		].
	]
]

{ #category : #versions }
ConfigurationOfOcean >> pharo11: spec [
	<version: 'Pharo 1.1' imports: #('0.1-baseline')>
	
	^ self version02: spec
]

{ #category : #accessing }
ConfigurationOfOcean >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfOcean >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development; 
			project: 'OSProcess' with: '4.3.12'; 
			project: 'Alien' with:  'Pharo 1.1'
			"; package: 'Ocean' with: 'Ocean-NouryBouraqadi.18' " "do not fix a particular version to load the latest one"
	].
]

{ #category : #versions }
ConfigurationOfOcean >> version02: spec [
	<version: '0.2' imports: #('0.2-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  'Pharo 1.1';
			package: 'OSProcess' with: 'OSProcess-dtl.53'; "there is a bug introduced in 54"
			package: 'OSProcess-Tests' with: 'OSProcess-Tests-dtl.2'
			"; package: 'Ocean' with: 'Ocean-NouryBouraqadi.18' " "do not fix a particular version to load the latest one"
	] 
]