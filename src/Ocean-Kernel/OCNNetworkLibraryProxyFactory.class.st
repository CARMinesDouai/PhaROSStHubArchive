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
	^{OCNSocketPluginLibrary} "OCNMacOSXPosixLibrary"
]

{ #category : #'building socket proxies' }
OCNNetworkLibraryProxyFactory class >> defaultNetworkLibraryProxyClass [
	^self defaultNetworkLibraryProxyClassesDict 
		at: Smalltalk os platformName 
		ifAbsent: [^OCNSocketPluginLibrary]
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
	"self defaultNetworkLibraryProxyClassesDict at: 'Mac OS' put: OCNMacOSXPosixLibrary "
]

{ #category : #'building socket proxies' }
OCNNetworkLibraryProxyFactory class >> networkLibraryProxy [
	^ self defaultNetworkLibraryProxyClass proxy
]

{ #category : #'building socket proxies' }
OCNNetworkLibraryProxyFactory class >> proxyForLibraryClass: aLibraryClass [
	^aLibraryClass proxy
]
