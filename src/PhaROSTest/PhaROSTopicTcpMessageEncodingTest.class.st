Class {
	#name : #PhaROSTopicTcpMessageEncodingTest,
	#superclass : #TestCase,
	#instVars : [
		'message'
	],
	#category : #'PhaROSTest-Network-Tcp'
}

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> assertEncodedEqualsExpectedInFirst: netSize ofLastElements: rawSize [
	|encoded expected|
	encoded := ((PhaROSHSMessageEncoder encode: message) last: rawSize) first: netSize.
	expected := (self expectedByteArray last:  rawSize) first: netSize.
	self assert: encoded = expected
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> assertEncodedEqualsExpectedInLast: netSize ofFirstElements: rawSize [
	|encoded expected|
	encoded := ((PhaROSHSMessageEncoder encode: message) first: rawSize) last: netSize.
	expected := (self expectedByteArray first:  rawSize) last: netSize.
	self assert: encoded = expected
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> expectedByteArray [
	^ByteArray readHexFrom: self expectedHexString
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> expectedHexString [
	"Example from http://www.ros.org/wiki/ROS/Connection%20Header"
	"new lines and indenting added for readability"
	^'b0 00 00 00
   20 00 00 00
      6d 65 73 73 61 67 65 5f 64 65 66 69 6e 69 74 69 6f 6e 3d 73 74 72 69 6e 67
      20 64 61 74 61 0a 0a
   25 00 00 00
      63 61 6c 6c 65 72 69 64 3d 2f 72 6f 73 74 6f 70 69 63 5f 34 37 36 37 5f 31
      33 31 36 39 31 32 37 34 31 35 35 37
   0a 00 00 00
      6c 61 74 63 68 69 6e 67 3d 31
   27 00 00 00
      6d 64 35 73 75 6d 3d 39 39 32 63 65 38 61 31 36 38 37 63 65 63 38 63 38 62
      64 38 38 33 65 63 37 33 63 61 34 31 64 31
   0e 00 00 00
      74 6f 70 69 63 3d 2f 63 68 61 74 74 65 72
   14 00 00 00
      74 79 70 65 3d 73 74 64 5f 6d 73 67 73 2f 53 74 72 69 6e 67
09 00 00 00
   05 00 00 00
      68 65 6c 6c 6f' copyWithoutAll: Character separators
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> setUp [ 
	super setUp.

"	RoStHandShakeMessageDecoder decode: self expectedByteArray."
	message := PhaROSHSMessageHeader newPublisherWith: [
		:msg  | 
		msg  	
		messageDefinition: 'string data', String lf, String lf;	
		callerId: '/rostopic_4767_1316912741557';
		latching: true;

		md5Sum: '992ce8a1687cec8c8bd883ec73ca41d1'; "Checsum for std_msgs/String"
		topic: '/chatter';
		type: 'std_msgs/String'
	].

		

]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testCallerIdHeaderFieldEncoding [
	self assertEncodedEqualsExpectedInLast: 37 ofFirstElements: 81
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testCallerIdHeaderFieldSizeEncoding [
	self assertEncodedEqualsExpectedInLast: 4 ofFirstElements: 44
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testEncoding [
	
	self assert: (PhaROSHSMessageEncoder encode: message)= (self  expectedByteArray first: 180)
	"In our approach we dont use the body space of the message in order to use the specific tcp/messages in just one way"
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testHeaderLengthEncoding [
	self assertEncodedEqualsExpectedInLast: 4 ofFirstElements: 4
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testLatchingFieldEncoding [
	self assertEncodedEqualsExpectedInLast: 10 ofFirstElements: 95
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testLatchingFieldSizeEncoding [
	self assertEncodedEqualsExpectedInLast: 4 ofFirstElements: 85
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testMessageDefinitionHeaderFieldEncoding [
	self assertEncodedEqualsExpectedInLast: 32 ofFirstElements: 40
]

{ #category : #testing }
PhaROSTopicTcpMessageEncodingTest >> testMessageDefinitionHeaderFieldSizeEncoding [
	self assertEncodedEqualsExpectedInLast: 4 ofFirstElements: 8
]
