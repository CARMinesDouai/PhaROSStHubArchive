Class {
	#name : #OCNNetworkLibraryProxyFactory,
	#superclass : #Object,
	#classInstVars : [
		'defaultNetworkLibraryProxyClassesDict'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNNetworkLibraryProxyFactory class >> allNetworkLibraryProxyClasses [
	^#(#OCNMacOSXPosixDebugLibrary #OCNMacOSXPosixLibrary)
]

{ #category : #'building socket proxies' }
OCNNetworkLibraryProxyFactory class >> defaultNetworkLibraryProxyClass [
	^self defaultNetworkLibraryProxyClassesDict 
		at: SmalltalkImage current platformName 
		ifAbsent: [self error: 'Platform not supported']
]

{ #category : #accessing }
OCNNetworkLibraryProxyFactory class >> defaultNetworkLibraryProxyClassesDict [
	^ defaultNetworkLibraryProxyClassesDict
]

{ #category : #accessing }
OCNNetworkLibraryProxyFactory class >> defaultNetworkLibraryProxyClassesDict: anObject [
	defaultNetworkLibraryProxyClassesDict := anObject
]

{ #category : #'class initialization' }
OCNNetworkLibraryProxyFactory class >> initialize [ 
	self defaultNetworkLibraryProxyClassesDict: Dictionary new.
	self defaultNetworkLibraryProxyClassesDict at: 'Mac OS' put: OCNMacOSXPosixLibrary 
]

{ #category : #'building socket proxies' }
OCNNetworkLibraryProxyFactory class >> networkLibraryProxy [
	^ self defaultNetworkLibraryProxyClass proxy
]
