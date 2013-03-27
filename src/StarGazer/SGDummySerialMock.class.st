Class {
	#name : #SGDummySerialMock,
	#superclass : #Object,
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGDummySerialMock >> asSGStream [
	^ SGStream for: ( SerialStream for: self).
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> contents: aStringOrByteArray [
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> nextPutAll: aString [
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> readString [
	^ '~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`~!Ack`'
]
