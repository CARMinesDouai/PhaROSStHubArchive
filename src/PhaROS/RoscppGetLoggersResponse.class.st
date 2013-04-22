Class {
	#name : #RoscppGetLoggersResponse,
	#superclass : #PhaROSValue,
	#category : #'PhaROS-Types'
}

{ #category : #'as yet unclassified' }
RoscppGetLoggersResponse >> addLogger: aValue [
	^ self loggers add: aValue. 

]

{ #category : #'as yet unclassified' }
RoscppGetLoggersResponse >> initialize [
	super initialize.
	 self loggers: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
RoscppGetLoggersResponse >> loggers [
	^ self getAt: #loggers. 

]

{ #category : #'as yet unclassified' }
RoscppGetLoggersResponse >> loggers: aValue [
	^ self at: #loggers put: aValue. 

]
