Extension { #name : #PhaROSSystemLauncher }

{ #category : #'*PhaROSInfrastructure-ROSLaunch' }
PhaROSSystemLauncher >> launch: aConfigurationFileOrBlock [
	| configuration path |
	
	path := (aConfigurationFileOrBlock isKindOf: String) ifTrue: [
		aConfigurationFileOrBlock.
	] ifFalse: [
		configuration := PhaROSLaunchBuilder new .
		aConfigurationFileOrBlock value: configuration.
		configuration writeFile.
	].

	^ (self roslaunch: path) asStickyReference.
]
