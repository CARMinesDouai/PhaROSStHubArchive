Class {
	#name : #SGTestCaseDeviceDependant,
	#superclass : #SGTestCase,
	#instVars : [
		'serialPort'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGTestCaseDeviceDependant >> closeSerialPort [

	^ serialPort close.
]

{ #category : #'as yet unclassified' }
SGTestCaseDeviceDependant >> openSerialPort [ 
	
	serialPort  := SerialPort new.
	serialPort baudRate: SGGate defaultBaudRate.
	serialPort openPort: SGGate defaultPortID.
	
	^ serialPort
]
