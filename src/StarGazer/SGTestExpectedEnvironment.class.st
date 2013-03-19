Class {
	#name : #SGTestExpectedEnvironment,
	#superclass : #SGTestCase,
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGTestExpectedEnvironment >> testOpenDefaultPort [
	self withDefaultPort: [: port  | 
		self assert: port readString isString  description: ' error reading from port. Assure that you have privileges to read / write the default port ' 
	].

]
