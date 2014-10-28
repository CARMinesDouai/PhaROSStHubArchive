"
Shortcut for turning ON/OFF http proxy network configuration.

Commands:
ProxySwitch on
ProxySwitch off
"
Class {
	#name : #ProxySwitch,
	#superclass : #Object,
	#classInstVars : [
		'isOn'
	],
	#category : #'PhaROS-Util'
}

{ #category : #public }
ProxySwitch class >> off [

	NetworkSystemSettings useHTTPProxy: false.
	self inform: 'HTTP proxy: OFF'
]

{ #category : #public }
ProxySwitch class >> on [

	NetworkSystemSettings useHTTPProxy: true.
	self inform: 'HTTP proxy: ON'
]
