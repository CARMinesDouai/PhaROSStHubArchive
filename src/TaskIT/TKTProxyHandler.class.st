Class {
	#name : #TKTProxyHandler,
	#superclass : #GHSimpleForwarderProxyHandler,
	#category : #'TaskIT-Sugar'
}

{ #category : #'handle - debugging' }
TKTProxyHandler >> handlePrintStringLimitedTo: anInterception [
	| proxy |
	proxy := anInterception proxy. 
	^ 'This is the print of a proxy of class: ',  proxy tktClass name asString.
]
