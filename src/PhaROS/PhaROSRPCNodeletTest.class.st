Class {
	#name : #PhaROSRPCNodeletTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'proxy'
	],
	#category : #'PhaROS-Nodelets-RPC-Test'
}

{ #category : #'as yet unclassified' }
PhaROSRPCNodeletTest >> setUp [ 
	server := (PhaROSHandleController rpcTest) nodelets rpc.
	proxy := XMLRPCProxy withUrl:  'http://10.1.160.45:9090/rpc'.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodeletTest >> tearDown [
	server stop.
	server controller finalize.
]

{ #category : #'as yet unclassified' }
PhaROSRPCNodeletTest >> testBasicValues [

	self assert: (proxy invokeMethod: #initPathWithStargazerIds: withArgs: #(#( 18  608  2 ))) = true.
	self assert: (proxy invokeMethod: #status) = PhaROSRPCNodelet waiting.
	self assert: (proxy invokeMethod: #currentLandmarkId) = 82.
	self assert: (proxy invokeMethod: #goToNextId) = 18.
	self assert: (proxy invokeMethod: #currentLandmarkId) = 18.
	self assert: (proxy invokeMethod: #goToNextId) = 608.
	self assert: (proxy invokeMethod: #currentLandmarkId) = 608.
	self assert: (proxy invokeMethod: #goToNextId) = 2.
	self assert: (proxy invokeMethod: #currentLandmarkId) = 2.
	self assert: (proxy invokeMethod: #goToNextId) = 82.
	
	self should: [(proxy invokeMethod: #goToNextId) = 18.] raise:  Error. 
	self assert: (proxy invokeMethod: #currentPosition) = { #x -> 1. #y -> 1} asDictionary .
]
