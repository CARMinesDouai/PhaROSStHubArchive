Class {
	#name : #OCNTcpServerSocketTest,
	#superclass : #OCNSocketTest,
	#instVars : [
		'serverProcess',
		'serverConversationSocket',
		'clientSocket'
	],
	#category : #'Ocean-KernelTests'
}

{ #category : #'as yet unclassified' }
OCNTcpServerSocketTest class >> isAbstract [
	^false
]

{ #category : #'as yet unclassified' }
OCNTcpServerSocketTest class >> shouldBeSubclassedForBackendTesting [
	^true
]

{ #category : #accessing }
OCNTcpServerSocketTest >> socketClass [ 
	^OCNServerTcpSocket 
]

{ #category : #'setUp-tearDown' }
OCNTcpServerSocketTest >> tearDown [
	super tearDown.
	serverProcess ifNotNil: [serverProcess terminate].
	clientSocket destroy.
	serverConversationSocket destroy
	
]

{ #category : #testing }
OCNTcpServerSocketTest >> testAcceptOneConnection [
	
	|dataToSend receivedData |

	serverProcess := [
		[socket listenOn: serverAddress.
		serverConversationSocket := socket accept] 
		ensure: [socket destroy] ] fork.
	
	clientSocket := OCNConversationTcpSocket newConnectedTo: serverAddress.
	self assert: clientSocket isConnected.
	self assert: serverConversationSocket isConnected.
	
	"server sends data to client"
	dataToSend := self randomAsciiStringOfSize: 100.
	serverConversationSocket send: dataToSend.
	receivedData := clientSocket receive.
	self assert: dataToSend = receivedData.
	
	"client sends data to server"
	 dataToSend := self randomAsciiStringOfSize: 90.
	clientSocket send: dataToSend.
	receivedData := serverConversationSocket receive.
	self assert: dataToSend = receivedData.
	
]
