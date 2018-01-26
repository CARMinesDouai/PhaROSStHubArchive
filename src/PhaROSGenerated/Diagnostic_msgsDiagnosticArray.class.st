Class {
	#name : #'Diagnostic_msgsDiagnosticArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray class >> rosMd5Sum [ 
^'60810da900de1dd6ddd437c3503511da'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray class >> rosTypeDefinition [ 
^' std_msgs/Header header
 diagnostic_msgs/DiagnosticStatus[] status
'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray class >> rosTypeName [ 
^'diagnostic_msgs/DiagnosticArray'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray class >> typeCreationOrder [ 
^107
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticArray >> status: aValue [
	^ self at: #status put: aValue. 

]
