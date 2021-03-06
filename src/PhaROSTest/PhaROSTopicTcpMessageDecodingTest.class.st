Class {
	#name : #PhaROSTopicTcpMessageDecodingTest,
	#superclass : #TestCase,
	#instVars : [
		'expectedMessage'
	],
	#category : #'PhaROSTest-Network-Tcp'
}

{ #category : #testing }
PhaROSTopicTcpMessageDecodingTest >> messageByteArray [
	^ByteArray readHexFrom: self messageHexString
]

{ #category : #testing }
PhaROSTopicTcpMessageDecodingTest >> messageHexString [
	"Example from http://www.ros.org/wiki/ROS/Connection%20Header"
	"new lines and indenting added for readability"
	^'b0 00 00 00
   20 00 00 00
      6d 65 73 73 61 67 65 5f 64 65 66 69 6e 69 74 69 6f 6e 3d 73 74 72 69 6e 67
      20 64 61 74 61 0d 0d
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
PhaROSTopicTcpMessageDecodingTest >> setUp [ 
	super setUp.
	expectedMessage := PhaROSHSMessageHeader newPublisherWith: [
		:msg  | 
		msg  	
			
		messageDefinition:'string data

';	
		callerId: '/rostopic_4767_1316912741557';
		latching: true;

		md5Sum: '992ce8a1687cec8c8bd883ec73ca41d1'; "Checsum for std_msgs/String"
		topic: '/chatter';
		type: 'std_msgs/String'
	].
	
]

{ #category : #testing }
PhaROSTopicTcpMessageDecodingTest >> testDecoding [
	| decodedMessage |
	
	decodedMessage :=PhaROSHSMessageHeader newPublisherMessageFrom: self messageByteArray readStream.
	self assert: expectedMessage = decodedMessage
	
]

{ #category : #testing }
PhaROSTopicTcpMessageDecodingTest >> testHeaderDecoding [
	| decodedMessage |
	decodedMessage := PhaROSHSMessageHeader newPublisherMessageFrom: self messageByteArray readStream.
	self assert: expectedMessage header = decodedMessage header
]
