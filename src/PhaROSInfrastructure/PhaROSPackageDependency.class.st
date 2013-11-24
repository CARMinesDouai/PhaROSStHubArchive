Class {
	#name : #PhaROSPackageDependency,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'configurationOfName',
		'url'
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
PhaROSPackageDependency class >> stargazer [
	^ self new 
			    packageName: 'StarGazer';
			     configurationOfName: #ConfigurationOfStargazer ; 
			     url: 'http://car.mines-douai.fr/squeaksource/Peripherics'; 
			     yourself.
	 
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
PhaROSPackageDependency >> load [
	(Gofer it url: self url; package: configurationOfName) load.
	(Smalltalk at: configurationOfName asSymbol) load: packageName.
	
]

{ #category : #accessing }
PhaROSPackageDependency >> loadingScript [
	^
	'
	(Gofer it url: ''{1}''; package: ''{2}'') load.
	(Smalltalk at: #{2} ) load: ''{3}''.
	' format: { self url . self configurationOfName . self packageName }.

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
