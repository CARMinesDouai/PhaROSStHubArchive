Class {
	#name : #PureRequest,
	#superclass : #PureActionMessage,
	#category : #'PureNoLog-Messages'
}

{ #category : #'as yet unclassified' }
PureRequest class >> action: anAction data: aDataObject target: aTarget. [
	^ self new action: anAction ; data: aDataObject ; target: aTarget ; yourself.
]

{ #category : #'as yet unclassified' }
PureRequest class >> delete: aDataObject from: aTarget [
	^ self action: 'DELETE' data: aDataObject target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest class >> getFrom: aTarget [
	^ self action: 'GET' data: '' target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest class >> insert: aDataObject into: aTarget [
	^ self action: 'INSERT' data: aDataObject target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest class >> query: aDataObject to: aTarget [
	^ self action: 'QUERY' data: aDataObject target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest class >> replace: aDataObject into: aTarget [
	^ self action: 'REPLACE' data: aDataObject target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest class >> submit: aDataObject to: aTarget [
	^ self action: 'SUBMIT' data: aDataObject target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest class >> update: aDataObject into: aTarget [
	^ self action: 'UPDATE' data: aDataObject target: aTarget.
]

{ #category : #'as yet unclassified' }
PureRequest >> asHex [
	^  (PureConstants actionCodes at: self action) asString, '0', self target getInstanceNumber asString , '00',data asHex.
]
