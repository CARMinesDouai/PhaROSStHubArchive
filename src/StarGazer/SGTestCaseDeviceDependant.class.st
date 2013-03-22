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

	^ serialPort ifNotNil: [ serialPort close ] .
]

{ #category : #'as yet unclassified' }
SGTestCaseDeviceDependant >> openSerialPort [ 
	
	serialPort  := SerialPort new
	 						 baudRate: SGGate defaultBaudRate;
				 			 openPort: SGGate defaultPortID;
							 yourself.
	
	^ serialPort
]
