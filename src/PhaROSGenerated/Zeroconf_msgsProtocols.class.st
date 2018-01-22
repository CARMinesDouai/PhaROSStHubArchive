Class {
	#name : #'Zeroconf_msgsProtocols',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Zeroconf_msgsProtocols class >> ipv4 [
	^1

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsProtocols class >> ipv6 [
	^2

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsProtocols class >> rosTypeDefinition [ 
^' int8 UNSPECIFIED=0
 int8 IPV4=1
 int8 IPV6=2
'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsProtocols class >> rosTypeName [ 
^'zeroconf_msgs/Protocols'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsProtocols class >> unspecified [
	^0

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsProtocols >> initialize [
	super initialize.

]
