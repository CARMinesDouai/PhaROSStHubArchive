Class {
	#name : #PhaROSServiceProxyTest,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'service',
		'loggers'
	],
	#category : #'PhaROSTestROS-Kernel'
}

{ #category : #testing }
PhaROSServiceProxyTest >> setUp [ 

	super setUp.
	"self startUpMaster.
	"
	
]

{ #category : #testing }
PhaROSServiceProxyTest >> testCallForLoggers [

	service := controller master lookupService: '/rosout/get_loggers' with: '/andID' .
service md5sum: '32e97e85527d4678a8f9279894bb64b0'.
loggers := service call response.
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros' ]).
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros.roscpp' ]).
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros.roscpp.roscpp_internal' ]).
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros.roscpp.superdebug' ]).

]
