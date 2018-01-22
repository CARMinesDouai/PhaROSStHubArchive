Class {
	#name : #'Gateway_msgsRemoteGateway',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway class >> wired [
	^1

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway class >> wireless [
	^2

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> conn_stats [
	^ self getAt: #conn_stats. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> conn_stats: aValue [
	^ self at: #conn_stats put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> firewall [
	^ self getAt: #firewall. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> firewall: aValue [
	^ self at: #firewall put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> flipped_interface [
	^ self getAt: #flipped_interface. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> flipped_interface: aValue [
	^ self at: #flipped_interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> initialize [
	super initialize.
	 self name: ''. 
	 self ip: ''. 
	 self firewall: false. 
	 self conn_stats: Gateway_msgsConnectionStatistics new. 
	 self public_interface: OrderedCollection new . 
	 self flipped_interface: OrderedCollection new . 
	 self pulled_interface: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> ip [
	^ self getAt: #ip. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> ip: aValue [
	^ self at: #ip put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> public_interface [
	^ self getAt: #public_interface. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> public_interface: aValue [
	^ self at: #public_interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> pulled_interface [
	^ self getAt: #pulled_interface. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteGateway >> pulled_interface: aValue [
	^ self at: #pulled_interface put: aValue. 

]
