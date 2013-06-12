"
# Launch Builder

	This object a builder that allows to create a configuration to startup a ROS system. 
	It provides an easy and fluid way to configure a group of nodes to execute.
	
	# {design_title}
		The launch builder it is based in a simple reification of a tree structure
		PhaROSAbstractElement is an abstract class that defines the  
	
	# {methods_title}
		{ methods_documentation }
	
	
	
	
	
	
"
Class {
	#name : #PhaROSLaunchBuilder,
	#superclass : #PhaROSBaseElement,
	#instVars : [
		'fileName'
	],
	#category : #'PhaROS-Launch'
}

{ #category : #localization }
PhaROSLaunchBuilder >> amcl [


	|conf |
	
	conf := self package: 'amcl' type:'amcl' named:'amcl'.

	  conf param:'odom_model_type' value:'diff'.
	  conf param:'odom_alpha5' value:'0.1'.
	  conf param:'transform_tolerance' value:'0.2'.
	  conf param:'gui_publish_rate' value:'10.0'.
	  conf param:'laser_max_beams' value:'30'.
	  conf param:'min_particles' value:'500'.
	  conf param:'max_particles' value:'5000'.
	  conf param:'kld_err' value:'0.05'.
	  conf param:'kld_z' value:'0.99'.
	  conf param:'odom_alpha1' value:'0.2'.
	  conf param:'odom_alpha2' value:'0.2'.
	 " <!-- translation std dev, m -->"
	  conf param:'odom_alpha3' value:'0.8'. 
	  conf param:'odom_alpha4' value:'0.2'.
	  conf param:'laser_z_hit' value:'0.5'.
	  conf param:'laser_z_short' value:'0.05'.
	  conf param:'laser_z_max' value:'0.05'.
	  conf param:'laser_z_rand' value:'0.5'.
	  conf param:'laser_sigma_hit' value:'0.2'.
	  conf param:'laser_lambda_short' value:'0.1'.
	  conf param:'laser_lambda_short' value:'0.1'.
	  conf param:'laser_model_type' value:'likelihood_field'.
	 " <!-- conf param:'laser_model_type' value:'beam'. -->"
	  conf param:'laser_likelihood_max_dist' value:'2.0'.
	  conf param:'update_min_d' value:'0.2'.
	  conf param:'update_min_a' value:'0.5'.

	  conf param:'odom_frame_id' value:'odom'.

	  conf param:'base_frame_id" type="str' value:'base_link'.
	  conf param:'global_frame_id" type="str' value:'map'.

	  conf param:'resample_interval' value:'1'.
	  conf param:'transform_tolerance' value:'0.1'.
	  conf param:'recovery_alpha_slow' value:'0.0'.
	  conf param:'recovery_alpha_fast' value:'0.0'.
	  conf param:'use_map_topic' value:'true'.
	  conf param:'first_map_only' value:'true'.
	^ conf.
]

{ #category : #writing }
PhaROSLaunchBuilder >> fileName [
	^ fileName ifNil: [ ^ '/tmp/generated-launch' ] .
	

]

{ #category : #writing }
PhaROSLaunchBuilder >> fileName: aFileName [
	fileName := aFileName
]

{ #category : #slam }
PhaROSLaunchBuilder >> gmapping [
	| conf |


	conf := self package: 'gmapping' type:'slam_gmapping'  named: 'slam_gmapping'.

	conf output: 'screen'.
	
	conf param:'map_udpate_interval' value:'2.0'.
      conf param:'maxUrange' value:'30.0'.
      conf param:'sigma' value:'0.05'.
      conf param:'kernelSize' value:'1'.
      conf param:'lstep' value:'0.05'.
      conf param:'astep' value:'0.05'.
      conf param:'iterations' value:'5'.
      conf param:'lsigma' value:'0.075'.
      conf param:'ogain' value:'3.0'.
      conf param:'lskip' value:'0'.
      conf param:'srr' value:'0.1'.
      conf param:'srt' value:'0.2'.
      conf param:'str' value:'0.1'.
      conf param:'stt' value:'0.2'.
      conf param:'linearUpdate' value:'1.0'.
      conf param:'angularUpdate' value:'0.5'.
      conf param:'temporalUpdate' value:'3.0'.
      conf param:'resampleThreshold' value:'10.5'.
      conf param:'particles' value:'30'.
      conf param:'xmin' value:'-100.0'.
      conf param:'ymin' value:'-100.0'.
      conf param:'xmax' value:'100.0'.
      conf param:'ymax' value:'100.0'.
      conf param:'delta' value:'0.05'.
      conf param:'llsamplerange' value:'0.01'.
      conf param:'llsamplestep' value:'0.01'.
      conf param:'lasamplerange' value:'0.05'.
      conf param:'lasamplestep' value:'0.05'.




]

{ #category : #localization }
PhaROSLaunchBuilder >> hectorLocalization [
	| conf |


	conf := self package: 'hector_pose_estimation' type:'pose_estimation'  named: 'hector_pose_estimation'.
	conf param: 'nav_frame' value: 'odom'.
	
	^ conf.
]

{ #category : #slam }
PhaROSLaunchBuilder >> hectorMapping [
	| conf |


	conf := self package: 'hector_mapping' type:'hector_mapping'  named: 'hector_mapping'.

	conf output: 'screen'.
	
	conf param:'map_frame' value:'map'.
	conf param:'base_frame' value:'base_link'.
	conf param:'odom_frame' value:'odom'.
	conf param:'output_timing' value:'false'.


	conf param:'scan_topic' value:'scan'.
	conf param:'pub_map_odom_transform' value:'true'.

	"<!-- Map size / start point -->"
	conf param:'map_resolution' value:'0.050'.
	conf param:'map_size' value:'2048'.
	conf param:'map_start_x' value:'0.5'.
	conf param:'map_start_y' value:'0.5'.

	"<!-- Map update parameters -->"
	conf param:'update_factor_free' value:'0.4'.
	conf param:'update_factor_occupied' value:'0.9'.
	conf param:'map_update_distance_thresh' value:'0.4'.
	conf param:'map_update_angle_thresh' value:'0.06'.

	"
	conf param:'pub_drawings' value:'true'.
	conf param:'pub_debug_output' value:'true'.
	"



]

{ #category : #util }
PhaROSLaunchBuilder >> mapServer: aFile [
	| conf |
	
	conf := self package: 'map_server' type:'map_server'  named: 'map_server'.
	conf args: aFile. 
	^ conf.
]

{ #category : #slam }
PhaROSLaunchBuilder >> moveBase [
	| conf |


	conf := self package: 'move_base' type:'move_base'  named: 'move_base'.

	conf output: 'screen'.
	

	conf remap:'map' to: '/map'.
	conf remap:'base_scan' to: '/scan'.
	conf remap:'base_laser' to: '/laser'.
	conf remap:'/cmd_vel' to: '/command_velocity'.
	conf param:'controller_frequency' value:'10.0'.
       conf rosparam file: '/home/santiago/costmap_common_params.yaml'; command: 'load'; ns: 'global_costmap'.
       conf rosparam file: '/home/santiago/costmap_common_params.yaml'; command: 'load'; ns: 'local_costmap'.
       conf rosparam file: '/home/santiago/local_costmap_params.yaml'; command: 'load'.
       conf rosparam file: '/home/santiago/global_costmap_params.yaml'; command: 'load'.
       conf rosparam file: '/home/santiago/base_local_planner_params.yaml' ; command: 'load'.  
]

{ #category : #'as yet unclassified' }
PhaROSLaunchBuilder >> nodeName [
	^ 'launch'
]

{ #category : #'as yet unclassified' }
PhaROSLaunchBuilder >> package: aPackageName type:aType named: aName [ 
	^ self addChild: (PhaROSNodeBuilder package: aPackageName type:aType named: aName) 
]

{ #category : #util }
PhaROSLaunchBuilder >> relayTopic: aTopicID to: anOtherTopicID [ 
	|conf |
	
	conf := self package: 'topic_tools' 
				type:'relay'  
				named: (aTopicID normalizeFrame, '_' ,anOtherTopicID normalizeFrame, '_relay').
				
	conf args: ('/{1} /{2}' format: {aTopicID normalizeFrame . anOtherTopicID normalizeFrame }).
	
	^ conf.
]

{ #category : #localization }
PhaROSLaunchBuilder >> robotEFKPose [
	| conf |


	conf := self package: 'robot_pose_ekf' type:'robot_pose_ekf'  named: 'robot_pose_ekf'.
	
	conf param:'output_frame' value:'odom'.
	conf param:'freq' value:'50.0'.
	conf param:'sensor_timeout' value:'1.0'.
	conf param:'odom_used' value:'true'.
	conf param:'imu_used' value:'true'.
	conf param:'vo_used' value:'false'.
	conf param:'debug' value:'true'.
	conf param:'self_diagnose' value:'false'.
	
	^ conf.
]

{ #category : #util }
PhaROSLaunchBuilder >> rviz [


	| conf |

	conf := self package: 'rviz' type:'rviz'  named: 'rviz'.
	conf output: 'screen'.
	
	^ conf.
]

{ #category : #util }
PhaROSLaunchBuilder >> rviz: aConfigFile [


	| conf |

	conf := self rviz.
	
	^ conf.
]

{ #category : #tf }
PhaROSLaunchBuilder >> staticTFFrom: aFrame to: anOtherFrame  of: aStringOfShift rate: aRate [
	| conf |
	
	conf:= self package: 'tf' type: 'static_transform_publisher' named: aFrame normalizeFrame, '_to_', anOtherFrame normalizeFrame. 
	conf args: ('{1} /{2} /{3} {4}' format: {aStringOfShift . aFrame normalizeFrame . anOtherFrame normalizeFrame . aRate asString }).
	
	^ conf.
]

{ #category : #tf }
PhaROSLaunchBuilder >> staticZeroTFFrom: aFrame to: anOtherFrame [  

		^ self staticTFFrom: aFrame to: anOtherFrame  of: ' 0 0 0  0 0 0' rate: 100.
]

{ #category : #tf }
PhaROSLaunchBuilder >> tfaas: aFrameFrom to: aFrameTo rate: aRate [

	| conf |


	conf := self package: 'tfaas' type:'tfaas'  named: ('tfaas_{1}_{2}' format: {aFrameFrom normalizeFrame  . aFrameTo  normalizeFrame }).
	conf param: 'frameFrom' value: aFrameFrom.
	conf param: 'frameTo' value: aFrameTo.
	conf param: 'rate' value: '30'.	
		
	^ conf.
]

{ #category : #writing }
PhaROSLaunchBuilder >> writeFile [
	| op name |
	
	name :=  self fileName,'.launch'.
	op := StandardFileStream forceNewFileNamed:name.
	op nextPutAll: self xml. 
	op close. 
	
	^name 
]

{ #category : #imu }
PhaROSLaunchBuilder >> xsens [
	|conf |
	
	conf := self package: 'xsens' type:'xsens' named:'xsens'.
	conf param:'imu_topic_name' value: '/imu_data'.
	conf param:'magnetic_topic_name' value: '/magnetic'.
	conf param:'frame_id' value: '/MT0'.
	
	^ conf.
]
