"
ConfigurationOfTaskIT loadBleedingEdge
"
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

{ #category : #catalog }
ConfigurationOfTaskIT class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ '- 1.0 - 10/01/2014 - First stable version
[[[
	ConfigurationOfTaskIT project version: ''1.0'' ) load					
]]]
'
]

{ #category : #catalog }
ConfigurationOfTaskIT class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ '
		You can find a chapter of TaskIT at https://ci.inria.fr/pharo-contribution/job/PharoForTheEnterprise/lastSuccessfulBuild/artifact/TaskIT/TaskIT.pier.html
		You can get in contact with the programmers at santiagobragagnolo@gmail.com and guillermopolito@gmail.com'
]

{ #category : #catalog }
ConfigurationOfTaskIT class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Expressing and managing concurrent computations is indeed a concern of importance to develop applications that scale. A web application may want to use different processes for each of its incoming requests. Or maybe it wants to use a "thread pool" in some cases. In other case, our desktop application may want to send computations to a worker to not block the UI thread.
TaskIT is a library that eases the usage of processes in Pharo. It provides abstractions to schedule and/or parallelize of the execution of pieces of code.'
]

{ #category : #catalog }
ConfigurationOfTaskIT class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'A task is a first class representation of a piece of code to be executed, the main abstraction inside TaskIT. By reifying a task, TaskIT can paralellize it, start it and/or stop it whenever we want. A task, instance of TKTTask, is created in the following way:

TKTTask for: [ someObject someMessage ].
TKTTask for: [ someObject someMessage ] at: aPriority.
A normal task contains a block with a piece of code to be run. The result of the task''s execution will be the result of its block.

Additionally, a task contains a priority that will be used to decide the order of execution between other tasks. If we do not specify a priority explicitly, the default userBackgroundPriority defined in Pharo''s ProcessorScheduler is used. We will discuss about the importance of a task''s priority in the task runners'' section.

Alternatively, blocks are extended to provided a nice syntax sugar to create tasks:

[ someObject someMessage ] asTask.
[ someObject someMessage ] asTaskAt: aPriority.

For an extensive explanation, please address the related chapter of the book Pharo for the enterprise. 
'


]

{ #category : #catalog }
ConfigurationOfTaskIT class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(processing process threading tasks pharo threadpool) 
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
ConfigurationOfTaskIT >> baseline20: spec [
	<version:'2.0-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/sbragagnolo/TaskIT/main'.
			spec project: 'Ghost' with: [
				spec 
					className: 'ConfigurationOfGhost';
					file: 'ConfigurationOfGhost' ;
					repository: 'http://ss3.gemstone.com/ss/Ghost'
			].
			spec project: 'OSProcess' with: [
				spec 
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess' ;
					repository: 'http://www.squeaksource.com/MetacelloRepository'; 
					versionString: #stable.
			].
		
			spec package: 'TaskIT' with: [
				spec requires: #('Ghost' ).
			].
			spec package: 'ForkIT' with: [ 
				spec requires: #('TaskIT' 'OSProcess').
			 ].
			spec package: 'ActIT' with: [ 
				spec requires: #('TaskIT').
			 ].
			spec package: 'PoolIT' with: [ 
				spec requires: #('TaskIT').
			 ].
			spec package: 'PlanIT' with: [ 
				spec requires: #('TaskIT').
			 ].
			spec group: 'core'with: #( 'TaskIT').
			spec group: 'fulltasks'  with: #( 'TaskIT' 'ForkIT' ).
			spec group: 'default'  with: #( 'TaskIT' 'ForkIT' 'PoolIT'  ).
			spec group: 'full'  with: #( 'TaskIT' 'ForkIT'  'PlanIT' 'ActIT' 'PoolIT'  ).
			
	].


]

{ #category : #'as yet unclassified' }
ConfigurationOfTaskIT >> baseline21: spec [
	<version:'2.1-baseline'>
	spec for: #common do: [
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/CAR/TaskIT/main'.
		
			spec project: 'Ghost' with: [
				spec 
					className: 'ConfigurationOfGhost';
					file: 'ConfigurationOfGhost' ;
					repository: 'http://smalltalkhub.com/mc/CAR/Ghost/main'
			].
		
			spec project: 'OSProcess' with: [
				spec 
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess' ;
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoPharo30/main'; 
					versionString: #stable.
			].
		
			spec package: 'TaskIT' with: [
				spec requires: #('Ghost' ).
			].
			spec package: 'ForkIT' with: [ 
				spec requires: #('TaskIT' 'OSProcess').
			 ].
			spec package: 'ActIT' with: [ 
				spec requires: #('TaskIT').
			 ].
			spec package: 'PoolIT' with: [ 
				spec requires: #('TaskIT').
			 ].
			spec package: 'PlanIT' with: [ 
				spec requires: #('TaskIT').
			 ].
			spec group: 'core'with: #( 'TaskIT').
			spec group: 'fulltasks'  with: #( 'TaskIT' 'ForkIT' ).
			spec group: 'default'  with: #( 'TaskIT' 'ForkIT' 'PoolIT'  ).
			spec group: 'full'  with: #( 'TaskIT' 'ForkIT'  'PlanIT' 'ActIT' 'PoolIT'  ).
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
	spec for: #'pharo1.4.x' version: '1.1'.
	spec for: #'pharo2.x' version: '2.0'.
	spec for: #'pharo3.x' version: '2.1'.	
]

{ #category : #versions }
ConfigurationOfTaskIT >> version10: spec [ 
	<version: '1.0' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '10/01/2014 12:00'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.30'.
	].


]

{ #category : #versions }
ConfigurationOfTaskIT >> version11: spec [ 
	<version: '1.1' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '15/02/2014 12:00'.
		spec package:'TaskIT' with: 'TaskIT-pharos.61'.
	].


]

{ #category : #versions }
ConfigurationOfTaskIT >> version20: spec [ 
	<version: '2.0' imports: #('2.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '18/02/2014 12:00'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.68'.
	].


]

{ #category : #versions }
ConfigurationOfTaskIT >> version21: spec [ 
	<version: '2.1' imports: #('2.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'SantiagoBragagnolo'.
		spec timestamp: '18/02/2014 12:00'.
		spec package:'TaskIT' with: 'TaskIT-SantiagoBragagnolo.77'.
		spec package:'ForkIT' with: 'ForkIT-SantiagoBragagnolo.4'.
		spec package:'ActIT' with: 'ActIT-GuillermoPolito.3'.
		spec package:'PlanIT' with: 'PlanIT-SantiagoBragagnolo.1'.
		spec package:'PoolIT' with: 'PoolIT-SantiagoBragagnolo.1'.
	].


]
