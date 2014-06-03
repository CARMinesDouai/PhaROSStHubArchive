"
change class side shouldInheritSelectors to true to benefit from other Zdc tests

"
Class {
	#name : #OCNSimpleSocketStreamTests,
	#superclass : #ZdcSimpleSocketStreamTests,
	#category : #'Ocean-ZincZodiacIntegration'
}

{ #category : #testing }
OCNSimpleSocketStreamTests class >> shouldInheritSelectors [
	"I should inherit from an Abstract superclass but not from a concrete one by default, unless I have no testSelectors in which case I must be expecting to inherit them from my superclass.  If a test case with selectors wants to inherit selectors from a concrete superclass, override this to true in that subclass."
	^false
"	^true"
]

{ #category : #accessing }
OCNSimpleSocketStreamTests class >> socketStreamClass [
	^ OCNSimpleSocketStream 
]

{ #category : #private }
OCNSimpleSocketStreamTests >> referenceSocketStreamOn: socket [
	^ self socketStreamClass 
		on: socket
]

{ #category : #private }
OCNSimpleSocketStreamTests >> serverSocketOn: port [
	^ ZnNetworkingUtils default 
			serverSocketOn: port  
]

{ #category : #running }
OCNSimpleSocketStreamTests >> setUp [
	super setUp.
	"OCNInstaller makesZincUseOcean "
]

{ #category : #private }
OCNSimpleSocketStreamTests >> socketStreamClass [
	^ OCNSimpleSocketStream 
]

{ #category : #running }
OCNSimpleSocketStreamTests >> tearDown [
	super tearDown.
	"OCNInstaller makesZincUseOldNetwork "
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testAddOneEcho [
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket | | clientSocket stream data |
		clientSocket := serverSocket waitForAcceptFor: 10.
		stream := self socketStreamOn: clientSocket.
		data := stream next.
		stream nextPut: ((data + 1) bitAnd: 16rff).  
		stream close ].
	dataSent := 99.
	clientStream := self openConnectionToHostNamed: 'localhost' port: self port.
	clientStream nextPut: dataSent; flush.
	dataRead := clientStream next.
	clientStream close.
	self assert: dataRead = (dataSent + 1).
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientRead [
	| dataSent dataRead clientStream semaphore |
	dataSent := #[ 6 5 4 3 2 1 ].
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		self assert: (serverSocket isKindOf: OCNServerTcpSocket).
		clientSocket := serverSocket waitForAcceptFor: 10.
		self assert: (clientSocket isKindOf: OCNConversationTcpSocket).
		serverStream := self referenceSocketStreamOn: clientSocket.
		serverStream nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	self assert: (clientStream socket isKindOf: OCNConversationTcpSocket).
	dataRead := clientStream upToEnd.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait.
	
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientRead10k [
	| dataSent dataRead clientStream semaphore |
	dataSent := self bytes: 10000.
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		serverStream nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	dataRead := clientStream upToEnd.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientRead10kInPieces1 [
	| dataSent dataRead clientStream semaphore |
	dataSent := self bytes: 10000.
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		serverStream nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	dataRead := ByteArray new: 10000 streamContents: [ :stream |
		10 timesRepeat: [ stream nextPutAll: (clientStream next: 1000) ] ].
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientRead10kInPieces2 [
	| dataSent dataRead clientStream semaphore |
	dataSent := self bytes: 10000.
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		serverStream nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	dataRead := ByteArray new: 10000.
	0 to: 9 do: [ :index | 
		clientStream next: 1000 into: dataRead startingAt: (index * 1000) + 1 ].
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientSkip [
	| dataSent dataRead clientStream semaphore |
	dataSent := #[ 6 5 4 3 2 1 ].
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		serverStream nextPut: 0; nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	dataRead := clientStream skip: 1; upToEnd.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientSkip10k [
	| dataSent dataRead clientStream semaphore |
	dataSent := #[ 6 5 4 3 2 1 ].
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		10000 timesRepeat: [ serverStream nextPut: 0 ].  
		serverStream nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	dataRead := clientStream skip: 10000; upToEnd.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientWrite [
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		dataRead := serverStream upToEnd.
		serverStream close.
		mySemaphore signal ].
	dataSent := #[ 1 2 3 4 5 6 ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	clientStream nextPutAll: dataSent.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientWrite10k [
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		dataRead := serverStream upToEnd.
		serverStream close.
		mySemaphore signal ].
	dataSent := self bytes: 10000.
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	clientStream nextPutAll: dataSent.
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testPlainClientWrite10kInPieces [
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		dataRead := serverStream upToEnd.
		serverStream close.
		mySemaphore signal ].
	dataSent := self bytes: 10000.
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	0 to: 9 do: [ :index |
		clientStream next: 1000 putAll: dataSent startingAt: (1000 * index) + 1 ].
	clientStream close.
	semaphore wait.
	self assert: dataSent = dataRead.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testReverseEcho [
	| dataSent dataRead clientStream semaphore data |
	semaphore := self runServer: [ :serverSocket | | clientSocket stream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		stream := self socketStreamOn: clientSocket.
		data := stream upTo: 0.
		stream nextPutAll: data reverse; nextPut: 0.  
		stream close ].
	
	dataSent := #[ 1 2 3 4 5 6 ].
	clientStream := self openConnectionToHostNamed: 'localhost' port: self port.
	clientStream nextPutAll: dataSent; nextPut: 0; flush.
	dataRead := clientStream upTo: 0.
	clientStream close.
	self assert: dataRead = dataSent reverse.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testReverseEcho10kFixed [
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket | | clientSocket stream data |
		clientSocket := serverSocket waitForAcceptFor: 10.
		stream := self socketStreamOn: clientSocket.
		data := stream next: 10000.
		stream nextPutAll: data reverse.  
		stream close ].
	dataSent := self bytes: 10000.
	clientStream := self openConnectionToHostNamed: 'localhost' port: self port.
	clientStream nextPutAll: dataSent; flush.
	dataRead := clientStream next: 10000.
	clientStream close.
	self assert: dataRead = dataSent reverse.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testReverseEcho10kSearch [
	| dataSent dataRead clientStream semaphore |
	semaphore := self runServer: [ :serverSocket | | clientSocket stream data |
		clientSocket := serverSocket waitForAcceptFor: 10.
		stream := self socketStreamOn: clientSocket.
		data := stream upTo: 0.
		stream nextPutAll: data reverse; nextPut: 0.  
		stream close ].
	dataSent := (self bytes: 10000) replace: [ :each | each max: 1 ].
	clientStream := self openConnectionToHostNamed: 'localhost' port: self port.
	clientStream nextPutAll: dataSent; nextPut: 0; flush.
	dataRead := clientStream upTo: 0.
	clientStream close.
	self assert: dataRead = dataSent reverse.
	semaphore wait
]

{ #category : #testing }
OCNSimpleSocketStreamTests >> testReverseEchoUpToEnd [
	"self run: #testReverseEchoUpToEnd"
	| dataSent dataRead clientStream semaphore data |
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket stream |	
		clientSocket := serverSocket waitForAcceptFor: 20.
		stream := self socketStreamOn: clientSocket.
		"Doing #upToEnd here does not seem to work"
		data := stream next: 6.
		stream nextPutAll: data reverse.  
		stream close ].
	
"	self runClient: [ "
		dataSent := #[ 1 2 3 4 5 6 ].
		clientStream := self openConnectionToHostNamed: 'localhost' port: self port.
		clientStream nextPutAll: dataSent; flush.		
		dataRead := clientStream upToEnd.
		clientStream close.
		
		self assert: dataRead = dataSent reverse.
		semaphore wait 
"	]"
]
