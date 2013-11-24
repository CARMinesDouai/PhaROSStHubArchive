Class {
	#name : #PhaROSPackageDeployer,
	#superclass : #Object,
	#category : #'PhaROSInfrastructure-PackageDeployer'
}

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> deploy: aPackage on: anImagePath startedWith: aVmPath [
	| deployFileReference |

	deployFileReference := anImagePath asFileReference parent / 'deploy.st'.
	
	self write: (self generateDeployScriptFor: aPackage ) in: deployFileReference  pathString.
	

	self execute: anImagePath with: aVmPath and: deployFileReference pathString.
	"
	deployFileReference delete."
]

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> execute: anImagePath with: aVmPath and: deployFileReference. [
		^ ExternalUnixOSProcess 
					forkAndExec:  (aVmPath)  
					arguments: { anImagePath . deployFileReference }
					environment:  nil 
					descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
]

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> generateDeployScriptFor: aPackage [
	^ ' 
		Author fullName: ''{1}''.
		{2}.
		{3}.
		"Smalltalk snapshot: true andQuit: true."
	' format: {
		aPackage author .
		aPackage dependencies inject: '' into: [ :acc :dp | acc, dp loadingScript ].
		aPackage configuration loadingScript. 
	}.
	 
	
]

{ #category : #writer }
PhaROSPackageDeployer >> write: aContent in: aStringPath [ 
|outstream|
	outstream := StandardFileStream forceNewFileNamed: aStringPath.
	outstream ascii.
	outstream nextPutAll: aContent withUnixLineEndings .
	outstream flush.
	outstream close.
]
