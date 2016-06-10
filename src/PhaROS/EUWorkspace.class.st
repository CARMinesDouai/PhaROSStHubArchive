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
	workspace := Workspace openContents: '
"
# Commands
PhaROSSystem cleanAll.

ProxySwitch on.
ProxySwitch off.

"'.
	workspace label: 'CAR Utils'.
	
]
