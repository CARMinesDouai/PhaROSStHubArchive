Class {
	#name : #PNGRobulabDiscoveryFactory,
	#superclass : #Object,
	#category : #'PureNG-Factories'
}

{ #category : #factory }
PNGRobulabDiscoveryFactory class >> kompai1 [
	"self kompai1"
	^ self robulabFromIp: #[192 168 1 1] port: 60000 
]

{ #category : #factory }
PNGRobulabDiscoveryFactory class >> kompai2 [
	"self kompai2"
	^ self robulabFromIp: #[192 168 1 2] port: 60000 
]

{ #category : #factory }
PNGRobulabDiscoveryFactory class >> robulabFromIp: ip port: port [
	|robulab directoryService |
	robulab := PNGRobulab ip: ip port: port.
	directoryService := PNGDirectoryService for: robulab.
	robulab services: directoryService get.
	^robulab
]
