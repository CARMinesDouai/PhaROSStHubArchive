Class {
	#name : #OCNTcpServerSocketTest,
	#superclass : #OCNSocketTestOldDone,
	#instVars : [
		'serverProcess',
		'serverConversationSocket',
		'clientSocket'
	],
	#category : #'Ocean-KernelTests-Old'
}

{ #category : #'as yet unclassified' }
OCNTcpServerSocketTest class >> shouldBeSubclassedForBackendTesting [
	^true
]

{ #category : #accessing }
OCNTcpServerSocketTest >> socketClass [ 
	^OCNServerTcpSocket 
]

{ #category : #accessing }
OCNTcpServerSocketTest >> stateTestingSelectors [
	^#(isClean isBound isListening isDestroyed)
]

{ #category : #'setUp-tearDown' }
OCNTcpServerSocketTest >> tearDown [
	super tearDown.
	serverProcess ifNotNil: [serverProcess terminate].
	clientSocket ifNotNil: [clientSocket destroy].
	serverConversationSocket ifNotNil: [ serverConversationSocket destroy]
	
]

{ #category : #testing }
OCNTcpServerSocketTest >> testAcceptOneConnection [
	
	|dataToSend receivedData semaphore |

	semaphore := Semaphore new.

	serverProcess := [
		[socket listenOn: serverAddress.
		semaphore signal.
		serverConversationSocket := socket accept] 
		ensure: [socket destroy] ] fork.
	
	self deny: (semaphore waitTimeoutMSecs: 100).
	self assertSocketState: #isListening.
	
	(Delay forMilliseconds: 100) wait.
	clientSocket := OCNConversationTcpSocket newConnectedTo: serverAddress.
	(Delay forMilliseconds: 100) wait.
	self assert: clientSocket isConnected.
	self assert: serverConversationSocket isConnected.
	
	"server sends data to client"
	dataToSend := self randomAsciiStringOfSize: 100.
	serverConversationSocket send: dataToSend.
	(Delay forMilliseconds: 100) wait.
	receivedData := clientSocket receive asString.
	self assert: dataToSend = receivedData.
	
	"client sends data to server"
	 dataToSend := self randomAsciiStringOfSize: 90.
	clientSocket send: dataToSend.
	(Delay forMilliseconds: 100) wait.
	receivedData := serverConversationSocket receive asString.
	self assert: dataToSend = receivedData.
	
	
]

{ #category : #testing }
OCNTcpServerSocketTest >> testTwoSocketsListeningOnSamePort [
	
	| otherSocket |
	
	self assertSocketState: #isClean.
	socket listenOn: serverAddress.
	self assertSocketState: #isListening.
	
	otherSocket := OCNServerTcpSocket newWithNetworkLibraryClass: self networkLibraryClass.
	self should: [ otherSocket listenOn: serverAddress] raise: OCNSocketOperationFailureError.	
	self assert:  otherSocket isDestroyed.
	
	self assertSocketState: #isListening.
	
]
