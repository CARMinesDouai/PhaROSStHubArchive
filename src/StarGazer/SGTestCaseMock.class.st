Class {
	#name : #SGTestCaseMock,
	#superclass : #SGTestCase,
	#instVars : [
		'serialMock',
		'selectedContent'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGTestCaseMock >> closeSerialPort [ 

]

{ #category : #'as yet unclassified' }
SGTestCaseMock >> openSerialPort [ 
	^ serialMock ifNil: [serialMock := SGSerialMock content: selectedContent steppingBy: 9 ] ifNotNil: [ serialMock ].
]

{ #category : #'as yet unclassified' }
SGTestCaseMock >> selectedContent: aContent [
	selectedContent := aContent .
]

{ #category : #'as yet unclassified' }
SGTestCaseMock >> setUp [
	selectedContent := ''
]

{ #category : #'as yet unclassified' }
SGTestCaseMock >> waitForUser: aString [
	
]
