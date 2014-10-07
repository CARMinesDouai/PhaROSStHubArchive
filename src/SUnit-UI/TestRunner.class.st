"
<lint: #ignore rule: #classNotReferenced rational: 'this view is only accessed from menus'>

Although tests can be most easily be run from a browser, I provide the ability to: 
* select sets of test suites to run. I am designed to make it easy to execute groups of tests
* obtain a more detailed log of the results 


UI Description 
___________ 

My left-most pane lists all of the categories that contain test classes (i.e., subclasses of TestCase); when some of these categories are selected, the test classes that they contain appear in the pane to the right. Abstract classes are italicized, and the test class hierarchy is shown by indentation, so subclasses of ClassTestCase are indented more than subclasses of TestCase. 

The tests that did not pass (if any) are listed in the right-hand panes of the Test Runner; if you want to debug one, to see why it failed, just click on the name.

"
Class {
	#name : #TestRunner,
	#superclass : #Model,
	#instVars : [
		'categories',
		'categoriesSelected',
		'classes',
		'classIndex',
		'classesSelected',
		'failedList',
		'failedSelected',
		'errorList',
		'errorSelected',
		'lastUpdate',
		'result',
		'previousRun',
		'categoryPattern',
		'classPattern',
		'testAnnouncementBlock'
	],
	#category : #'SUnit-UI'
}

{ #category : #'instance-creation' }
TestRunner class >> open [
	^ self new open
]

{ #category : #'window color' }
TestRunner class >> patchworkUIThemeColor [
	"Answer a default color for UI themes that make use of different colors for Browser, MessageList etc..."

	^ Color brown whiter
]

{ #category : #initialization }
TestRunner class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry register: self as: #testRunner
]

{ #category : #actions }
TestRunner >> addDeclaredPackagesUnderTestTo: packages [ 
	classesSelected do: 
		[ :class | 
		(class class includesSelector: #packageNamesUnderTest) ifTrue: 
			[ class packageNamesUnderTest do: [ :name | packages add: (RPackage organizer packageNamed: name) ] ] ]
]

{ #category : #actions }
TestRunner >> addMethodsUnderTestIn: packages to: methods [ 
	packages
		do: [:package | package isNil
				ifFalse: [package methodReferences
						do: [:method | ((#(#packageNamesUnderTest #classNamesNotUnderTest ) includes: method selector)
									or: [method compiledMethod isAbstract
											or: [method compiledMethod refersToLiteral: #ignoreForCoverage]])
								ifFalse: [methods add: method]]]]
]

{ #category : #accessing }
TestRunner >> allSelectedTestSuites [
	"Return the suite for all the selected test case classes"
	
	^ classesSelected select: [ :each | each isAbstract not] thenCollect: [:each | each suite].
]

{ #category : #factory }
TestRunner >> baseClass [
	^ TestCase
]

{ #category : #'accessing-classes' }
TestRunner >> browseClass [

	^ (classes at: classIndex ifAbsent: [ ^ self ]) browse
]

{ #category : #browsing }
TestRunner >> browseSelectedErrorTest [

	errorSelected ifNil: [^self].
	self browseSelectedTest: errorSelected
]

{ #category : #browsing }
TestRunner >> browseSelectedFailedTest [

	failedSelected ifNil: [^self].
	self browseSelectedTest: failedSelected
]

{ #category : #browsing }
TestRunner >> browseSelectedTest: aTest [

	Smalltalk tools browser fullOnClass: aTest class selector: aTest selector
]

{ #category : #private }
TestRunner >> browserEnvironment [
	^ Smalltalk globals classNamed: #BrowserEnvironment
]

{ #category : #building }
TestRunner >> build [
	"self new build openInWorld"
	
	| window |
	window := (SystemWindow labelled: self label) model: self; extent: self extent.
	
	window addMorph: self buildCategorySearch fullFrame: self categorySearchFrame.
	window addMorph: self buildCategories fullFrame: self categoriesFrame.
	
	window addMorph: self buildClassesSearch fullFrame: self classesSearchFrame.
	window addMorph: self buildClasses fullFrame: self classesFrame.
	
	window	addMorph: self buildStatus fullFrame: self statusFrame. 
	window	addMorph: self buildFailures fullFrame: self failureListFrame. 
	window	addMorph: self buildErrors fullFrame: self errorListFrame. 
	window	addMorph: self buildButtons fullFrame: self buttonsFrame. 
	^ window
	
	
	
]

{ #category : #building }
TestRunner >> buildButtons [
	^ PluggablePanelMorph newRow
		model: self;
		layoutInset: 0;
		color: Color transparent;
		addAllMorphs: (self buttons collect: [ :each |
			PluggableButtonMorph new
				on: self
				getState: nil
				action: each second
				label: nil
				menu: nil;
				label: each first;
				setBalloonText: each third;
				getEnabledSelector: (each at: 4);
				hResizing: #spaceFill;
				yourself ]);
		yourself.
]

{ #category : #building }
TestRunner >> buildCategories [

	^ PluggableListMorph new
		on: self
		list: #categoryList 
		primarySelection: #categorySelected 
		changePrimarySelection: #categorySelected: 
		listSelection: #categoryAt: 
		changeListSelection: #categoryAt:put: 
		menu: #categoryMenu:  
		keystroke: nil;
		yourself
]

{ #category : #building }
TestRunner >> buildCategorySearch [

	^ SearchMorph new
		model: self;
		updateSelector: #categorySearchUpdate:;
		yourself
]

{ #category : #building }
TestRunner >> buildClasses [

	^ PluggableListMorph new
		on: self
		list: #classList 
		primarySelection: #classSelected 
		changePrimarySelection: #classSelected: 
		listSelection: #classAt: 
		changeListSelection: #classAt:put: 
		menu: #classMenu:  
		keystroke: nil;
		yourself
]

{ #category : #building }
TestRunner >> buildClassesSearch [
	
	^ SearchMorph new
		model: self;
		updateSelector: #classSearchUpdate:;
		yourself
]

{ #category : #building }
TestRunner >> buildErrors [
	^ PluggableListMorph new
			on: self 
			list: #errorList
			selected: #errorSelected
			changeSelected: #errorSelected:
			menu: #errorMenu: 
			keystroke: nil.
	
]

{ #category : #building }
TestRunner >> buildFailures [
	^ PluggableListMorph new
			on: self 
			list: #failedList
			selected: #failedSelected
			changeSelected: #failedSelected:
			menu: #failureMenu: 
			keystroke: nil.
	
		" do not know how to express
		name: 'Failure List'"
]

{ #category : #newbuilding }
TestRunner >> buildStatus [

	^ (PluggableTextFieldMorph
		on: self 
		text: #statusText 
		accept: nil 
		readSelection: nil 
		menu: #statusMenu:)
			getColorSelector: #statusColor ; yourself.
	
]

{ #category : #building }
TestRunner >> buttonHeight [
	^ self theme buttonMinHeight + 4
]

{ #category : #'accessing-ui' }
TestRunner >> buttons [
	^ #(( 'Run Selected' #runAll 'Run all selected tests' #hasRunnable )
		( 'Run Profiled' #runProfiled 'Run tests and profile' #hasRunnable )
		( 'Run Coverage' #runCoverage 'Run test and check code coverage' #hasRunnable )
		( 'Run Failures' #runFailures 'Run all failures' #hasFailures )
		( 'Run Errors' #runErrors 'Run all errors' #hasErrors )
		( 'File out results' #fileOutResults 'File out test results' #hasFailuresOrErrors))
]

{ #category : #building }
TestRunner >> buttonsFrame [
	^LayoutFrame new topFraction: 1 offset: self buttonHeight negated
		
]

{ #category : #building }
TestRunner >> categoriesFrame [
	^LayoutFrame new
		rightFraction: 0.25;
		topOffset: (Smalltalk ui theme textFont height + 13);
		bottomOffset: self buttonHeight negated
]

{ #category : #'accessing-categories' }
TestRunner >> categoryAt: anIndex [
	^ categoriesSelected includes: (categories at: anIndex ifAbsent: [ ^ false ]).
]

{ #category : #'accessing-categories' }
TestRunner >> categoryAt: anInteger put: aBoolean [
	categoriesSelected := categoriesSelected
		perform: (aBoolean ifTrue: [ #copyWith: ] ifFalse: [ #copyWithout: ])
		with: (categories at: anInteger ifAbsent: [ ^ self ]).
	self changed: #categorySelected; updateClasses.
]

{ #category : #'accessing-categories' }
TestRunner >> categoryList [
	^ categories
]

{ #category : #'accessing-categories' }
TestRunner >> categoryMenu: aMenu [
	^ aMenu
		title: 'Categories';
		add: 'Select all' action: #selectAllCategories;
		add: 'Select inversion' action: #selectInverseCategories;
		add: 'Select none' action: #selectNoCategories;
		addLine;
		add: 'Filter...' action: #filterCategories;
		addLine;
		add: 'Refresh' action: #updateCategories;
		yourself.
]

{ #category : #building }
TestRunner >> categorySearchFrame [
	^LayoutFrame new
		rightFraction: 0.25;
		bottomFraction: 0 offset: (Smalltalk ui theme textFont height + 10)
]

{ #category : #building }
TestRunner >> categorySearchUpdate: aPattern [
	categoryPattern := (aPattern isNil or: [ aPattern trimBoth isEmpty ])
		ifTrue: [ nil ]
		ifFalse: [ aPattern asRegexIgnoringCase ].
	self updateCategories.
]

{ #category : #'accessing-categories' }
TestRunner >> categorySelected [
	^ 0
]

{ #category : #'accessing-categories' }
TestRunner >> categorySelected: anInteger [
	self changed: #categorySelected.
]

{ #category : #'accessing-classes' }
TestRunner >> classAt: anInteger [
	^ classesSelected includes: (classes at: anInteger ifAbsent: [ ^ false ]).
]

{ #category : #'accessing-classes' }
TestRunner >> classAt: anInteger put: aBoolean [
	classesSelected := classesSelected
		perform: (aBoolean ifTrue: [ #copyWith: ] ifFalse: [ #copyWithout: ])
		with: (classes at: anInteger ifAbsent: [ ^ self ]).
	self changed: #classSelected; changed: #hasRunnable.
]

{ #category : #factory }
TestRunner >> classForTestSuite [
	^ TestSuite
]

{ #category : #'accessing-classes' }
TestRunner >> classList [
	| offset |
	classes isEmpty ifTrue: [ ^ classes ].
	offset := classes first allSuperclasses size.
	^ classes collect: [ :each | | ident |
		ident := String 
			new: 2 * (0 max: each allSuperclasses size - offset) 
			withAll: $ .
		each isAbstract
			ifFalse: [ ident , each name ]
			ifTrue: [ 
				ident asText , each name asText 
					addAttribute: TextEmphasis italic;
					yourself ] ].
]

{ #category : #'accessing-classes' }
TestRunner >> classMenu: aMenu [
	^ aMenu
		title: 'Classes';
		add: 'Browse' action: #browseClass;
		addLine;
		add: 'Select all' action: #selectAllClasses;
		add: 'Select unit tests' action: #selectAllUnitTests;
		add: 'Select subclasses' action: #selectSubclasses;
		add: 'Select inversion' action: #selectInverseClasses;
		add: 'Select none' action: #selectNoClasses;
		add: 'Refresh' action: #updateClasses;
		addLine;
		add: 'Filter...' action: #filterClasses;
		addLine;
		add: 'Run selected' action: #runAll;
		yourself.
]

{ #category : #building }
TestRunner >> classSearchUpdate: aPattern [
	classPattern := (aPattern isNil or: [ aPattern trimBoth isEmpty ])
		ifTrue: [ nil ]
		ifFalse: [ aPattern asRegexIgnoringCase ].
	self updateClasses.
]

{ #category : #'accessing-classes' }
TestRunner >> classSelected [
	^ classIndex
]

{ #category : #'accessing-classes' }
TestRunner >> classSelected: anInteger [
	classIndex := anInteger.
	self changed: #classSelected
]

{ #category : #building }
TestRunner >> classesFrame [
	^LayoutFrame new
		leftFraction: 0.25;
		topOffset: (Smalltalk ui theme textFont height + 13);
		rightFraction: 0.5;
		bottomOffset: self buttonHeight negated
]

{ #category : #building }
TestRunner >> classesSearchFrame [
	^LayoutFrame new
		leftFraction: 0.25;
		rightFraction: 0.5;
		bottomFraction: 0 ;
		bottomOffset: (StandardFonts defaultFont height + 10)
]

{ #category : #actions }
TestRunner >> collectCoverageFor: methods [
	| wrappers suite |
	wrappers := methods collect: [ :each | TestCoverage on: each ].
	suite := self
		resetResult;
		suiteForAllSelected.
	
	[ wrappers do: [ :each | each install ].
	[ self runSuite: suite ] ensure: [ wrappers do: [ :each | each uninstall ] ] ] valueUnpreemptively.
	wrappers := wrappers reject: [ :each | each hasRun ].
	wrappers isEmpty 
		ifTrue: 
			[ UIManager default inform: 'Congratulations. Your tests cover all code under analysis.' ]
		ifFalse: 
			[ 
			| ml |
			ml := MessageList new.
			(wrappers collect: [ :each | ml addMethodReference: each reference ]).
			(Smalltalk tools messageList 
				on: ml
				named: 'Not Covered Code (' , (100 - (100 * wrappers size // methods size)) printString , '% Code Coverage)') open ].
	self saveResultInHistory
]

{ #category : #actions }
TestRunner >> debug: aTestCase [
	self
		debugSuite:
			(self classForTestSuite new
				addTest: aTestCase;
				yourself)
]

{ #category : #actions }
TestRunner >> debugSuite: aTestSuite [
	self executeSuite: aTestSuite as: [ :aSuite | aSuite debug ].
]

{ #category : #'accessing-testing' }
TestRunner >> errorList [
	^ errorList collect: [ :each | each printString ].
]

{ #category : #building }
TestRunner >> errorListFrame [
	^LayoutFrame new
		leftFraction: 0.5;
		topFraction: 0.5;
		bottomOffset: self buttonHeight negated
]

{ #category : #'accessing-menu' }
TestRunner >> errorMenu: aMenu [
	"Add the browse item only if an item is selected"

	self statusMenu: aMenu.
	errorSelected ifNotNil: [aMenu add: 'Browse test' action: #browseSelectedErrorTest].
	^aMenu
]

{ #category : #'accessing-testing' }
TestRunner >> errorSelected [
	^ errorList indexOf: errorSelected.
]

{ #category : #'accessing-testing' }
TestRunner >> errorSelected: anInteger [
	errorSelected := errorList at: anInteger ifAbsent: nil.
	self changed: #errorSelected.
	errorSelected ifNotNil: [ self debug: errorSelected ].
]

{ #category : #accessing }
TestRunner >> errorTestSuites [
	^ errorList
		collect: [ :each | 
			self classForTestSuite new
				in: [ :suite | 
							suite
								addTest: each;
								name: (self label: 'Error' forSuite: suite) ];
				yourself ]
]

{ #category : #actions }
TestRunner >> excludeClassesNotUnderTestFrom: methods [
	classesSelected
		do: [ :class | 
			(class class includesSelector: #classNamesNotUnderTest)
				ifTrue: [ 
					class classNamesNotUnderTest
						do: [ :className | 
							| theClass |
							theClass := Smalltalk globals classNamed: className.
							theClass
								ifNotNil: [ 
									theClass methods do: [ :each | methods remove: each methodReference ifAbsent: [  ] ].
									theClass class methods do: [ :each | methods remove: each methodReference ifAbsent: [  ] ] ] ] ] ]
]

{ #category : #processing }
TestRunner >> executeSuite: aTestSuite as: aBlock [
" The block defines how to interact with the suite. run with a result or debug "
	aTestSuite subscribe:TestAnnouncement do: self updateUIBlock.
	[ aBlock cull: aTestSuite cull: result  ] ensure: [
		aTestSuite unsubscribe:TestAnnouncement.
	].



]

{ #category : #'accessing-ui' }
TestRunner >> extent [
	^ 640 @ 480
]

{ #category : #'accessing-testing' }
TestRunner >> failedList [
	^ failedList collect: [ :each | each printString ].
]

{ #category : #'accessing-testing' }
TestRunner >> failedSelected [
	^ failedList indexOf: failedSelected.
]

{ #category : #'accessing-testing' }
TestRunner >> failedSelected: anInteger [
	failedSelected := failedList at: anInteger ifAbsent: nil.
	self changed: #failedSelected.
	failedSelected ifNotNil: [ self debug: failedSelected ].
]

{ #category : #building }
TestRunner >> failureListFrame [
	^LayoutFrame new
		leftFraction: 0.5;
		bottomFraction: 0.5;
		topOffset: self statusHeight
]

{ #category : #'accessing-menu' }
TestRunner >> failureMenu: aMenu [
	"Add the browse item only if an item is selected"
	
	failedSelected ifNotNil: [aMenu add: 'Browse test' action: #browseSelectedFailedTest].
	^ aMenu
]

{ #category : #accessing }
TestRunner >> failureTestSuites [
	^ failedList
		collect: [ :each | 
			self classForTestSuite new
				in: [ :suite | 
							suite
								addTest: each;
								name: (self label: 'Failure' forSuite: suite) ];
				yourself ]
]

{ #category : #actions }
TestRunner >> fileOutResults [
	"Save current test results into text file."
	"Generate a filename like 'tests_Version_23_May_2010_9-19-20_am.txt' "

	| fileName defaultFilename stream printer |
	defaultFilename := self generateDefaultFileOutResultsName.
						
						
	fileName := UIManager default 
		request: 'Enter the file name' 
		initialAnswer: defaultFilename.
	fileName ifNil: [^ self].
	stream := MultiByteFileStream newFileNamed: fileName.	
	[result fileOutOn: stream] 
		ensure: [stream close].
]

{ #category : #'accessing-categories' }
TestRunner >> filterCategories [
	| pattern |
	pattern := UIManager default 
		request: 'Pattern to select categories:' 
		initialAnswer: '*'.
	pattern isNil ifTrue: [ ^ self ].
	categoriesSelected := (categories 
		select: [ :each | pattern match: each ]) asSet.
	self changed: #allSelections; changed: #categorySelected; updateClasses
]

{ #category : #'accessing-classes' }
TestRunner >> filterClasses [
	| pattern |
	pattern := UIManager default 
		request: 'Pattern to select tests:' 
		initialAnswer: '*'.
	pattern isNil ifTrue: [ ^ self ].
	classesSelected := (classes select: [ :each | 
		pattern match: each name ]) asSet.
	self
		changed: #allSelections;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #utilities }
TestRunner >> findCategories [
	| visible |
	visible := Set new.
	self baseClass withAllSubclassesDo: [ :each |
		each category ifNotNil: [ :category |
			visible add: category ] ].
	^ Array streamContents: [ :stream |
		Smalltalk organization categories do: [ :each |
			((visible includes: each) 
					and: [ categoryPattern isNil or: [ (categoryPattern matchesIn: each) isEmpty not]])
				ifTrue: [ stream nextPut: each ] ] ].
]

{ #category : #utilities }
TestRunner >> findClassesForCategories: aCollection [
	| items |
	aCollection isEmpty
		ifTrue: [ ^ self baseClass withAllSubclasses asSet ].
	items := aCollection
		gather: [ :category | 
			((Smalltalk organization listAtCategoryNamed: category) 
				collect: [ :each | Smalltalk globals at: each ])
				select: [ :each | each includesBehavior: self baseClass ] ].

	^ items asSet
]

{ #category : #actions }
TestRunner >> generateDefaultFileOutResultsName [
	
	| filename |
	filename := String
		streamContents: [ :st | 
			| printedDate |
			st nextPutAll: 'tests_'.
			st nextPutAll: SystemVersion current version.
			st nextPutAll: '_'.
			result timeStamp printYMDOn: st.
			st nextPutAll: '_'.
			result timeStamp printHMSOn: st.
			st nextPutAll: '.txt' ].
	^ filename copyReplaceAll: ':' with: '-'.
]

{ #category : #testing }
TestRunner >> hasErrors [
	^ result hasErrors.
]

{ #category : #testing }
TestRunner >> hasFailures [
	^ result hasFailures.
]

{ #category : #testing }
TestRunner >> hasFailuresOrErrors [
	^ result hasFailures | result hasErrors.
]

{ #category : #'history saving' }
TestRunner >> hasProgress [

	result classesTested do: [:cls |
		(cls class includesSelector: #lastStoredRun)
			ifTrue: [^ true]].
	^ false
]

{ #category : #'history saving' }
TestRunner >> hasResults [

	^ result notNil
]

{ #category : #testing }
TestRunner >> hasRunnable [
	^ classesSelected notEmpty.
]

{ #category : #'history saving' }
TestRunner >> historyMenuList [
	^ {'** save current result **'}, (self previousRun collect: [:ts | ts printString])
]

{ #category : #initialization }
TestRunner >> initialize [
	super initialize.
	failedList := errorList := Array new.
	SystemAnnouncer uniqueInstance weak
		on: ClassAdded, CategoryAdded, ClassRemoved, CategoryRemoved, ClassRenamed, CategoryRenamed, ClassRecategorized 
			send: #update 
			to: self.
	self update; resetResult
]

{ #category : #'accessing-ui' }
TestRunner >> label [
	^ 'Test Runner' 
]

{ #category : #private }
TestRunner >> label: aString forSuite: aTestSuite [
	^ String streamContents: [ :stream |
		stream nextPutAll: 'Running '; print: aTestSuite tests size; space; nextPutAll: aString.
		aTestSuite tests size > 1 ifTrue: [ stream nextPut: $s ] ]. 
]

{ #category : #building }
TestRunner >> open [

	^ self build openInWorld
	

]

{ #category : #'history saving' }
TestRunner >> previousRun [

	^ previousRun ifNil: [ previousRun := OrderedCollection new ]
]

{ #category : #actions }
TestRunner >> promptForPackages [
	| packages |
	packages := (RPackageOrganizer default packages
				reject: [:package | (package packageName beginsWith: 'Kernel')
						or: [(package packageName beginsWith: 'Collections')
								or: [(package packageName beginsWith: 'Exceptions')
										or: [(package packageName beginsWith: 'SUnit')
												or: [(package packageName beginsWith: 'System')
														or: [package packageName includesSubstring: 'Test' caseSensitive: false]]]]]])
				sort: [:a :b | a packageName < b packageName].
	packages := Array
				with: (UIManager default
						chooseFrom: (packages
								collect: [:package | package packageName])
						values: packages
						title: 'Select Package').
	^ packages
]

{ #category : #'accessing-testing' }
TestRunner >> result [
	^ result
]

{ #category : #'accessing-testing' }
TestRunner >> result: aResult [
	result := aResult
]

{ #category : #actions }
TestRunner >> runAll [

	self resetResult.
	self runTestSuites: self allSelectedTestSuites.
	self saveResultInHistory
]

{ #category : #actions }
TestRunner >> runCoverage [
	| packages methods |
	packages := Set new.
	self addDeclaredPackagesUnderTestTo: packages.
	packages isEmpty ifTrue: 
		[ packages := self promptForPackages ].
	methods := OrderedCollection new.
	self 
		addMethodsUnderTestIn: packages
		to: methods.
	self excludeClassesNotUnderTestFrom: methods.
	methods isEmpty ifTrue: 
		[ ^ UIManager default inform: 'No methods found for coverage analysis.' ].
	self collectCoverageFor: methods

]

{ #category : #actions }
TestRunner >> runErrors [
	self result instVarNamed: 'errors' put: OrderedCollection new.
	self runTestSuites: self errorTestSuites.
]

{ #category : #actions }
TestRunner >> runFailures [
	self result instVarNamed: 'failures' put: Set new.
	self runTestSuites: self failureTestSuites.
]

{ #category : #actions }
TestRunner >> runProfiled [
	MessageTally spyOn: [ self runAll ].
]

{ #category : #actions }
TestRunner >> runSuite: aTestSuite [
	self executeSuite: aTestSuite as: [ :aSuite :aResult | aSuite run: aResult ].
	self updateResults


]

{ #category : #actions }
TestRunner >> runTest: aTestCase [
	aTestCase run: result.
	self updateStatus: true.
]

{ #category : #actions }
TestRunner >> runTestSuites: testSuites [ 
	testSuites
		do: [:testSuite | self runSuite: testSuite]
		displayingProgress: 'Running Tests'
]

{ #category : #'history saving' }
TestRunner >> saveResultInHistory [
	result dispatchResultsIntoHistory
]

{ #category : #'accessing-categories' }
TestRunner >> selectAllCategories [
	categoriesSelected := categories asSet.
	self changed: #allSelections; changed: #categorySelected; updateClasses
]

{ #category : #'accessing-classes' }
TestRunner >> selectAllClasses [
	"Fixed to update all selections now that the
	selection invalidation has been optimised."
	
	classesSelected := classes asSet.
	self
		changed: #allSelections;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'accessing-classes' }
TestRunner >> selectAllUnitTests [
	classesSelected := classes asSet select: [ :eachClass | eachClass isUnitTest ].
	self
		changed: #allSelections;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'accessing-categories' }
TestRunner >> selectInverseCategories [
	categoriesSelected := categories asSet 
		removeAll: categoriesSelected;
		yourself.
	self changed: #allSelections; changed: #categorySelected; updateClasses
]

{ #category : #'accessing-classes' }
TestRunner >> selectInverseClasses [
	"Fixed to update all selections now that the
	selection invalidation has been optimised."
	
	classesSelected := classes asSet 
		removeAll: classesSelected;
		yourself.
	self
		changed: #allSelections;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'accessing-categories' }
TestRunner >> selectNoCategories [
	categoriesSelected := Set new.
	self changed: #allSelections; changed: #categorySelected; updateClasses
]

{ #category : #'accessing-classes' }
TestRunner >> selectNoClasses [
	"Fixed to update all selections now that the
	selection invalidation has been optimised."
	
	classesSelected := Set new.
	self
		changed: #allSelections;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'accessing-classes' }
TestRunner >> selectSubclasses [
	"Fixed to update all selections now that the
	selection invalidation has been optimised."
	
	| classesForPackages |
	classesForPackages := self findClassesForCategories: categoriesSelected.	
	classesSelected := (classesSelected gather: [ :class |
		class withAllSubclasses select: [ :each |
			classesForPackages includes: each ] ])
		asSet.
	self
		changed: #allSelections;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'history saving' }
TestRunner >> showDiffWith: aTestResult [
	| string diff |

	diff := result diff: aTestResult.
	string := String streamContents: [:str|
		str nextPutAll: '----------------'; cr.
		str nextPutAll: 'Diff between current result with: ', aTestResult asString; cr.
		str nextPutAll: 'New passed: '.
		diff first do: [:s| str nextPutAll: s printString, ' '].
		str cr.
		str nextPutAll: 'New failures: '.
		diff second do: [:s| str nextPutAll: s printString, ' '].
		str cr.
		
		str nextPutAll: 'New errors: '.
		diff third do: [:s| str nextPutAll: s printString, ' '].
		str cr].
	
	Smalltalk tools workspace new contents: string; openLabel: 'SUnit Progress'
	
]

{ #category : #'history saving' }
TestRunner >> showHistoryMenu [
	| selectionIndex selectedPreviousResult actionIndex |
	selectionIndex := UIManager default chooseFrom: self historyMenuList title: 'History:'.

	"We pressed outside the menu"
	selectionIndex isZero ifTrue: [ ^ self ]. 				

	"save current result is selected"
	selectionIndex = 1 ifTrue: [ self previousRun addFirst: result. ^ self ]. 			

	selectedPreviousResult := self previousRun at: (selectionIndex - 1).
 	actionIndex := (UIManager default chooseFrom: #('delete' 'show diff')  title:  'Action:').
	actionIndex = 1 ifTrue: [ self previousRun remove: selectedPreviousResult. ^ self ].
	actionIndex = 2 ifTrue: [ self showDiffWith: selectedPreviousResult].	
]

{ #category : #'history saving' }
TestRunner >> showProgress [
	| testCaseClasses d string |
	testCaseClasses := (self suiteForAllSelected tests collect: [:testCase | testCase class]) asSet.
	
	"At the end of the algorithm, d will contains all the diff between what was saved and the current result"
	d := Dictionary new.
	d at: #passed put: OrderedCollection new.
	d at: #failures put: OrderedCollection new.
	d at: #errors put: OrderedCollection new.

	testCaseClasses do: [ :cls | | t |
		(cls class includesSelector: #lastStoredRun)
			ifTrue: [t := cls lastStoredRun.
					(t at: #passed) do: [:s | 	
											(result isErrorFor: cls selector: s)
												ifTrue: [(d at: #errors) add: {cls . s}].
											(result isFailureFor: cls selector: s)
												ifTrue: [(d at: #failures) add: {cls . s}]  ].
											
					(t at: #failures) do: [:s | (result isPassedFor: cls selector: s)
												ifTrue: [(d at: #passed) add: {cls . s}].
											(result isErrorFor: cls selector: s)
												ifTrue: [(d at: #errors) add: {cls . s}]].
											
					(t at: #errors) do: [:s | 	(result isPassedFor: cls selector: s)
												ifTrue: [(d at: #passed) add: {cls . s}].
											(result isFailureFor: cls selector: s)
												ifTrue: [(d at: #failures) add: {cls . s}]]]].
		
			
	string := String streamContents: [:str|
		str nextPutAll: '----------------'; cr.
		str nextPutAll: 'Diff between current result and saved result'; cr.
		str nextPutAll: 'New passed: '.
		(d at: #passed) do: [:s| str nextPutAll: s printString, ' '].
		str cr.
		str nextPutAll: 'New failures: '.
		(d at: #failures) do: [:s| str nextPutAll: s printString, ' '].
		str cr.
		
		str nextPutAll: 'New errors: '.
		(d at: #errors) do: [:s| str nextPutAll: s printString, ' '].
		str cr].
	
	Smalltalk tools workspace new contents: string; openLabel: 'SUnit Progress' string.

	
]

{ #category : #utilities }
TestRunner >> sortClass: aFirstClass before: aSecondClass [
	| first second |
	first := aFirstClass withAllSuperclasses reversed.
	second := aSecondClass withAllSuperclasses reversed.
	1 to: (first size min: second size) do: [ :index | 
		(first at: index) == (second at: index)
			ifFalse: [ ^ (first at: index) name <= (second at: index) name ] ].
	^ second includes: aFirstClass.
]

{ #category : #'accessing-testing' }
TestRunner >> statusColor [
	result hasErrors 
		ifTrue: [ ^ Color red ].
	result hasFailures 
		ifTrue: [ ^ Color yellow ].
	^ Color green
]

{ #category : #building }
TestRunner >> statusFrame [
	^ LayoutFrame new
		leftFraction: 0.5;
		bottomFraction: 0 offset: self statusHeight
]

{ #category : #building }
TestRunner >> statusHeight [
	^ self theme textFont height * 4
]

{ #category : #'accessing-menu' }
TestRunner >> statusMenu: aMenu [
	^ aMenu
		add: 'History' action: #showHistoryMenu;
		add: 'Store result as progress reference' action: #storeResultIntoTestCases;
		add: 'Show progress' action: #showProgress; 
		yourself
]

{ #category : #'accessing-testing' }
TestRunner >> statusText [
	^ result printString.
]

{ #category : #'history saving' }
TestRunner >> storeResultIntoTestCases [

	result classesTested do: [:testCaseCls | testCaseCls generateLastStoredRunMethod ]

]

{ #category : #accessing }
TestRunner >> suiteForAllSelected [
	"Return the suite for all the selected test case classes"

	^ self classForTestSuite new
		in: [ :suite | 
			classesSelected
				do: [ :each | 
					each isAbstract
						ifFalse: [ each addToSuiteFromSelectors: suite ] ].
			suite name: (self label: 'Test' forSuite: suite) ]
]

{ #category : #updating }
TestRunner >> update [
	self updateCategories; updateClasses
]

{ #category : #updating }
TestRunner >> updateCategories [
	categories := self findCategories.
	categoriesSelected := categoriesSelected isNil
		ifTrue: [ Set new ]
		ifFalse: [
			categoriesSelected
				select: [ :each | categories includes: each ] ].
	self changed: #categoryList; changed: #categorySelected.
]

{ #category : #updating }
TestRunner >> updateClasses [
	| classesForCategories |
	classesForCategories := self findClassesForCategories: categoriesSelected.
	
	classPattern ifNotNil: [
		classesForCategories := classesForCategories reject: [:cls| (classPattern matchesIn: cls name) isEmpty ]].
	
	classes := classesForCategories asArray
		sort: [ :a :b | self sortClass: a before: b ].
	classIndex := 0.
	classesSelected := classesSelected isNil
		ifTrue: [ classesForCategories ]
		ifFalse: [ 
			classesSelected
				select: [ :each | classesForCategories includes: each ] ].
	self changed: #classList; 
		changed: #classSelected; 
		changed: #hasRunnable.
]

{ #category : #updating }
TestRunner >> updateResults [
	"<lint: #expect rule: #guardingClause>"
	"<lint: #expect rule: #longMethods>"

	self updateStatus: false.
	failedList size = result failures size ifFalse: [
		failedList := result failures asArray
			sort: [ :a :b | a printString <= b printString ].
		failedSelected := nil.
		self 
			changed: #failedList; 
			changed: #failedSelected;
			changed: #hasFailures;
			changed: #hasProgress;
			changed: #hasFailuresOrErrors  ].
	errorList size = result errors size ifFalse: [
		errorList := result errors asArray
			sort: [ :a :b | a printString <= b printString ].
		errorSelected := nil.
		self 
			changed: #errorList; 
			changed: #errorSelected;
			changed: #hasErrors;
			changed: #hasProgress;
			changed: #hasFailuresOrErrors  ].
]

{ #category : #updating }
TestRunner >> updateStatus: aBoolean [
	"Update the status display, at most once a second if aBoolean is true."

	(aBoolean and: [ lastUpdate = Time totalSeconds ])
		ifTrue: [ ^ self ].
	self changed: #statusText; changed: #statusColor.
	lastUpdate := Time totalSeconds.
]

{ #category : #updating }
TestRunner >> updateUIBlock [
	^ testAnnouncementBlock ifNil: [
		testAnnouncementBlock :=  [ :announcement | self updateStatus: true ] ].
]

{ #category : #private }
TestRunner >> windowIsClosing [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
