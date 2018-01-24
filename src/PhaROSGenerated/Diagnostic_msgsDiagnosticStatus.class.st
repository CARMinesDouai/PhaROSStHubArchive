Class {
	#name : #'Diagnostic_msgsDiagnosticStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> error [
	^2

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> ok [
	^0

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> rosMd5Sum [ 
^'d0ce08bc6e5ba34c7754f563a9cabaf1'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> rosTypeDefinition [ 
^' int8 OK=0
 int8 WARN=1
 int8 ERROR=2
 int8 STALE=3
 int8 level
 string name
 string message
 string hardware_id
 diagnostic_msgs/KeyValue[] values
'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> rosTypeName [ 
^'diagnostic_msgs/DiagnosticStatus'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> stale [
	^3

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus class >> warn [
	^1

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> hardware_id [
	^ self getAt: #hardware_id. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> hardware_id: aValue [
	^ self at: #hardware_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> initialize [
	super initialize.
	 self level: 0. 
	 self name: ''. 
	 self message: ''. 
	 self hardware_id: ''. 
	 self values: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> level [
	^ self getAt: #level. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> level: aValue [
	^ self at: #level put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> message: aValue [
	^ self at: #message put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> values [
	^ self getAt: #values. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsDiagnosticStatus >> values: aValue [
	^ self at: #values put: aValue. 

]
