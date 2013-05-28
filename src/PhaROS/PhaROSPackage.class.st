Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSPackage >> configure: aNode [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> configureDependencies: aLaunchSpec [
	self dependencies do: [: dep | dep value: aLaunchSpec ].
	^ aLaunchSpec 
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> dependencies [
	" [ : launchSpec | launchSpec add here all the dependencies ]"
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> install [
	self types asDictionary keysAndValuesDo: [ : typeName : definition | PhaROSSystemLauncher deployType: typeName definedAs: definition ].
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> name [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> runOver: aNode [
	self configure: aNode.
]

{ #category : #'as yet unclassified' }
PhaROSPackage >> types [
	"{ #name -> PhaROSCompositeType } asDictionary"
	^ self subclassResponsibility.
	
]
