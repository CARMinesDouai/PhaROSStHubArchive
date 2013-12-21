Class {
	#name : #PhaROSAbstractCatkinPackageLocalDeployer,
	#superclass : #Object,
	#classInstVars : [
		'installedPackages'
	],
	#category : #'PhaROSInfrastructure-TargetDeployer'
}

{ #category : #sync }
PhaROSAbstractCatkinPackageLocalDeployer class >> catkinPackageFor: aClass [
	^ self installedPackages detect: [ : p | p pharosPackage = aClass] ifNone: [ nil ] 
]

{ #category : #'as yet unclassified' }
PhaROSAbstractCatkinPackageLocalDeployer class >> installedPackages [
	^ installedPackages ifNil: [ installedPackages := Set new  ].
]

{ #category : #sync }
PhaROSAbstractCatkinPackageLocalDeployer class >> isInstalled: aClass [
	^ (self catkinPackageFor: aClass) notNil.
]

{ #category : #sync }
PhaROSAbstractCatkinPackageLocalDeployer class >> itsAPackage: aClass andItsAScript: aSelector [
	^ ((aClass inheritsFrom: PhaROSPackage ) and: [ (self isInstalled: aClass) and: [ aSelector beginsWith: 'script'] ]  )
]

{ #category : #'as yet unclassified' }
PhaROSAbstractCatkinPackageLocalDeployer class >> register: aPackage [
	self installedPackages add: aPackage.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractCatkinPackageLocalDeployer class >> registeredCatckinPackagesFor: aPhaROSPackage [
	^ self installedPackages select:[ : catkn | catkn pharosPackage = aPhaROSPackage ] 
]

{ #category : #sync }
PhaROSAbstractCatkinPackageLocalDeployer class >> removeScript: aSelector of: aClass [
	(self isInstalled: aClass) ifTrue: [ 
			FileSystem disk delete: ((self catkinPackageFor: aClass) scripts, '/',( aSelector asString copyFrom: 'script' size) asLowercase).
		
	 ].


]

{ #category : #sync }
PhaROSAbstractCatkinPackageLocalDeployer class >> scriptSyncronizer: aClass selector: aSelector [
	(self itsAPackage: aClass andItsAScript: aSelector ) ifTrue: [
		(PhaROSCatkinPackageLocalInstaller registeredCatckinPackagesFor: aClass)  do: [ :p | p installScript: aSelector.]	
	]
]
