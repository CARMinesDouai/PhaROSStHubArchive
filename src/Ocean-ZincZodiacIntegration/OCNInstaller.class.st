"
OCNInstaller makesZincUseOcean.

OCNInstaller makesZincUseOldNetwork.

"
Class {
	#name : #OCNInstaller,
	#superclass : #Object,
	#category : #'Ocean-ZincZodiacIntegration'
}

{ #category : #private }
OCNInstaller class >> makesZdcStreamsUseOcean [
	
	OCNAbstractSocketStream subclass: #ZdcSimpleSocketStream
		instanceVariableNames: ''
		classVariableNames: ''
		category: 'Ocean-ZincZodiacIntegration'.
	
	OCNSimpleSocketStream subclass: #ZdcOptimizedSocketStream
		instanceVariableNames: ''
		classVariableNames: ''
		category: 'Ocean-ZincZodiacIntegration'.
	
]

{ #category : #private }
OCNInstaller class >> makesZdcStreamsUseOldNetwork [
		
	ZdcAbstractSocketStream subclass: #ZdcSimpleSocketStream
		instanceVariableNames: ''
		classVariableNames: ''
		category: 'Zodiac-Core'.
	
	ZdcSimpleSocketStream subclass: #ZdcOptimizedSocketStream
		instanceVariableNames: ''
		classVariableNames: ''
		category: 'Zodiac-Core'.

]

{ #category : #actions }
OCNInstaller class >> makesZincUseOcean [

	self makesZdcStreamsUseOcean.
	
	ZnNetworkingUtils default: OCNetworkingUtils new
]

{ #category : #actions }
OCNInstaller class >> makesZincUseOldNetwork [

	self makesZdcStreamsUseOldNetwork.
	ZnNetworkingUtils initialize
]
