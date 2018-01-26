Class {
	#name : #'Gateway_msgsGatewayInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo class >> rosMd5Sum [ 
^'8e8f7efa326aa247c5cb6a9692ec8014'
]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo class >> rosTypeDefinition [ 
^' string name
 bool connected
 string ip
 string[] hub_names
 string[] hub_uris
 bool firewall
 gateway_msgs/Rule[] public_watchlist
 gateway_msgs/Rule[] public_interface
 gateway_msgs/RemoteRuleWithStatus[] flipped_connections
 gateway_msgs/RemoteRule[] flip_watchlist
 gateway_msgs/RemoteRule[] flipped_in_connections
 gateway_msgs/RemoteRule[] pull_watchlist
 gateway_msgs/RemoteRule[] pulled_connections
'
]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo class >> rosTypeName [ 
^'gateway_msgs/GatewayInfo'
]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo class >> typeCreationOrder [ 
^124
]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> connected [
	^ self getAt: #connected. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> connected: aValue [
	^ self at: #connected put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> firewall [
	^ self getAt: #firewall. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> firewall: aValue [
	^ self at: #firewall put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> flip_watchlist [
	^ self getAt: #flip_watchlist. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> flip_watchlist: aValue [
	^ self at: #flip_watchlist put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> flipped_connections [
	^ self getAt: #flipped_connections. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> flipped_connections: aValue [
	^ self at: #flipped_connections put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> flipped_in_connections [
	^ self getAt: #flipped_in_connections. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> flipped_in_connections: aValue [
	^ self at: #flipped_in_connections put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> hub_names [
	^ self getAt: #hub_names. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> hub_names: aValue [
	^ self at: #hub_names put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> hub_uris [
	^ self getAt: #hub_uris. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> hub_uris: aValue [
	^ self at: #hub_uris put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> initialize [
	super initialize.
	 self name: ''. 
	 self connected: false. 
	 self ip: ''. 
	 self hub_names: OrderedCollection new . 
	 self hub_uris: OrderedCollection new . 
	 self firewall: false. 
	 self public_watchlist: OrderedCollection new . 
	 self public_interface: OrderedCollection new . 
	 self flipped_connections: OrderedCollection new . 
	 self flip_watchlist: OrderedCollection new . 
	 self flipped_in_connections: OrderedCollection new . 
	 self pull_watchlist: OrderedCollection new . 
	 self pulled_connections: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> ip [
	^ self getAt: #ip. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> ip: aValue [
	^ self at: #ip put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> public_interface [
	^ self getAt: #public_interface. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> public_interface: aValue [
	^ self at: #public_interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> public_watchlist [
	^ self getAt: #public_watchlist. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> public_watchlist: aValue [
	^ self at: #public_watchlist put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> pull_watchlist [
	^ self getAt: #pull_watchlist. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> pull_watchlist: aValue [
	^ self at: #pull_watchlist put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> pulled_connections [
	^ self getAt: #pulled_connections. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsGatewayInfo >> pulled_connections: aValue [
	^ self at: #pulled_connections put: aValue. 

]
