Class {
	#name : #PNGRobulabDiscoveryFactory,
	#superclass : #Object,
	#category : #'PureNG-Factories'
}

{ #category : #factory }
PNGRobulabDiscoveryFactory class >> robulabFromIp: ip port: port [
	|robulab directoryService |
	robulab := PNGRobulab ip: ip port: port.
	directoryService := PNGDirectoryService for: robulab.
	robulab services: directoryService get.
	^robulab
]
