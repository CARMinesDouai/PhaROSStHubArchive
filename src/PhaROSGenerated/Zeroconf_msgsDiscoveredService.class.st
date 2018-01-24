Class {
	#name : #'Zeroconf_msgsDiscoveredService',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService class >> rosMd5Sum [ 
^'3aabc6dd9875ef180c75536ad9a51d86'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService class >> rosTypeDefinition [ 
^' string name
 string type
 string domain
 string description
 string hostname
 string[] ipv4_addresses
 string[] ipv6_addresses
 int32 port
 int32 cookie
 bool is_local
 bool our_own
 bool wide_area
 bool multicast
 bool cached
'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService class >> rosTypeName [ 
^'zeroconf_msgs/DiscoveredService'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> cached [
	^ self getAt: #cached. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> cached: aValue [
	^ self at: #cached put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> cookie [
	^ self getAt: #cookie. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> cookie: aValue [
	^ self at: #cookie put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> domain [
	^ self getAt: #domain. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> domain: aValue [
	^ self at: #domain put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> hostname [
	^ self getAt: #hostname. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> hostname: aValue [
	^ self at: #hostname put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> initialize [
	super initialize.
	 self name: ''. 
	 self type: ''. 
	 self domain: ''. 
	 self description: ''. 
	 self hostname: ''. 
	 self ipv4_addresses: OrderedCollection new . 
	 self ipv6_addresses: OrderedCollection new . 
	 self port: 0. 
	 self cookie: 0. 
	 self is_local: false. 
	 self our_own: false. 
	 self wide_area: false. 
	 self multicast: false. 
	 self cached: false. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> ipv4_addresses [
	^ self getAt: #ipv4_addresses. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> ipv4_addresses: aValue [
	^ self at: #ipv4_addresses put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> ipv6_addresses [
	^ self getAt: #ipv6_addresses. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> ipv6_addresses: aValue [
	^ self at: #ipv6_addresses put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> is_local [
	^ self getAt: #is_local. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> is_local: aValue [
	^ self at: #is_local put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> multicast [
	^ self getAt: #multicast. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> multicast: aValue [
	^ self at: #multicast put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> our_own [
	^ self getAt: #our_own. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> our_own: aValue [
	^ self at: #our_own put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> port [
	^ self getAt: #port. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> port: aValue [
	^ self at: #port put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> type: aValue [
	^ self at: #type put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> wide_area [
	^ self getAt: #wide_area. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsDiscoveredService >> wide_area: aValue [
	^ self at: #wide_area put: aValue. 

]
