Class {
	#name : #ConfigurationOfGhost,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGhost
}

{ #category : #private }
ConfigurationOfGhost class >> bootstrapPackage: aString from: aPath [ 
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
ConfigurationOfGhost class >> ensureMetacello [
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
ConfigurationOfGhost class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfGhost class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #accessing }
ConfigurationOfGhost class >> load [
	(self project version: #stable) load
]

{ #category : #'metacello tool support' }
ConfigurationOfGhost class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfGhost class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGhost >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
	].
		
	spec for: #pharo do: [
		
		spec repository: 'http://ss3.gemstone.com/ss/Ghost'.

		
		spec package: 'SimpleLogger' with: [ spec repository: 'http://ss3.gemstone.com/ss/Marea'].
		spec package: 'GhostProxies' with: [ spec requires: #('SimpleLogger') ].
		spec package: 'GhostProxiesTests' with: [ spec requires: #('GhostProxies') ].
		
		spec
 			group: 'default' with: #( 'Core' 'Tests' );
			group: 'Core' with: #('GhostProxies' );
			group: 'Tests' with: #('GhostProxiesTests');
			group: 'DevelopmentGroup' with: #( 'Core' 'Tests' )
			
		] 
]

{ #category : #baselines }
ConfigurationOfGhost >> baseline11: spec [ 
	<version: '1.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
	].
		
	spec for: #pharo do: [
		
		spec repository: 'http://ss3.gemstone.com/ss/Ghost'.

		spec package: 'GhostProxies'.
		spec package: 'GhostProxiesTests' with: [ spec requires: #('GhostProxies') ].
		
		spec
 			group: 'default' with: #( 'Core' 'Tests' );
			group: 'Core' with: #('GhostProxies' );
			group: 'Tests' with: #('GhostProxiesTests');
			group: 'DevelopmentGroup' with: #( 'Core' 'Tests' )
			
		] 
]

{ #category : #accessing }
ConfigurationOfGhost >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear.
		project ]
]

{ #category : #versions }
ConfigurationOfGhost >> stable: spec [
	<symbolicVersion: #'stable'>
	spec for: #'pharo1.3.x' version: '1.0'.
	spec for: #'pharo1.4.x' version: '1.0'.
	spec for: #'pharo2.x' version: '1.1'.
	
]

{ #category : #versions }
ConfigurationOfGhost >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Mariano Martinez Peck'.
		spec description: ' '.
	].
	
	spec for: #pharo do: [		
				
		spec package: 'SimpleLogger' with: 'SimpleLogger-MarianoMartinezPeck.11'.
		spec package: 'GhostProxies' with: 'GhostProxies-MarianoMartinezPeck.26'.
		spec package: 'GhostProxiesTests' with: 'GhostProxiesTests-MarianoMartinezPeck.12'.

		
	]
			
]

{ #category : #versions }
ConfigurationOfGhost >> version11: spec [
	<version: '1.1' imports: #('1.1-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Mariano Martinez Peck'.
		spec description: '
		- Do not use Marea Simple logger. Lets print to Transcript and in the future use a logger integrated in Pharo.
		- This version is for Pharo 2.0'
	].
	
	spec for: #pharo do: [		
				
		spec package: 'GhostProxies' with: 'GhostProxies-MarianoMartinezPeck.31'.
		spec package: 'GhostProxiesTests' with: 'GhostProxiesTests-MarianoMartinezPeck.14'.

		
	]
			
]
