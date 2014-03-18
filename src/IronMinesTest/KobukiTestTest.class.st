Class {
	#name : #KobukiTestTest,
	#superclass : #TestCase,
	#instVars : [
		'kobuki'
	],
	#category : #'IronMinesTest-Nodelets'
}

{ #category : #'as yet unclassified' }
KobukiTestTest >> setUp [ 
kobuki :=  KobukiTest  new .

kobuki resetOdom ; demarrer .
]

{ #category : #'as yet unclassified' }
KobukiTestTest >> tearDown [ 
kobuki arreter .
]

{ #category : #'as yet unclassified' }
KobukiTestTest >> testRepereOk [
kobuki z: 0.4.
self assert: ((kobuki ux dotProduct:(kobuki uy))=0.0).
self assert: ((kobuki ux dotProduct:(kobuki ux))=1.0).
self assert: ((kobuki uy dotProduct:(kobuki uy))=1.0).
]

{ #category : #'as yet unclassified' }
KobukiTestTest >> testSetPosFinish [
| x1 |
x1 := kobuki x.
kobuki velocityLin: 1 ang: 0.
(Delay forMilliseconds: 1000) wait.
self assert:(x1<kobuki x).
]
