Class {
	#name : #PhaROSMasterResource,
	#superclass : #TestResource,
	#category : #'PhaROSTestROS-Kernel'
}

{ #category : #running }
PhaROSMasterResource >> setUp [
	
	PhaROSSystemInfo instance launchExternalROSMaster

]

{ #category : #running }
PhaROSMasterResource >> tearDown [

	PhaROSSystemInfo instance stopExternalROSMaster
]
