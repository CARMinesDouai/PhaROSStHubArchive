"
PhaROSService is a reification of service. It just delegates into more lowlevel objects being polimorfic incoming services with outgoing ones.
"
Class {
	#name : #PhaROSService,
	#superclass : #Object,
	#instVars : [
		'service'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #constructor }
PhaROSService class >> for: aServiceProxyOrExposer [
	^ self new srv: aServiceProxyOrExposer ; yourself.
]

{ #category : #service }
PhaROSService >> call [ 
	^ service call.
]

{ #category : #service }
PhaROSService >> call: aBlock [ 
	^ service call: aBlock.
]

{ #category : #accessing }
PhaROSService >> srv: aServiceExposerOrProxy [
	service := aServiceExposerOrProxy .
]
