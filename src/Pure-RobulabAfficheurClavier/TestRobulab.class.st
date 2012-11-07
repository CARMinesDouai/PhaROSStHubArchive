Class {
	#name : #TestRobulab,
	#superclass : #TestCase,
	#instVars : [
		'robulab'
	],
	#category : #'Pure-Robulab'
}

{ #category : #'initialize-release' }
TestRobulab >> initialize [  
	robulab := Robulab new.
]

{ #category : #TestSurRequetes }
TestRobulab >> testEnTeteDeRequete: unMessageString [
	|reponse |
	"Test si le message est bien de type 'requête' et pas du type 'notification' "
	self assert: ((unMessageString at: 1 )asString , (unMessageString at:2) asString~= 'FF').
	reponse := (robulab sendMessageAndWaitResponse: unMessageString ) .
	"Test que les 4 premiers nombres de la réponse sont égaux aux quatres premiers nombres de la requête"
	self assert:( ((unMessageString at: 1 )asString , (unMessageString at:2) asString )= (reponse idRequete )).
	self assert: ( ((unMessageString at:3 )asString , (unMessageString at:4) asString )= (reponse action )).
	self assert: ( ((unMessageString at: 5 )asString , (unMessageString at:6) asString, (unMessageString at: 7 )asString , (unMessageString at:8) asString  ) = (reponse target)).
	"Test que le code d'erreur est bien à 0"
	self assert: ( reponse erreur = '00').
]

{ #category : #TestSurRequetes }
TestRobulab >> testIncrementationDesRequetes [
	| message index indexHexa |
	message := Array new.
	index := 1.
	indexHexa := '01'.
	257 timesRepeat: [
		((index printStringBase: 16) size = 1)
		ifTrue: [indexHexa:= ('0',(index printStringBase: 16))asString ]
		ifFalse: [indexHexa:= (index printStringBase: 16)].
		self assert: (robulab idRequete = indexHexa).
		message:= robulab incrementIdRequete.
		index := index + 1.
		(index = 255)ifTrue: [index:= 1 ]
		].
      
	
]

{ #category : #TestInitialisationConstantes }
TestRobulab >> testInitialisationDesServices [
	"On vérifie qu'il y a bien 8 services"
	self assert: ((robulab directoryService services size) = 7).
	"On vérifie que les 8 instances de services correspondent bien au bon code type"
	self assert: ((robulab directoryService services at:'0001') type ='0001' ).
	self assert: ((robulab directoryService services at:'0002') type ='4001' ).
	self assert: ((robulab directoryService services at:'0003') type ='4005' ).
	self assert: ((robulab directoryService services at:'0004') type ='4004' ).
	self assert: ((robulab directoryService services at:'0005') type ='8002' ).
	self assert: ((robulab directoryService services at:'0006') type ='4008' ).
	self assert: ((robulab directoryService services at:'0007') type ='4008' ).
	
]

{ #category : #TestSurRequetes }
TestRobulab >> testRequetesBasiques [
	self testEnTeteDeRequete:'01000000'
]
