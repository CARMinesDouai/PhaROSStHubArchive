Class {
	#name : #OCNNetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLocalHostName [
	
	self assert: OCNNetNameResolver localHostName notEmpty
]

{ #category : #'tests loopback' }
OCNNetNameResolverTest >> testLoopBackName [
	
	self assert: OCNNetNameResolver loopBackName = 'localhost' 
]
