Class {
	#name : #PhaROSNodelet,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : #'PhaROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PhaROSNodelet class >> buildPackage [
	^ self new.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet class >> hasConstructed: aPackage [
	^ aPackage isKindOf: self.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> configure [

]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> configureDependencies: aLaunchSpec [
	self dependencies do: [: dep | dep value: aLaunchSpec ].
	^ aLaunchSpec 
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> controller [
	^ controller
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> controller: aController [ 
	controller := aController.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> dependencies [
	" [ : launchSpec | launchSpec add here all the dependencies ]"
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> finalize [
	controller := nil.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> install [
	self types asDictionary keysAndValuesDo: [ : typeName : definition | 
		
		[
			PhaROSTypeBrowser instance definition: 'pharos/', typeName. 
		] on: Error do: [
			PhaROSSystemLauncher instance deployType: typeName definedAs: definition 
		].
	]
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> name [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> packages [
	^ self controller packages.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> rosnode [
	^ self controller node.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> types [
	"{ #name -> PhaROSCompositeType } asDictionary"
	^ self subclassResponsibility.
	
]
