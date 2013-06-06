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
PhaROSPackageContainer >> use: aPackage as: aPackageImportName [
	packages at: aPackageImportName ifPresent: [ self error: ' there is alread a package related with this name '].
	packages at: aPackageImportName put: aPackage.
	controller install: aPackage.
]
