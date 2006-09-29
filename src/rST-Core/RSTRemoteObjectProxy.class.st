"
I'm a proxy to a remote object, all mesages that I'll receive I'll send them to the remoteObject
"
Class {
	#name : #RSTRemoteObjectProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'remoteObjectID',
		'haltOnce',
		'errorOnce'
	],
	#category : #'rST-Core'
}

{ #category : #'instance creation' }
RSTRemoteObjectProxy class >> remoteObjectID: aRemoteObjectID [
	^ self new initializeRemoteObjectID: aRemoteObjectID
]

{ #category : #'user interface' }
RSTRemoteObjectProxy >> basicInspect [
	"Create and schedule an Inspector in which the user can examine the  
	receiver's variables. This method should not be overriden."
	Inspector openOn: self withEvalPane: false
]

{ #category : #'system primitives' }
RSTRemoteObjectProxy >> become: otherObject [ 
	"when remote objects participates, only remote objects that live in the 
	same image could be becomed"
	otherObject isRemote
		ifFalse: [^ self error: 'invalid #become: (the receiver is remote and the other is local)'].
	(self xxxSameImage: otherObject)
		ifFalse: [^ self error: 'invalid #become: (the receiver lives in a diferent image than the other)'].
	self
		xxxSend: (Message selector: #become: argument: otherObject)
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> clearErrorOnce [
	"Turn off the error once flag."
	errorOnce := false
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> clearHaltOnce [
	"Turn off the halt once flag."
	haltOnce := false
]

{ #category : #'user interface' }
RSTRemoteObjectProxy >> defaultLabelForInspector [
	"Answer the default label to be used for an Inspector window on the 
	receiver. "
	| remoteLabel |
	remoteLabel _ self
				xxxSend: (Message selector: #defaultLabelForInspector).
	^ 'Remote Object: ' , remoteLabel , ' (' , remoteObjectID asString , ')'
]

{ #category : #'system primitives' }
RSTRemoteObjectProxy >> doesNotUnderstand: aMessage [
	^ self xxxSend: aMessage
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> error: aString [ 
	"Throw a generic Error exception."
	self errorOnce: aString
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> errorOnce: aString [ 
	"Throw a generic Error exception."
	
	self errorOnceEnabled ifTrue: [
		self clearErrorOnce.
		^ Error signal: aString]
]

{ #category : #testing }
RSTRemoteObjectProxy >> errorOnceEnabled [
	^ errorOnce
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> halt [
	"This is the typical message to use for inserting breakpoints during  
	debugging. It behaves like halt:, but does not call on halt: in order to  
	avoid putting this message on the stack. Halt is especially useful when  
	the breakpoint message is an arbitrary one."
	self haltOnce
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> haltOnce [
	"Halt unless we have already done it once."
	
	self haltOnceEnabled ifTrue: [
		self clearHaltOnce.
		Halt signal]
]

{ #category : #testing }
RSTRemoteObjectProxy >> haltOnceEnabled [
	^ haltOnce
]

{ #category : #initialization }
RSTRemoteObjectProxy >> initialize [
	super initialize.
	self setHaltOnce.
	self setErrorOnce
]

{ #category : #initialization }
RSTRemoteObjectProxy >> initializeRemoteObjectID: aRemoteObjectID [ 
	remoteObjectID _ aRemoteObjectID
]

{ #category : #'user interface' }
RSTRemoteObjectProxy >> inspect [
	"Open an RSTRemoteInspector on the receiver. Use basicInspect to get a normal (less useful) type of inspector."

	self inspectorClass openOn: self withEvalPane: true
]

{ #category : #'user interface' }
RSTRemoteObjectProxy >> inspectWithLabel: aLabel [ 
	"Open an RSTRemoteInspector on the receiver. Use basicInspect to get a 
	normal (less useful) type of inspector."

	self inspectorClass 
		openOn: self
		withEvalPane: true
		withLabel: aLabel
]

{ #category : #'user interface' }
RSTRemoteObjectProxy >> inspectorClass [
	^RSTRemoteInspector
]

{ #category : #'class membership' }
RSTRemoteObjectProxy >> isKindOf: aClass [
	"We make the assumption that 2 classes with the same name and located in 2 different images are identical (code replication)"
	^self isKindOfClassNamed: aClass name
]

{ #category : #testing }
RSTRemoteObjectProxy >> isReachable [
	^ [self xxxSend: (Message selector: #isReachable)] 
		 on: RSTRemoteObjectUnreachable, RSTObjectNotFound 
		 do: [false]
]

{ #category : #testing }
RSTRemoteObjectProxy >> isRemote [
	"answer if the object is a remote one"
	^ true
]

{ #category : #printing }
RSTRemoteObjectProxy >> printString [
	"Noury Bouraqadi 9/21/2006 16:20"
	
	self isReachable ifTrue: [^self xxxSend: (Message selector: #printString)].
	^'rST proxy of unreachable remote object'
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> setErrorOnce [
	"Turn on the error once flag."
	errorOnce := true
]

{ #category : #'error handling' }
RSTRemoteObjectProxy >> setHaltOnce [
	"Turn on the halt once flag."
	haltOnce := true
]

{ #category : #accessing }
RSTRemoteObjectProxy >> xxxRemoteObjectID [
	^ remoteObjectID
]

{ #category : #testing }
RSTRemoteObjectProxy >> xxxSameImage: aRemoteObjectProxy [ 
	"answer if both objects live in the same Image"
	^ self xxxRemoteObjectID brokerID = aRemoteObjectProxy xxxRemoteObjectID brokerID
]

{ #category : #'system primitives' }
RSTRemoteObjectProxy >> xxxSend: aMessage [ 
	"send this message to the remote object represented by me"
	^ RSTBroker instance sendMessage: aMessage to: self xxxRemoteObjectID
]
