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
| pack nodelet |
pack := deploymentUnit packageName capitalized,'Package'.
nodelet:= deploymentUnit packageName capitalized,'Nodelets'.

(Smalltalk at: #PhaROSPackage) subclass: pack asSymbol
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: pack.

(Smalltalk at: #PhaROSStaticNodelet) subclass: nodelet asSymbol
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: pack,'-Nodelets'.


(Smalltalk at: pack asSymbol) compile: 'buildController
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self nodeletInjectionExample: super buildController.
' classified: 'private - configuration'.
(Smalltalk at: pack asSymbol) compile: ('nodeletInjectionExample: aController
	"
		Nodelets are units objects responsible for solving common problems, meaning that there are reusable. 
	In order to access to a nodelet from a package we use a simple mechanism of dependency injection, so we 
	can easily change one implementation for other. 
		The main problem is the management of name for registration. Try to be clean and obvious with names. Comment and make them visible.
	For know more about nodelets go to the reference or check subclasses (PhaROSTransformationNodelet is a cool place to go)"

	aController nodelets use: {1} as:#example.
	aController nodelets example isKindOf: {1}.
	
' format: {nodelet}) classified: 'private - configuration'.

(Smalltalk at: pack asSymbol) compile: 'scriptExample
	"Any method that starts with a script is deployed as script Here you can start doing stuff".
' classified: 'scripts'.
(Smalltalk at: pack asSymbol) compile: 'scriptTopicPublishingExample
	| publisher |
	"For publishing into a topic,you just need a publisher object. You can obtain it asking to the related node like in the following code".
	
	publisher := self controller node 
						topicPublisher: ''/example/string'' 
						typedAs: ''std_msgs/String''.
						
	publisher send:[ : string | string data: ''this is an example'' ].
' classified: 'scripts'.
(Smalltalk at: pack asSymbol) compile: 'scriptTopicSubscribingExample
	
	"For subscribing to a topic, you just need a subscriber to configure it with a callback (block). You can obtain it asking to the related node like in the following code".
	(self controller node buildConnectionFor: ''/example/string'' ) 
								typedAs: ''std_msgs/String''; 
								for: [ : string |  "this is a callback" Transcript show: string data ];
								connect .
														
	"As you can see, buildConnectionFor: aTopicID, returns an object configurable. This is a builder, you can configure it as much as you want, and when you send connect message it will make the proper connection. For better usage of the builder check the documentation "
' classified: 'scripts'.
(Smalltalk at: pack asSymbol) compile: 'scriptServiceDefining
	"In ROS we do have services. A Service is an async computation that has related a request and a response types. In order to make available a service in ROS world you should execute the following code"
	self controller node serve: [ :req :rsp | 
		"this block will be executed when any one calls for this service" 
		Transcript show: ''Service has been called.''; cr.  
	] at: ''/pharos/service'' typedAs:''roscpp/Empty''.
	
' classified: 'scripts'.

(Smalltalk at: pack asSymbol) compile: 'scriptServiceInvoking
	| service |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	service := self controller node service: ''/rosout/get_loggers''.
	service call.
	
	"This service call will ask for the loggers"
' classified: 'scripts'.


(Smalltalk at: pack asSymbol) compile: 'scriptParameterBinding
	| integer |
	"A parameter is a value registered in the master. The idea is to give the chance to 3rd agents to change the value of this parameter. In order to ask for a parameter instance we call the following code"
	
	integer := self controller node parameter: ''integer'' initialized: 1. 
	
	" The variable integer now points to a binding. This binding understands #set: and #get messages. Is related with the ROS running environment. "
	
	
' classified: 'scripts'.


Workspace openContents: '
"
	Welcome to PhaROS! 
	Remember always to check for updates in http://car.mines-douai.fr/PhaROS. 
	
	-----------------------------------------------------------
	Inside a package object 
	-----------------------------------------------------------
	
	Publish topic 
	-------------------
	
	| publisher |
	publisher := self controller node 
						topicPublisher: ''/example/string'' 
						typedAs: ''std_msgs/String''.
						
	publisher send:[ : string | string data: ''this is an example'' ].
	
	
	Subscribe topic
	------------------------
	
	(self controller node buildConnectionFor: ''/example/string'' ) 
			typedAs: ''std_msgs/String''; 
			for: [ : string |  Transcript show: string data ];
			connect .
	
	
	Call service 
	------------------
	| service |
	service := self controller node service: ''/rosout/get_loggers''.
	service call.
	
	
	Define service 
	------------------------
	
	self controller node serve: [ :req :rsp | 
		 Transcript show: ''Service has been called.''; cr.  
	] at: ''/pharos/service'' typedAs:''roscpp/Empty''.
	
	
	
	
	Inject/install a nodelet 
	----------------------------------
	
	self controller nodelets use: YourNodeletClass as:#nameToBeInvoked.
	
	
	Specifying controller configuration 
	-----------------------------------------------------
	
	In the package object implement the message #buildController. Build controller has the responsibility to build the controller and return it. 
	
	For building your own controller 
	
	buildController
		^ MyController build	
	
	For building same controller but configure things (like nodelets, or configuring)
	
	buildController
		^ self myControllerConfigurationMethod: super buildController.
	
	myControllerConfigurationMethod: aController
		<< Make here your configurations >>
		^ aController
		
		
		
		
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-----------------------------------------------------------
	Inside a nodelet object 
	-----------------------------------------------------------
	
	
	Define a new type
	-----------------------------
	Define as class method a method with a cool name, as myCoolTypeDefinition
	
	myCoolTypeDefinition
	
	^ PhaROSCompositeType named: ''anStandarROS/TypeName'' definedBy: {
		#header -> (PhaROSTypeBrowser instance definition: ''std_msgs/Header''). 
		#auint8 -> (PhaROSUInt8Type new).
		#auint16 -> (PhaROSUInt16Type new).
		#aint32 -> (PhaROSInt32Type new).
		#afloat32 -> (PhaROSFloat32Type new).
		#afloat64 -> (PhaROSFloat64Type new).
		#astring ->( PhaROSStringType new ) .
		#atime -> (PhaROSTimeType new ). 
	}  withConstants: {
		#CONSTANT -> ASimpleObjectValue
	}.
	
	As shown in the definition you give an array of associations with (#nameOfTheField -> Type new). 
	For checking all the available types, just browse any of this classes to go to the package. Or check the reference.
	
	Constants values cannot be complex. Just numbers, strings, booleans. 
	
	
	
	Register a type 
	------------------------
	
	Define in class side of your nodelet the method #types 

	types
		^ super types, { #YourTypeName -> self myCoolTypeDefinition }.
	
	In order to deploy the type into ROS you will need to commit all your work and install it through the pharos command (as shown in the shell commands section). 
	We are working to enhance this step. 
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-----------------------------------------------------------
	Shell commands
	-----------------------------------------------------------

	Install PhaROS based Package
	---------------------------------------------
		pharos install PACKAGE [OPTIONS]
		
		Example 
			pharos install esug --location=/home/user/ros/workspace --version=2.0
		Help 
			pharos install --help

	Create	PhaROS based Package		
	------------------------------------------------
		pharos create PACKAGE [OPTIONS]
		
		Example
			pharos create --location=/home/user/ros/workspace --version=2.0 --author=YourName --author-email=YourEmail 
			Tip: Be sure the email is a correct one. If is not a correctly spelled one you will notice during last step. 
		Help 
			pharos create --help
		
	Register Repository of packages  
	---------------------------------------------------
		pharos register-repository --url=anUrl --package=aPackage [ OPTIONS ]
		
		Example 
			pharos register-repository --url=http://smalltalkhub.com/mc/user/YourProject/main --package=YourProjectDirectory --directory=YourProjectDirectory 
			Tip: If your repository requires user/password for reading add --user=User --password=Password to the example. 
			Disclaimer: User/Password will be stored in a text file without any security. 
		Help 
			pharos register-repository --help
		
	Listing registered repositories
	------------------------------------------------
	
		pharos list-repositories
		
		
	Creating a directory for your own project repository
	-----------------------------------------------------------------------------------
		pharos create-repository PACKAGENAME [ OPTIONS ]

		Example 
			pharos create-repository example --user=UserName > directory.st
			pharos create-repository example --user=UserName  --output= directory.st
		
		Help 
			pharos create-repository --help 
			
"	
' label: 'PhaROS - Cheatsheet'.


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
