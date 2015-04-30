Extension { #name : #PhaROSRPCNodelet }

{ #category : #'*PureROSPackageRobulab' }
PhaROSRPCNodelet >> mapHash [
	^ PureROSRobulabOld new mapFile asFileReference hash.
]
