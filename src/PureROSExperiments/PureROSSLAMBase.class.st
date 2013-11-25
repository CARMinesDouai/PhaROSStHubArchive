Class {
	#name : #PureROSSLAMBase,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROSExperiments-SLAM'
}

{ #category : #save }
PureROSSLAMBase >> saveMap [ 
	((self run: {'map_server' . 'map_saver'}) spin: 20) finalize.
]

{ #category : #configuration }
PureROSSLAMBase >> teardown [ 
	self saveMap.
	
]
