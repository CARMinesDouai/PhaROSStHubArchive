Class {
	#name : #'Realsense_cameraIMUInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> bias_variances [
	^ self getAt: #bias_variances. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> bias_variances: aValue [
	^ self at: #bias_variances put: aValue. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self data:  (OrderedCollection new: 12). 
	 self noise_variances:  (OrderedCollection new: 3). 
	 self bias_variances:  (OrderedCollection new: 3). 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> noise_variances [
	^ self getAt: #noise_variances. 

]

{ #category : #'as yet unclassified' }
Realsense_cameraIMUInfo >> noise_variances: aValue [
	^ self at: #noise_variances put: aValue. 

]
