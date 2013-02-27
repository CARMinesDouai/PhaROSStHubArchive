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

{ #category : #loading }
ConfigurationOfPureROS class >> loadBleedingEdge [
	(self project version: #bleedingEdge) load.
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

{ #category : #'as yet unclassified' }
ConfigurationOfPureROS >> baseline10: spec [
	<version:'1.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://car.mines-douai.fr/squeaksource/Pure'.
			
			
			spec project: 'PhaROS' with: [
				spec 
					className: 'ConfigurationOfPhaROS';
					file: 'ConfigurationOfPhaROS' ;
					repository: 'http://car.mines-douai.fr/squeaksource/PhaROS'; 
					versionString: #bleedingEdge
			].
			
		      spec project: 'PureNG' with: [
				spec 
					className: 'ConfigurationOfPureNG';
					file: 'ConfigurationOfPureNG' ;
					versionString: #bleedingEdge;
					repository: 'http://car.mines-douai.fr/squeaksource/Pure'.
			].

		
			spec package: 'PureROS' with: [
				spec requires: #('PhaROS' 'PureNG').
			].
	].


]

{ #category : #'as yet unclassified' }
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
