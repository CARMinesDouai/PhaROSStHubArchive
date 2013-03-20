Class {
	#name : #SGTestCaseMock,
	#superclass : #SGTestCase,
	#instVars : [
		'serialMock'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGTestCaseMock >> closeSerialPort [ 

]

{ #category : #'as yet unclassified' }
SGTestCaseMock >> openSerialPort [ 
	^ serialMock ifNil: [serialMock := SGSerialMock content: '' steppingBy: 1 ] ifNotNil: [ serialMock ].
]
