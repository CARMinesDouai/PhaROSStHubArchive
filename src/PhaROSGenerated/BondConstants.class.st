Class {
	#name : #BondConstants,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
BondConstants class >> dead_publish_period [
	^0.05

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_connect_timeout [
	^10.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_disconnect_timeout [
	^2.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_heartbeat_period [
	^1.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_heartbeat_timeout [
	^4.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> disable_heartbeat_timeout_param [
	^'/bond_disable_heartbeat_timeout'

]

{ #category : #'as yet unclassified' }
BondConstants >> initialize [
	super initialize.

]
