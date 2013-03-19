Class {
	#name : #SGTestCase,
	#superclass : #TestCase,
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGTestCase >> withDefaultPort: aBlock [
	| port |
	
	port := SerialPort new.
	port baudRate: SGPort defaultBaudRate.
	port openPort: SGPort defaultPortID.
	
	aBlock value: port.
	port close.

]
