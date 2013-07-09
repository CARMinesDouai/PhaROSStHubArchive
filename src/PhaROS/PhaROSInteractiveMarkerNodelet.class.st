"
IDea



controller := PhaROSHandleController localhost.

controller packages use: PhaROSInteractiveMarkerPackage new as: #marker.



controller packages marker server marker: [ : m |
	m name: ''.
	m add shape arrow.
	m add shape cylinder.
	m add control: [: ctl | ctl shape arrow  ].
	m add menu at:#name entry:[ :e | 
		e at:#ble entry: [ :e2 
			e2 command: [: a :b | ].
			e2 run: (PhaROSNodeBuilder package: bla type: bla name: bla).
			e2 launch: (PhaROSLaunchBuilder definition).
		].
		e entry
	].


	{ 
		#name -> {
			(#ble -> [: e | e command ] ) . 
			(#ble -> [: e | e command ] ) . 
			(#ble -> [: e | e command ] ) . 
			 #bla -> { 
				 #lala -> [] . 
				 #lele -> []
			}
		}.
		#bla -> [:e | e command ]. 
		#ble -> #x
	}.


	m erase shape arrow. 
	m erase shape: #arrow.
	
	
].
"
Class {
	#name : #PhaROSInteractiveMarkerNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'server',
		'markers'
	],
	#category : #'PhaROS-Nodelets-InteractiveMarker'
}

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarkerNodelet >> configure [
]

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarkerNodelet >> server [
	^ server ifNil: [ server := PhaROSInteractiveMarkerServer with: self ]
]
