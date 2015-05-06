"
A PhaROSPackage class is the representation of a catkin package.

Meta infos are stored on class side.
If they are changed, you must regenerate the catkin files to reflect those changes by: 
	PhaROSCatkinDeployer instance  reinstallAllTypes

methods whose selector starts with 'script' are automatically stored in the catkin package and can then be used using rosrun.

Example:

rosrun <catkinPackageName> headless <scriptName>
"
Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#instVars : [
		'__ctrl'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-Package'
}

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageAuthor [
	^ 'pharos'
]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageAuthorEmail [
	^ 'anon@ymous.com'
]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageDescription [
	^ 'a not described catkin package implemented in PhaROS (http://car.mines-douai.fr/category/pharos)'
]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageLicense [
	^ 'MIT (http://opensource.org/licenses/MIT)'
]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageMaintainer [
	^ self catkinPackageAuthor

]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageMaintainerEmail [
	^ self catkinPackageAuthorEmail
]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageName [

	(self = PhaROSPackage) ifTrue: [ self shouldNotImplement  ].
	
	(self name endsWith: 'Package') ifTrue: [ 
		^ (self name truncateTo: (self name size - 7)) translateToLowercase
	] ifFalse: [ 
		self subclassResponsibility  
	]
	 

]

{ #category : #'meta infos' }
PhaROSPackage class >> catkinPackageVersion [
	^ '0.0.1' 
	
]

{ #category : #types }
PhaROSPackage class >> types [
	^ {  }
]

{ #category : #stdio }
PhaROSPackage >> askUserFor: aString [
	^ self nodelets io askUserFor: aString.
]

{ #category : #initialization }
PhaROSPackage >> buildController [
	| controller |

	controller := PhaROSHandleController home.
	controller nodelets use: PhaROSStdIONodelet as: #io. 
	^ controller 
]

{ #category : #scripts }
PhaROSPackage >> controller [
	^ __ctrl ifNil: [ __ctrl := self buildController ].
]

{ #category : #scripts }
PhaROSPackage >> exit: aCode [
	Smalltalk exit: aCode.
]

{ #category : #log }
PhaROSPackage >> log: aString [
	self nodelets io stdout nextPutAll: (aString, String lf).
]

{ #category : #accessing }
PhaROSPackage >> node [
	^ self controller node
]

{ #category : #accessing }
PhaROSPackage >> nodelets [
	^ self controller nodelets
]

{ #category : #stdio }
PhaROSPackage >> stdin [
	^ self nodelets io stdin
]

{ #category : #stdio }
PhaROSPackage >> stdout [
	^ self nodelets io stdout
]
