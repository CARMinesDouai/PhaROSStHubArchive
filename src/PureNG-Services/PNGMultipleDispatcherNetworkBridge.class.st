Class {
	#name : #PNGMultipleDispatcherNetworkBridge,
	#superclass : #PNGNetworkBridge,
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGMultipleDispatcherNetworkBridge >> initialize [ 
	super  initialize.
	self responseQueue: MultipleSharedQueue new.


]
