Class {
	#name : #PhaROSNodelet,
	#superclass : #Object,
	#instVars : [
		'controller',
		'launch'
	],
	#category : #'PhaROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PhaROSNodelet class >> buildNodelet [
	^ self new.
]

{ #category : #'as yet unclassified' }
PhaROSNodelet class >> hasConstructed: aNodeletInstance [
	^ aNodeletInstance isKindOf: self.
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
	launch := nil.
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
PhaROSNodelet >> launch [
	launch ifNil: [ self dependencies size > 0 ifTrue: [
			launch := PhaROSSystemLauncher instance launch: [ :b | self configureDependencies: b ]
		]
	].
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> name [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSNodelet >> nodelets [
	^ self controller nodelets.
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
