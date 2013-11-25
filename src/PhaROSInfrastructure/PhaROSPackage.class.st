Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#instVars : [
		'__ctrl'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROSInfrastructure-Package'
}

{ #category : #abstract }
PhaROSPackage class >> author [
	self subclassResponsibility 
]

{ #category : #abstract }
PhaROSPackage class >> catkin [
	| installed |
	installed :=  (PhaROSPackageManager  registeredCatckinPackagesFor: self ) .
	installed size = 1 ifFalse: [ self error: ' Several location registered in a deploy! '].
	^ installed anyOne 
]

{ #category : #abstract }
PhaROSPackage class >> configuration [
	^ PhaROSPackageDependency phaROSPackage: self package packageName.
]

{ #category : #accessing }
PhaROSPackage class >> definedNodelets [
	^ {}
]

{ #category : #abstract }
PhaROSPackage class >> dependencies [
	^ { PhaROSPackageDependency pharos}
]

{ #category : #abstract }
PhaROSPackage class >> install: aLocation [
	PhaROSCatkinPackage install: self in: aLocation 
]

{ #category : #abstract }
PhaROSPackage class >> packageName [
	self subclassResponsibility 
]

{ #category : #abstract }
PhaROSPackage class >> updateInstallations [
	^ (PhaROSPackageManager  registeredCatckinPackagesFor: self ) do: #deploy.
]

{ #category : #abstract }
PhaROSPackage class >> version [ 
	self subclassResponsibility.
]

{ #category : #scripts }
PhaROSPackage >> buildController [ 
	self subclassResponsibility.
]

{ #category : #'helper thread' }
PhaROSPackage >> clock [
	^ PhaROSTickingClock new
]

{ #category : #scripts }
PhaROSPackage >> controller [
	^ __ctrl ifNil: [ __ctrl := self buildController ].
]

{ #category : #scripts }
PhaROSPackage >> quit [
	Smalltalk snapshot: false andQuit: true.
]

{ #category : #scripts }
PhaROSPackage >> stdout [ 
	^  FileStream stdout.
]
