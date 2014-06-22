Extension { #name : #TestRunner }

{ #category : #'*ForkIT' }
TestRunner >> buttons [
	^ #(( 'Run Selected' #runAll 'Run all selected tests' #hasRunnable )
		( 'Run selected as fork' #forkedRunAll 'Run all selected tests in a background image' #hasRunnable )
		( 'Run Profiled' #runProfiled 'Run tests and profile' #hasRunnable )
		( 'Run Coverage' #runCoverage 'Run test and check code coverage' #hasRunnable )
		( 'Run Failures' #runFailures 'Run all failures' #hasFailures )
		( 'Run Errors' #runErrors 'Run all errors' #hasErrors )
		( 'File out results' #fileOutResults 'File out test results' #hasFailuresOrErrors))
]

{ #category : #'*ForkIT' }
TestRunner >> forkedRunAll [
	| future | 
	(UIManager default confirm: ' To execute tests as a fork, you need first to save the image. If you press yes, the image will be saved and test executed in a fork. ' trueChoice: 'Yes' falseChoice: 'No' ) ifTrue: [ 
		Smalltalk snapshot: true andQuit: false.
		self resetResult.
		future := self forkedRunTestSuites: self allSelectedTestSuites.
		result := future asResult.
		future onSuccess: [  
				UIManager default alert: 'Tests runned on remote image' title: 'ForkedRunner'.
				self updateResults.
				self saveResultInHistory.			
		 ].
	]
	
	
]

{ #category : #'*ForkIT' }
TestRunner >> forkedRunTestSuites: testSuites [ 
	^ [testSuites
		do: [:testSuite | self executeSuite: testSuite as: [ :aSuite :aResult | aSuite run: aResult ]. ]
		displayingProgress: 'Running Tests' .
		result ] forkIt.
]
