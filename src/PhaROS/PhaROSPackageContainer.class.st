Class {
	#name : #PhaROSPackageContainer,
	#superclass : #Object,
	#instVars : [
		'packages',
		'controller'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSPackageContainer >> controller: aController [
	controller := aController 
]

{ #category : #'as yet unclassified' }
PhaROSPackageContainer >> doesNotUnderstand: aMessage [
	aMessage selector numArgs = 0 ifTrue: [
		^ packages at: (aMessage selector asString ) ifAbsent: [ self error: 'There is no package named ', aMessage selector asString]	
	].
	^ super doesNotUnderstand: aMessage.
]

{ #category : #'as yet unclassified' }
PhaROSPackageContainer >> finalize [
	packages valuesDo: #finalize.
]

{ #category : #'as yet unclassified' }
PhaROSPackageContainer >> initialize [ 
	packages := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSPackageContainer >> use: aPackageConstructor as: aPackageImportName [
	
	"=
		# arguments
			1. aPackageConstructor : Object that understand buildPackage message and gives a package to install in the name.
			2. aPackageImportName : Symbol to install the package.
		# behavior
			install a package with the given name. If there is a package alread installed it check that is the same kind. If is not raise a signal. 
		# error
			 there is alread a package related with this name '.
			
	="

	packages at: aPackageImportName ifPresent: [ : p | 
		(aPackageConstructor hasConstructed: p) ifFalse: [
			self error: ' there is alread a package related with this name '
		].
	] ifAbsent: [
		| package |
		
		package := aPackageConstructor buildPackage. 

		packages at: aPackageImportName put: package.
		controller install: package.	
	].
	
]
