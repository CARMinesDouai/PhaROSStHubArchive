Class {
	#name : #'Controller_manager_msgsControllerStatistics',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> initialize [
	super initialize.
	 self name: ''. 
	 self type: ''. 
	 self timestamp:  PhaROSTimestamp now. 
	 self running: false. 
	 self max_time:  Duration seconds: 0. 
	 self mean_time:  Duration seconds: 0. 
	 self variance_time:  Duration seconds: 0. 
	 self num_control_loop_overruns: 0. 
	 self time_last_control_loop_overrun:  PhaROSTimestamp now. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> max_time [
	^ self getAt: #max_time. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> max_time: aValue [
	^ self at: #max_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> mean_time [
	^ self getAt: #mean_time. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> mean_time: aValue [
	^ self at: #mean_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> num_control_loop_overruns [
	^ self getAt: #num_control_loop_overruns. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> num_control_loop_overruns: aValue [
	^ self at: #num_control_loop_overruns put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> running [
	^ self getAt: #running. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> running: aValue [
	^ self at: #running put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> time_last_control_loop_overrun [
	^ self getAt: #time_last_control_loop_overrun. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> time_last_control_loop_overrun: aValue [
	^ self at: #time_last_control_loop_overrun put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> timestamp [
	^ self getAt: #timestamp. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> timestamp: aValue [
	^ self at: #timestamp put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> type: aValue [
	^ self at: #type put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> variance_time [
	^ self getAt: #variance_time. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerStatistics >> variance_time: aValue [
	^ self at: #variance_time put: aValue. 

]
