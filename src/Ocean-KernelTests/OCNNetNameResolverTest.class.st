Class {
	#name : #OCNNetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests'
}

{ #category : #coverage }
OCNNetNameResolverTest class >> packageNamesUnderTest [
	^ #('Ocean-Kernel' 'Ocean-LibraryPlugin')
]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLocalHostName [
	
	self assert: OCNNetNameResolver localHostName notEmpty
]

{ #category : #'tests loopback' }
OCNNetNameResolverTest >> testLoopBackName [
	
	self assert: OCNNetNameResolver loopBackName = 'localhost' 
]
