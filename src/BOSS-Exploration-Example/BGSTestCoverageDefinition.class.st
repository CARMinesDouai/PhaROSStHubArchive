Class {
	#name : #BGSTestCoverageDefinition,
	#superclass : #TestCase,
	#category : #'BOSS-Kernel-Test'
}

{ #category : #coverage }
BGSTestCoverageDefinition class >> packageNamesUnderTest [
	^#('BotGridSimulator')
]

{ #category : #coverage }
BGSTestCoverageDefinition class >> testPackagesForContinuousIntegration [
	^SystemOrganization categories select: [:categoryName|
		'BotGridSimulator*Test*' match: categoryName]
]
