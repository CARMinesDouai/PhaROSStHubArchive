Class {
	#name : #PhaROSPackageDeployer,
	#superclass : #Object,
	#category : #'PhaROSInfrastructure-CatkinPackage'
}

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> deploy: aPackage on: anImagePath startedWith: aVmPath [
	|  deployer  |
	UIManager inform:  'Starting code deploy! Remember that the deploy is based on monticello/metacello tecnology. You need to commit first the things to deploy!'.

	deployer := self execute: anImagePath with: aVmPath and: (self generateDeployScriptFor: aPackage).
	
	[deployer isComplete ] whileFalse: [ 10 seconds asDelay wait ].
	
	
	
	UIManager inform:  'Deployment complete!'.
]

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> execute: anImagePath with: aVmPath and: aContent [
	| deployFileReference |

	deployFileReference := anImagePath asFileReference parent / 'deploy.st'.
	
	self write: aContent in: deployFileReference  pathString.

		^ ExternalUnixOSProcess 
					forkAndExec:  (aVmPath)  
					arguments: {   anImagePath . deployFileReference  pathString }
					environment:  nil 
					descriptors: { FileStream stdin . FileStream stdout . FileStream stderr } .  
]

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> generateDeployScriptFor: aPackage [ 

	^ ' 
		
		StandardFileStream stdout nextPutAll: ''(1/4)- Setting author'', String crlf.
		Author fullName: ''{1}''.
		StandardFileStream stdout nextPutAll: ''(2/4) Setting network'', String crlf.
		{2}.
		StandardFileStream stdout nextPutAll: ''(3/4) Downloading dependencies'', String crlf.
		{3}.
		StandardFileStream stdout nextPutAll: ''(4/4) Downloading code'', String crlf.
		{4}.
		StandardFileStream stdout nextPutAll: ''Done :)''.
		Smalltalk snapshot: true andQuit: true.
	' format: {
		aPackage author .
		self proxySettings.
		aPackage dependencies inject: '' into: [ :acc :dp | acc, dp loadingScript ].
		aPackage configuration loadingScript. 
	}.
	 
	
]

{ #category : #'as yet unclassified' }
PhaROSPackageDeployer >> proxySettings [
	^ NetworkSystemSettings useHTTPProxy ifTrue: [
		'
		NetworkSystemSettings useHTTPProxy: true.
		NetworkSystemSettings httpProxyServer: ''{1}''.
		NetworkSystemSettings httpProxyPort: {2}.
		' format: { NetworkSystemSettings httpProxyServer . NetworkSystemSettings httpProxyPort }
		
	] ifFalse: [ '' ].
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
