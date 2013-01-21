Class {
	#name : #TestRobulab,
	#superclass : #TestCase,
	#instVars : [
		'robulab'
	],
	#category : #'PureNoLog-Test-RobotDependent'
}

{ #category : #TestInitialisationConstantes }
TestRobulab >> profileServiceInitialization [
" self new profileServiceInitialization "
	TimeProfiler spyOn: [
		self setUp.
		self testServiceInitialization.
		self tearDown.
	].

]

{ #category : #'initialize-release' }
TestRobulab >> setUp [
	super setUp.  
	robulab := Robulab newWith: #[192 168 1 2] and: 60000.
]

{ #category : #TestSurRequetes }
TestRobulab >> testBasicRequest [	
	| unMessageString reponse |

	unMessageString := '0100000000'.

	reponse := (robulab sendMessageAndWaitResponse: unMessageString ) .
	"Test que les 4 premiers nombres de la réponse sont égaux aux quatres premiers nombres de la requête"
	self assert: ( ((unMessageString at:1 )asString , (unMessageString at:2) asString ) asNumber = (reponse action )).
	self assert: ( ((unMessageString at: 3 )asString , (unMessageString at:4) asString, (unMessageString at: 5 )asString , (unMessageString at:6) asString  ) asNumber  = (reponse target) getInstanceNumber ).
	"Test que le code d'erreur est bien à 0"
	self assert:  reponse success 
]

{ #category : #TestInitialisationConstantes }
TestRobulab >> testServiceInitialization [
		robulab directoryService services do: [ :service|
			service class = (PureConstants serviceClassPerType at: service type)	
		].


]
