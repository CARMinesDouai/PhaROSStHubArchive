"
"" Be sure that you have gmappings.launch file in the same folder than the image, and then execute the following two lines ""

		experiment := PureROSGmappings kompai2.
		experiment beginExperiment.
		
	"" Now, move the robot around with the joystick. When the map is done, execute the following line.  ""
	
		experiment endExperiment.

	"" In this experiment we have in the teardown process the map saving. You will find a map.yaml file in the same folder as the image. (It not check the override of the files, take care of that) ""
"
Class {
	#name : #PureROSGmappings,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments'
}

{ #category : #'as yet unclassified' }
PureROSGmappings >> saveMap [ 
	((self run: {'map_server' . 'map_saver'}) spin: 20) finalize.
]

{ #category : #'as yet unclassified' }
PureROSGmappings >> setup [
	self launch: 'gmappings.launch'.
	
	" Output "
	self configureLaser.
	self configureTFIn: '/base_link' withParent: '/odom'.

	
	
]

{ #category : #'as yet unclassified' }
PureROSGmappings >> teardown [ 
	self saveMap.
]
