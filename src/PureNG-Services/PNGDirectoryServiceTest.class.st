Class {
	#name : #PNGDirectoryServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGDirectoryServiceTest >> testGet [
	| services serviceClasses expectedClasses |
	services := robot directoryService get.
	self assert: services size = robot services size.
	serviceClasses := services collect: [:each| each class].
	expectedClasses := robot services collect: [:each| each class].
	self assert: (expectedClasses copyWithoutAll: serviceClasses) isEmpty 
]
