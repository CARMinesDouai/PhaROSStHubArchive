"
usage: pharos create PACKAGE [OPTIONS]
 
Options:
          --help	Shows this text
          --location	Absolute path to a valid catkin workspace (not source folder. The workspace. By example /home/user/workspace ). 
                              Default value is the current directory.		
          --silent	{ true | false }. If silent is false you will be able to see the installation of the output image. 
                              Default value is true. 
          --version	{ 1.4 | 2.0 | 3.0 }. It indicates the version of pharo to download. It will not count if you are in a not silent session. 
                              Default value is 2.0
          --archetype	Indicates the name of the archetype to use for creating things. 
                              Default is basic-archetype.
          --author	Indicates the name of the author
          --maintainer	Indicates the name of the maintainer
                              Default value is the indicated in author

          --author-email	Indicates the email  of the author
          --maintainer-email	Indicates the email of the maintainer 
                              Default value is the indicated in author-email
          --description	Indicates the description of the package
	    --pharo-user	Indicates the user name for the result image.
          --force-new	DELETE the package if it exists in the pointed location. 

"
Class {
	#name : #PRCCommandLineCreateHandler,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler class >> commandName [
	^ 'create'
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> archetype [

	^ self checkPackage: (commandLine optionAt: #archetype ifAbsent:[ 'basic-archetype' ]) ifFail: [ 
		self loadRepositories.
		self checkPackage: (commandLine optionAt: #archetype ifAbsent:[ 'basic-archetype' ])
	 ].

]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> author [

	^  (self optionAt: #author ifAbsent: [  'author name' ] ).
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> authorEmail [

	^  (self optionAt: #'author-email' ifAbsent: [  'author@mail.com' ] ).
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> description [

	^  (self optionAt: #'description' ifAbsent: [  ' A PhaROS package '  ] ).
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> exampleGenerator [
^  [ 
: deploymentUnit |
| pack |
pack := deploymentUnit packageName capitalized,'Package'.

(Smalltalk at: #PhaROSPackage) subclass: pack asSymbol
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: pack.

(Smalltalk at: pack asSymbol) compile: 'buildController
	^ PhaROSHandleController home.
'.
(Smalltalk at: pack asSymbol) compile: 'nodeletInjectionExample
	self controller nodelets use: PhaROSNodelet as:#genericNodelet.
	self controller nodelets genericNodelet isKindOf: PhaROSNodelet.
'.
(Smalltalk at: pack asSymbol) compile: 'scriptExample
	"Any method that starts with a script is deployed as script Here you can start doing stuff".
'.
(Smalltalk at: pack asSymbol) compile: 'scriptTopicPublishingExample
	| publisher |
	"For publishing into a topic,you just need a publisher object. You can obtain it asking to the related node like in the following code".
	
	publisher := self controller node 
						topicPublisher: ''/example/string'' 
						typedAs: ''std_msgs/String''.
						
	publisher send:[ : string | string data: ''this is an example'' ].
'.
(Smalltalk at: pack asSymbol) compile: 'scriptTopicSubscribingExample
	
	"For subscribing to a topic, you just need a subscriber to configure it with a callback (block). You can obtain it asking to the related node like in the following code".
	(self controller node buildConnectionFor: ''/example/string'' ) 
								typedAs: ''std_msgs/String''; 
								for: [ : string |  "this is a callback" Transcript show: string data ];
								connect .
														
	"As you can see, buildConnectionFor: aTopicID, returns an object configurable. This is a builder, you can configure it as much as you want, and when you send connect message it will make the proper connection. For better usage of the builder check the documentation "
'.
(Smalltalk at: pack asSymbol) compile: 'scriptServiceDefining
	"In ROS we do have services. A Service is an async computation that has related a request and a response types. In order to make available a service in ROS world you should execute the following code"
	self controller node serve: [ :req :rsp | "this block will be executed when any one calls for this service" Transcript show: ''Service has been called.''; cr.  ] at: ''/pharos/service'' typedAs:''roscpp/Empty''.
	
'.

(Smalltalk at: pack asSymbol) compile: 'scriptServiceInvoking
	| service |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	service := self controller node service: ''/rosout/get_loggers''.
	service call.
	
	"This service call will ask for the loggers"
'.


(Smalltalk at: pack asSymbol) compile: 'scriptParameterBinding
	| integer |
	"A parameter is a value registered in the master. The idea is to give the chance to 3rd agents to change the value of this parameter. In order to ask for a parameter instance we call the following code"
	
	integer := self controller node parameter: ''integer'' initialized: 1. 
	
	" The variable integer now points to a binding. This binding understands #set: and #get messages. Is related with the ROS running environment. "
	
	
'.
 ].

]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> maintainer [

	^  (self optionAt: #'maintainer' ifAbsent: [ self author] ).
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> maintainerEmail [

	^  (self optionAt: #'maintainer-email' ifAbsent: [  self authorEmail  ] ).
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> package [
	| p |
	p := (self argumentAt: 1).
	(p indexOf: '-') = 1 ifTrue: [ self error: 'The package name is not optional and it must be the first parameter' ].
	^ p.
]

{ #category : #'as yet unclassified' }
PRCCommandLineCreateHandler >> realActivate [

	| location package archetype archObject version silent deployer sourceFolder author authorEmail maintainer maintainerEmail description |
	
	
	version := self version.
	location := self location.
	silent := self silent.
	
	package := self package.
	
	author := self author.
	authorEmail := self authorEmail.
	
	maintainer := self maintainer.
	maintainerEmail := self maintainerEmail.
	
	description := self description.
	
	archetype := self archetype.
	
	sourceFolder := location asFileReference / #src.
	
	self forceNewIfNeededAt: sourceFolder / package.
	
	deployer := silent ifTrue: [
		RCDDeployerFactory silentDeployerFor:  sourceFolder pathString withPharoVersion:  version.
	] ifFalse:[
		RCDDeployerFactory interactiveDeployerFor: sourceFolder pathString  withPharoVersion:  version.
	].
	
	deployer codeGenerator registerPreProcess: (' Author fullName: ''{1}'' ' format:{ self pharoUser }).
	
	deployer codeGenerator registerPostProcess: self exampleGenerator.

	archObject := PRCCommandPackageRegistry  deployUnitForPackage:  archetype.
	
	self assert: archObject isArchetype description:'You cannot install a package that is not archetype for creating packages'.
	
	archObject packageDescription: description. 
	
	archObject packageMaintainer: maintainer .
	archObject packageMaintainerEmail: maintainerEmail .
	
	archObject packageAuthor: author  .
	archObject packageAuthorEmail: authorEmail .
	archObject packageName: package.
		
	deployer deploy: archObject.









]
