Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : #'PhaROS-Packages'
}

{ #category : #'as yet unclassified' }
PhaROSPackage class >> buildPackage [
	^ self new.
]

{ #category : #'as yet unclassified' }
PhaROSPackage class >> hasConstructed: aPackage [
	^ aPackage isKindOf: self.
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> configure [

]

{ #category : #'as yet unclassified' }
PhaROSPackage >> configureDependencies: aLaunchSpec [
	self dependencies do: [: dep | dep value: aLaunchSpec ].
	^ aLaunchSpec 
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> controller [
	^ controller
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> controller: aController [ 
	controller := aController.
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> dependencies [
	" [ : launchSpec | launchSpec add here all the dependencies ]"
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> finalize [
	
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> install [
	self types asDictionary keysAndValuesDo: [ : typeName : definition | 
		
		[
			PhaROSTypeBrowser instance definition: 'pharos/', typeName. 
		] on: Error do: [
			PhaROSSystemLauncher instance deployType: typeName definedAs: definition 
		].
	]
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> name [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> packages [
	^ self controller packages.
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> rosnode [
	^ self controller node.
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> types [
	"{ #name -> PhaROSCompositeType } asDictionary"
	^ self subclassResponsibility.
	
]
