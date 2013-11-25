Class {
	#name : #PhaROSPackageDependency,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'configurationOfName',
		'url',
		'needsCredentials'
	],
	#category : #'PhaROSInfrastructure-PackageDeployer'
}

{ #category : #dependencies }
PhaROSPackageDependency class >> action [
	^ self phaROSPackage: #PhaROSNodeletsAction.
]

{ #category : #dependencies }
PhaROSPackageDependency class >> controller [
	^ self phaROSPackage: #PhaROSControllers.
			     
]

{ #category : #dependencies }
PhaROSPackageDependency class >> experiments [
	^ self phaROSPackage: #PhaROSInfrastructure
]

{ #category : #dependencies }
PhaROSPackageDependency class >> infrastructure [
	^ self phaROSPackage: #PhaROSInfrastructure
]

{ #category : #dependencies }
PhaROSPackageDependency class >> localizer [
	^ self phaROSPackage:#PhaROSNodeletsLocalizer
]

{ #category : #dependencies }
PhaROSPackageDependency class >> merger [
	^ self phaROSPackage: #PhaROSNodeletsMerger
]

{ #category : #dependencies }
PhaROSPackageDependency class >> moveBase [
	^ self phaROSPackage: #PhaROSMoveBase
]

{ #category : #dependencies }
PhaROSPackageDependency class >> odometry [
	^ self phaROSPackage: #PhaROSNodeletsOdometry
]

{ #category : #private }
PhaROSPackageDependency class >> phaROSPackage: aPackageName [
	^ self new 
			    packageName: aPackageName;
			     configurationOfName: #ConfigurationOfPhaROS ; 
			     url: 'http://car.mines-douai.fr/squeaksource/PhaROS'; 
			     yourself.
	 
]

{ #category : #dependencies }
PhaROSPackageDependency class >> pharos [
	^ self phaROSPackage: #core
]

{ #category : #dependencies }
PhaROSPackageDependency class >> poseTracker [
	^ self phaROSPackage: #PhaROSNodeletsPoseTracker
]

{ #category : #dependencies }
PhaROSPackageDependency class >> position [
	^ self phaROSPackage: #PhaROSNodeletsPosition
]

{ #category : #dependencies }
PhaROSPackageDependency class >> rpc [
	^ self phaROSPackage: #PhaROSNodeletsRPC
]

{ #category : #dependencies }
PhaROSPackageDependency class >> tf [
	^ self phaROSPackage: #PhaROSNodeletsTF
]

{ #category : #dependencies }
PhaROSPackageDependency class >> turtlebot [
	^ self phaROSPackage: #PhaROSNodeletsTurtlebot
]

{ #category : #dependencies }
PhaROSPackageDependency class >> turtlesim [
	^ self phaROSPackage: #PhaROSNodeletsTurtlesim
]

{ #category : #accessing }
PhaROSPackageDependency >> configurationOfName [
	^ configurationOfName
]

{ #category : #accessing }
PhaROSPackageDependency >> configurationOfName: anObject [
	configurationOfName := anObject
]

{ #category : #accessing }
PhaROSPackageDependency >> initialize [ 
	needsCredentials := false.
]

{ #category : #dep }
PhaROSPackageDependency >> installOn: aPhaROSCatkinPackage [ 
	PhaROSNodelet allSubclasses select: [ :c | c packageName = packageName ]thenDo: [ :c| c installOn: aPhaROSCatkinPackage  ]
]

{ #category : #accessing }
PhaROSPackageDependency >> load [
	(Gofer it url: self url; package: configurationOfName) load.
	(Smalltalk at: configurationOfName asSymbol) load: packageName.
	
]

{ #category : #accessing }
PhaROSPackageDependency >> loadingScript [
	^
	configurationOfName ifNotNil: [
		needsCredentials ifFalse: [	
			'
			(Gofer it url: ''{1}''; package: ''{2}'') load.
			(Smalltalk at: #{2} ) load: ''{3}''.
			' format: { self url . self configurationOfName . self packageName }.
		] ifTrue: [
			'
			(Gofer it url: ''{1}'' username: ''{2}'' password:''{3}'' ; package: ''{4}'') load.
			(Smalltalk at: #{4} ) load: ''{5}''.
			' format: { 
					self url . 
					(UIManager request: 'Please, enter a username for', self packageName) .  
					(UIManager requestPassword: 'Please, enter a password for', self packageName)   . 
					self configurationOfName . 
					self packageName 
				}.
		]
	] ifNil: [
		needsCredentials ifFalse: [	
			'
			(Gofer it url: ''{1}''; package: ''{2}'') load.
			' format: { self url . self packageName }.
		] ifTrue: [
			'
			(Gofer it url: ''{1}'' username: ''{2}'' password:''{3}'' ; package: ''{4}'') load.
			' format: { 
					self url . 
					(UIManager request: 'Please, enter a username for', self packageName) .  
					(UIManager requestPassword: 'Please, enter a password for', self packageName)   . 
					self packageName 
				}.
		]
	
	]
]

{ #category : #accessing }
PhaROSPackageDependency >> needsCredentials [
	needsCredentials := true 
	
]

{ #category : #accessing }
PhaROSPackageDependency >> packageName [
	^ packageName
]

{ #category : #accessing }
PhaROSPackageDependency >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
PhaROSPackageDependency >> url [
	^ url
]

{ #category : #accessing }
PhaROSPackageDependency >> url: anObject [
	url := anObject
]
