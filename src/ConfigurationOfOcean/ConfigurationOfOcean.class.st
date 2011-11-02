"
""On 1.2""
(ConfigurationOfOcean project version: #development) load.

""1.3 --> automatically loads bleeding edge version""
(ConfigurationOfOcean project version: 'default') load: 'default tests'.

"
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

{ #category : #jenkins }
ConfigurationOfOcean class >> testsPackagesForContinutionIntegration [
	"Actually this method should be renamed to testsCategoriesForContinutionIntegration because Jenkins expects a list of pacakges, not categories."
	^ #('Ocean-KernelTests' 'Ocean-LibraryPluginTests')
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

{ #category : #baselines }
ConfigurationOfOcean >> baseline03: spec [
	<version: '0.3-baseline'>
	
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
				loads: {'All'}; 
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
ConfigurationOfOcean >> baseline04: spec [
	<version: '0.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.

	
		spec project: 'OSProcess' with: [
			spec 
				className: 'ConfigurationOfOSProcess' ; 
				loads: {'default'. 'Tests'}; 
				file: 'ConfigurationOfOSProcess';
				repository: 'http://www.squeaksource.com/MetacelloRepository';
				repository: 'http://www.squeaksource.com/OSProcess'
		].

		spec project: 'Alien' with: [
			spec 
				className: 'ConfigurationOfAlien' ; 
				loads: {'All'}; 
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
ConfigurationOfOcean >> baseline05: spec [
	<version: '0.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.

		spec project: 'Alien' with: [
			spec 
				className: 'ConfigurationOfAlien' ; 
				loads: {'All'}; 
				file: 'ConfigurationOfAlien';
				repository: 'http://www.squeaksource.com/Alien'
		].

		spec package: 'Ocean' with: [
			spec requires: #('Alien').
			spec repository: 'http://www.squeaksource.com/Ocean'.
		].
	
		spec group: 'default' with: #('Alien' 'Ocean').
		spec group: 'noalien' with: #('Ocean').
	]
]

{ #category : #baselines }
ConfigurationOfOcean >> baseline06: spec [
	<version: '0.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
	
		spec repository: 'http://www.squeaksource.com/Ocean'.
		
		spec project: 'Alien' with: [
			spec 
				className: 'ConfigurationOfAlien' ; 
				loads: {'All'}; 
				file: 'ConfigurationOfAlien';
				repository: 'http://www.squeaksource.com/Alien'
		].

		spec package: 'Ocean-Kernel'.
		spec package: 'Ocean-KernelTests' with: [ spec requires: 'Ocean-Kernel' ].
		spec package: 'Ocean-LibraryPlugin' with: [ spec requires: 'Ocean-Kernel' ].
		spec package: 'Ocean-LibraryPluginTests' with: [ spec requires: 'Ocean-LibraryPlugin'; requires: 'Ocean-KernelTests' ].
		spec package: 'Ocean-LibraryPosix' with: [ spec requires: 'Alien' ].
		spec package: 'Ocean-LibraryPosixTests' with: [ spec requires: 'Ocean-LibraryPosix'; requires: 'Ocean-KernelTests'].
		spec package: 'Ocean-Benchmarks' with: [ spec requires: 'Ocean-Kernel' ].
			
		spec group: 'default' with: #('Ocean-LibraryPlugin' 'Ocean-Benchmarks').
		spec group: 'default tests' with: #('default' 'Ocean-LibraryPluginTests').
		spec group: 'posix' with: #('Ocean-LibraryPosix').
		spec group: 'posix tests' with: #('posix' 'Ocean-LibraryPosixTests').
		spec group: 'full' with: #('default' 'posix').
		spec group: 'full tests' with: #('default tests' 'posix tests').
		
	]
]

{ #category : #baselines }
ConfigurationOfOcean >> baseline07: spec [
	<version: '0.7-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
	
		spec repository: 'http://www.squeaksource.com/Ocean'.
		
		spec project: 'Alien' with: [
			spec 
				className: 'ConfigurationOfAlien' ; 
				loads: {'All'}; 
				file: 'ConfigurationOfAlien';
				repository: 'http://www.squeaksource.com/Alien'
		].

		spec package: 'Ocean-Kernel'.
		spec package: 'Ocean-KernelTests' with: [ spec requires: 'Ocean-Kernel' ].
		spec package: 'Ocean-LibraryPlugin' with: [ spec requires: 'Ocean-Kernel' ].
		spec package: 'Ocean-LibraryPluginTests' with: [ spec requires: 'Ocean-LibraryPlugin'; requires: 'Ocean-KernelTests' ].
		spec package: 'Ocean-LibraryPosix' with: [ spec requires: 'Alien' ].
		spec package: 'Ocean-LibraryPosixTests' with: [ spec requires: 'Ocean-LibraryPosix'; requires: 'Ocean-KernelTests'].
		spec package: 'Ocean-Benchmarks' with: [ spec requires: 'Ocean-Kernel' ].
			
		spec group: 'default' with: #('Ocean-LibraryPlugin').
		spec group: 'default tests' with: #('default' 'Ocean-LibraryPluginTests').
		spec group: 'posix' with: #('Ocean-LibraryPosix').
		spec group: 'posix tests' with: #('posix' 'Ocean-LibraryPosixTests').
		spec group: 'full' with: #('default' 'posix').
		spec group: 'full tests' with: #('default tests' 'posix tests').
		
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfOcean >> default: spec [
	<version: #'default' imports: #('0.7-baseline')>
	
	
]

{ #category : #'symbolic versions' }
ConfigurationOfOcean >> development:   spec [
	<symbolicVersion: #'development'>

	spec for: #'Pharo1.1.x' version: '0.2'.
	spec for: #'pharo1.2.x' version: '0.6'.
	spec for: #'pharo1.3.x' version: '0.7'. 	
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
			project: 'Alien' with:  'Pharo 1.1';
			package: 'Ocean' with: 'Ocean-NouryBouraqadi.18'
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
			package: 'OSProcess-Tests' with: 'OSProcess-Tests-dtl.2';
			package: 'Ocean' with: 'Ocean-NouryBouraqadi.18' 
	] 
]

{ #category : #versions }
ConfigurationOfOcean >> version03: spec [
	<version: '0.3' imports: #('0.2-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  'Pharo 1.1';
			package: 'OSProcess' with: 'OSProcess-dtl.59';
			package: 'OSProcess-Tests' with: 'OSProcess-Tests-dtl.4';
			package: 'Ocean' with: 'Ocean-LucFabresse.37'
	] 
]

{ #category : #versions }
ConfigurationOfOcean >> version04: spec [
	<version: '0.4' imports: #('0.3-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  'Pharo 1.2';
			package: 'OSProcess' with: 'OSProcess-dtl.59';
			package: 'OSProcess-Tests' with: 'OSProcess-Tests-dtl.4';
			package: 'Ocean' with: 'Ocean-LucFabresse.37'
	] 
]

{ #category : #versions }
ConfigurationOfOcean >> version05: spec [
	<version: '0.5' imports: #('0.4-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  'Pharo 1.2';
			project: 'OSProcess' with: #'stable';
			package: 'Ocean' with: 'Ocean-LucFabresse.44' 
	]
]

{ #category : #versions }
ConfigurationOfOcean >> version06: spec [
	<version: '0.6' imports: #('0.5-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  #development;
			package: 'Ocean' with: 'Ocean-LucFabresse.74' 
	]
]

{ #category : #versions }
ConfigurationOfOcean >> version07: spec [
	<version: '0.7' imports: #('0.6-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  #development;
			package: 'Ocean-Kernel' with: 'Ocean-Kernel-LucFabresse.1';
			package: 'Ocean-KernelTests' with: 'Ocean-KernelTests-LucFabresse.1';
			package: 'Ocean-LibraryPlugin' with: 'Ocean-LibraryPlugin-LucFabresse.1';
			package: 'Ocean-LibraryPluginTests' with: 'Ocean-LibraryPluginTests-LucFabresse.1' ;
			package: 'Ocean-LibraryPosix' with: 'Ocean-LibraryPosix-LucFabresse.1';
			package: 'Ocean-LibraryPosixTests' with: 'Ocean-LibraryPosixTests-LucFabresse.1';
			package: 'Ocean-Benchmarks' with: 'Ocean-Benchmarks-LucFabresse.1'.
	]
]

{ #category : #versions }
ConfigurationOfOcean >> version08: spec [
	<version: '0.8' imports: #('0.7-baseline')>
	
	spec for: #common do: [
		spec 
			blessing: #development; 
			project: 'Alien' with:  #development;
			package: 'Ocean-Kernel' with: 'Ocean-Kernel-LucFabresse.7';
			package: 'Ocean-KernelTests' with: 'Ocean-KernelTests-LucFabresse.8';
			package: 'Ocean-LibraryPlugin' with: 'Ocean-LibraryPlugin-LucFabresse.7';
			package: 'Ocean-LibraryPluginTests' with: 'Ocean-LibraryPluginTests-LucFabresse.6' ;
			package: 'Ocean-LibraryPosix' with: 'Ocean-LibraryPosix-LucFabresse.1';
			package: 'Ocean-LibraryPosixTests' with: 'Ocean-LibraryPosixTests-LucFabresse.2';
			package: 'Ocean-Benchmarks' with: 'Ocean-Benchmarks-LucFabresse.2'.
	]
]
