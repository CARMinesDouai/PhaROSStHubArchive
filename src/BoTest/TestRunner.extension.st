Extension { #name : #TestRunner }

{ #category : #'*BoTest' }
TestRunner >> resetResult [

	self result: BoTestResult new; updateResults.
]
