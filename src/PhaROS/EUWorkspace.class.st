"
ExpUtilsControlPanel open
"
Class {
	#name : #EUWorkspace,
	#superclass : #Object,
	#category : #'PhaROS-Util'
}

{ #category : #public }
EUWorkspace class >> open [

	|workspace|
	workspace := Workspace new contents: '
"
# Commands
ProcessesCleaner clean

ProxySwitch on
ProxySwitch off

"'.
	workspace open.
	workspace label: 'CAR Utils'.
	
]
