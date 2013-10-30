Class {
	#name : #PhaROSTypeBrowserTests,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'PhaROS-Util-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTypeBrowserTests >> creatorScript [
" self new creatorScript "
	(String lf split: (PhaROSSystemLauncher instance rosMsg:'list')) do: 
	
	[ :typeId |
	
	| method |
	method := 
		'test{1}
		| definition | 
			definition :=  browser definition: ''{2}''. 
			self assert: definition typeName = ''{2}''.
			self assert: definition md5Sum = ''{3}''.
		' format: {
			typeId copyReplaceAll: '/' with:'_' capitalized .
			typeId .
			PhaROSTypeBrowser instance md5Sum: typeId
		 }.
		
		PhaROSTypeBrowserTests compile: method classified: 'test-', (typeId copyFrom: 1 to: (typeId indexOf: $/)) .
	]
	.
	
	


	"
	PhaROSTypeBrowserTests compile:  classified: 'test'."
]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowserTests >> setUp [
	super setUp.
	browser := PhaROSTypeBrowser instance.
]

{ #category : #'test-actionlib_msgs/' }
PhaROSTypeBrowserTests >> testactionlib_msgs_GoalID [
		| definition | 
			definition :=  browser definition: 'actionlib_msgs/GoalID'. 
			self assert: definition typeName = 'actionlib_msgs/GoalID'.
			self assert: definition md5Sum = '302881f31927c1df708a2dbab0e80ee8'.
		
]

{ #category : #'test-actionlib_msgs/' }
PhaROSTypeBrowserTests >> testactionlib_msgs_GoalStatus [
		| definition | 
			definition :=  browser definition: 'actionlib_msgs/GoalStatus'. 
			self assert: definition typeName = 'actionlib_msgs/GoalStatus'.
			self assert: definition md5Sum = 'd388f9b87b3c471f784434d671988d4a'.
		
]

{ #category : #'test-actionlib_msgs/' }
PhaROSTypeBrowserTests >> testactionlib_msgs_GoalStatusArray [
		| definition | 
			definition :=  browser definition: 'actionlib_msgs/GoalStatusArray'. 
			self assert: definition typeName = 'actionlib_msgs/GoalStatusArray'.
			self assert: definition md5Sum = '8b2b82f13216d0a8ea88bd3af735e619'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingAction [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingAction'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingAction'.
			self assert: definition md5Sum = '628678f2b4fa6a5951746a4a2d39e716'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingActionFeedback [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingActionFeedback'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingActionFeedback'.
			self assert: definition md5Sum = '78a4a09241b1791069223ae7ebd5b16b'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingActionGoal [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingActionGoal'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingActionGoal'.
			self assert: definition md5Sum = '1561825b734ebd6039851c501e3fb570'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingActionResult [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingActionResult'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingActionResult'.
			self assert: definition md5Sum = '8672cb489d347580acdcd05c5d497497'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingFeedback [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingFeedback'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingFeedback'.
			self assert: definition md5Sum = '9e8dfc53c2f2a032ca33fa80ec46fd4f'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingGoal [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingGoal'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingGoal'.
			self assert: definition md5Sum = '32c9b10ef9b253faa93b93f564762c8f'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingResult [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/AveragingResult'. 
			self assert: definition typeName = 'actionlib_tutorials/AveragingResult'.
			self assert: definition md5Sum = 'd5c7decf6df75ffb4367a05c1bcc7612'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciAction [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciAction'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciAction'.
			self assert: definition md5Sum = 'f59df5767bf7634684781c92598b2406'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciActionFeedback [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciActionFeedback'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciActionFeedback'.
			self assert: definition md5Sum = '73b8497a9f629a31c0020900e4148f07'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciActionGoal [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciActionGoal'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciActionGoal'.
			self assert: definition md5Sum = '006871c7fa1d0e3d5fe2226bf17b2a94'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciActionResult [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciActionResult'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciActionResult'.
			self assert: definition md5Sum = 'bee73a9fe29ae25e966e105f5553dd03'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciFeedback [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciFeedback'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciFeedback'.
			self assert: definition md5Sum = 'b81e37d2a31925a0e8ae261a8699cb79'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciGoal [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciGoal'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciGoal'.
			self assert: definition md5Sum = '6889063349a00b249bd1661df429d822'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciResult [
		| definition | 
			definition :=  browser definition: 'actionlib_tutorials/FibonacciResult'. 
			self assert: definition typeName = 'actionlib_tutorials/FibonacciResult'.
			self assert: definition md5Sum = 'b81e37d2a31925a0e8ae261a8699cb79'.
		
]

{ #category : #'test-base_local_planner/' }
PhaROSTypeBrowserTests >> testbase_local_planner_Position2DInt [
		| definition | 
			definition :=  browser definition: 'base_local_planner/Position2DInt'. 
			self assert: definition typeName = 'base_local_planner/Position2DInt'.
			self assert: definition md5Sum = '3b834ede922a0fff22c43585c533b49f'.
		
]

{ #category : #'test-bond/' }
PhaROSTypeBrowserTests >> testbond_Constants [
		| definition | 
			definition :=  browser definition: 'bond/Constants'. 
			self assert: definition typeName = 'bond/Constants'.
			self assert: definition md5Sum = '6fc594dc1d7bd7919077042712f8c8b0'.
		
]

{ #category : #'test-bond/' }
PhaROSTypeBrowserTests >> testbond_Status [
		| definition | 
			definition :=  browser definition: 'bond/Status'. 
			self assert: definition typeName = 'bond/Status'.
			self assert: definition md5Sum = 'eacc84bf5d65b6777d4c50f463dfb9c8'.
		
]

{ #category : #'test-costmap_2d/' }
PhaROSTypeBrowserTests >> testcostmap_2d_VoxelGrid [
		| definition | 
			definition :=  browser definition: 'costmap_2d/VoxelGrid'. 
			self assert: definition typeName = 'costmap_2d/VoxelGrid'.
			self assert: definition md5Sum = '48a040827e1322073d78ece5a497029c'.
		
]

{ #category : #'test-diagnostic_msgs/' }
PhaROSTypeBrowserTests >> testdiagnostic_msgs_DiagnosticArray [
		| definition | 
			definition :=  browser definition: 'diagnostic_msgs/DiagnosticArray'. 
			self assert: definition typeName = 'diagnostic_msgs/DiagnosticArray'.
			self assert: definition md5Sum = '3cfbeff055e708a24c3d946a5c8139cd'.
		
]

{ #category : #'test-diagnostic_msgs/' }
PhaROSTypeBrowserTests >> testdiagnostic_msgs_DiagnosticStatus [
		| definition | 
			definition :=  browser definition: 'diagnostic_msgs/DiagnosticStatus'. 
			self assert: definition typeName = 'diagnostic_msgs/DiagnosticStatus'.
			self assert: definition md5Sum = '67d15a62edb26e9d52b0f0efa3ef9da7'.
		
]

{ #category : #'test-diagnostic_msgs/' }
PhaROSTypeBrowserTests >> testdiagnostic_msgs_KeyValue [
		| definition | 
			definition :=  browser definition: 'diagnostic_msgs/KeyValue'. 
			self assert: definition typeName = 'diagnostic_msgs/KeyValue'.
			self assert: definition md5Sum = 'cf57fdc6617a881a88c16e768132149c'.
		
]

{ #category : #'test-driver_base/' }
PhaROSTypeBrowserTests >> testdriver_base_ConfigString [
		| definition | 
			definition :=  browser definition: 'driver_base/ConfigString'. 
			self assert: definition typeName = 'driver_base/ConfigString'.
			self assert: definition md5Sum = 'bc6ccc4a57f61779c8eaae61e9f422e0'.
		
]

{ #category : #'test-driver_base/' }
PhaROSTypeBrowserTests >> testdriver_base_ConfigValue [
		| definition | 
			definition :=  browser definition: 'driver_base/ConfigValue'. 
			self assert: definition typeName = 'driver_base/ConfigValue'.
			self assert: definition md5Sum = 'd8512f27253c0f65f928a67c329cd658'.
		
]

{ #category : #'test-driver_base/' }
PhaROSTypeBrowserTests >> testdriver_base_SensorLevels [
		| definition | 
			definition :=  browser definition: 'driver_base/SensorLevels'. 
			self assert: definition typeName = 'driver_base/SensorLevels'.
			self assert: definition md5Sum = '6322637bee96d5489db6e2127c47602c'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_BoolParameter [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/BoolParameter'. 
			self assert: definition typeName = 'dynamic_reconfigure/BoolParameter'.
			self assert: definition md5Sum = '23f05028c1a699fb83e22401228c3a9e'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_Config [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/Config'. 
			self assert: definition typeName = 'dynamic_reconfigure/Config'.
			self assert: definition md5Sum = '958f16a05573709014982821e6822580'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_ConfigDescription [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/ConfigDescription'. 
			self assert: definition typeName = 'dynamic_reconfigure/ConfigDescription'.
			self assert: definition md5Sum = '757ce9d44ba8ddd801bb30bc456f946f'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_DoubleParameter [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/DoubleParameter'. 
			self assert: definition typeName = 'dynamic_reconfigure/DoubleParameter'.
			self assert: definition md5Sum = 'd8512f27253c0f65f928a67c329cd658'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_Group [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/Group'. 
			self assert: definition typeName = 'dynamic_reconfigure/Group'.
			self assert: definition md5Sum = '9e8cd9e9423c94823db3614dd8b1cf7a'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_GroupState [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/GroupState'. 
			self assert: definition typeName = 'dynamic_reconfigure/GroupState'.
			self assert: definition md5Sum = 'a2d87f51dc22930325041a2f8b1571f8'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_IntParameter [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/IntParameter'. 
			self assert: definition typeName = 'dynamic_reconfigure/IntParameter'.
			self assert: definition md5Sum = '65fedc7a0cbfb8db035e46194a350bf1'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_ParamDescription [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/ParamDescription'. 
			self assert: definition typeName = 'dynamic_reconfigure/ParamDescription'.
			self assert: definition md5Sum = '7434fcb9348c13054e0c3b267c8cb34d'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_SensorLevels [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/SensorLevels'. 
			self assert: definition typeName = 'dynamic_reconfigure/SensorLevels'.
			self assert: definition md5Sum = '6322637bee96d5489db6e2127c47602c'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_StrParameter [
		| definition | 
			definition :=  browser definition: 'dynamic_reconfigure/StrParameter'. 
			self assert: definition typeName = 'dynamic_reconfigure/StrParameter'.
			self assert: definition md5Sum = 'bc6ccc4a57f61779c8eaae61e9f422e0'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_ContactState [
		| definition | 
			definition :=  browser definition: 'gazebo/ContactState'. 
			self assert: definition typeName = 'gazebo/ContactState'.
			self assert: definition md5Sum = '7f688fc24d90d16872fdc9ea8c6e45ab'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_ContactsState [
		| definition | 
			definition :=  browser definition: 'gazebo/ContactsState'. 
			self assert: definition typeName = 'gazebo/ContactsState'.
			self assert: definition md5Sum = '9d29ce6da289d3d303cc64b4cfdd0e84'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_LinkState [
		| definition | 
			definition :=  browser definition: 'gazebo/LinkState'. 
			self assert: definition typeName = 'gazebo/LinkState'.
			self assert: definition md5Sum = '0818ebbf28ce3a08d48ab1eaa7309ebe'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_LinkStates [
		| definition | 
			definition :=  browser definition: 'gazebo/LinkStates'. 
			self assert: definition typeName = 'gazebo/LinkStates'.
			self assert: definition md5Sum = '48c080191eb15c41858319b4d8a609c2'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_ModelState [
		| definition | 
			definition :=  browser definition: 'gazebo/ModelState'. 
			self assert: definition typeName = 'gazebo/ModelState'.
			self assert: definition md5Sum = '9330fd35f2fcd82d457e54bd54e10593'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_ModelStates [
		| definition | 
			definition :=  browser definition: 'gazebo/ModelStates'. 
			self assert: definition typeName = 'gazebo/ModelStates'.
			self assert: definition md5Sum = '48c080191eb15c41858319b4d8a609c2'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_ODEJointProperties [
		| definition | 
			definition :=  browser definition: 'gazebo/ODEJointProperties'. 
			self assert: definition typeName = 'gazebo/ODEJointProperties'.
			self assert: definition md5Sum = '1b744c32a920af979f53afe2f9c3511f'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_ODEPhysics [
		| definition | 
			definition :=  browser definition: 'gazebo/ODEPhysics'. 
			self assert: definition typeName = 'gazebo/ODEPhysics'.
			self assert: definition md5Sum = 'cecbd7ae4dd73d0ce24e775cee96d4a6'.
		
]

{ #category : #'test-gazebo/' }
PhaROSTypeBrowserTests >> testgazebo_WorldState [
		| definition | 
			definition :=  browser definition: 'gazebo/WorldState'. 
			self assert: definition typeName = 'gazebo/WorldState'.
			self assert: definition md5Sum = 'de1a9de3ab7ba97ac0e9ec01a4eb481e'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ContactState [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/ContactState'. 
			self assert: definition typeName = 'gazebo_msgs/ContactState'.
			self assert: definition md5Sum = '48c0ffb054b8c444f870cecea1ee50d9'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ContactsState [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/ContactsState'. 
			self assert: definition typeName = 'gazebo_msgs/ContactsState'.
			self assert: definition md5Sum = 'acbcb1601a8e525bf72509f18e6f668d'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_LinkState [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/LinkState'. 
			self assert: definition typeName = 'gazebo_msgs/LinkState'.
			self assert: definition md5Sum = '0818ebbf28ce3a08d48ab1eaa7309ebe'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_LinkStates [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/LinkStates'. 
			self assert: definition typeName = 'gazebo_msgs/LinkStates'.
			self assert: definition md5Sum = '48c080191eb15c41858319b4d8a609c2'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ModelState [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/ModelState'. 
			self assert: definition typeName = 'gazebo_msgs/ModelState'.
			self assert: definition md5Sum = '9330fd35f2fcd82d457e54bd54e10593'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ModelStates [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/ModelStates'. 
			self assert: definition typeName = 'gazebo_msgs/ModelStates'.
			self assert: definition md5Sum = '48c080191eb15c41858319b4d8a609c2'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ODEJointProperties [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/ODEJointProperties'. 
			self assert: definition typeName = 'gazebo_msgs/ODEJointProperties'.
			self assert: definition md5Sum = '1b744c32a920af979f53afe2f9c3511f'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ODEPhysics [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/ODEPhysics'. 
			self assert: definition typeName = 'gazebo_msgs/ODEPhysics'.
			self assert: definition md5Sum = '667d56ddbd547918c32d1934503dc335'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_WorldState [
		| definition | 
			definition :=  browser definition: 'gazebo_msgs/WorldState'. 
			self assert: definition typeName = 'gazebo_msgs/WorldState'.
			self assert: definition md5Sum = 'de1a9de3ab7ba97ac0e9ec01a4eb481e'.
		
]

{ #category : #'test-gazebo_plugins/' }
PhaROSTypeBrowserTests >> testgazebo_plugins_ContactsState [
		| definition | 
			definition :=  browser definition: 'gazebo_plugins/ContactsState'. 
			self assert: definition typeName = 'gazebo_plugins/ContactsState'.
			self assert: definition md5Sum = 'acbcb1601a8e525bf72509f18e6f668d'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Point [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Point'. 
			self assert: definition typeName = 'geometry_msgs/Point'.
			self assert: definition md5Sum = '4a842b65f413084dc2b10fb484ea7f17'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Point32 [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Point32'. 
			self assert: definition typeName = 'geometry_msgs/Point32'.
			self assert: definition md5Sum = 'cc153912f1453b708d221682bc23d9ac'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PointStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/PointStamped'. 
			self assert: definition typeName = 'geometry_msgs/PointStamped'.
			self assert: definition md5Sum = 'c63aecb41bfdfd6b7e1fac37c7cbe7bf'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Polygon [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Polygon'. 
			self assert: definition typeName = 'geometry_msgs/Polygon'.
			self assert: definition md5Sum = 'cd60a26494a087f577976f0329fa120e'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PolygonStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/PolygonStamped'. 
			self assert: definition typeName = 'geometry_msgs/PolygonStamped'.
			self assert: definition md5Sum = 'c6be8f7dc3bee7fe9e8d296070f53340'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Pose [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Pose'. 
			self assert: definition typeName = 'geometry_msgs/Pose'.
			self assert: definition md5Sum = 'e45d45a5a1ce597b249e23fb30fc871f'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Pose2D [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Pose2D'. 
			self assert: definition typeName = 'geometry_msgs/Pose2D'.
			self assert: definition md5Sum = '938fa65709584ad8e77d238529be13b8'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseArray [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/PoseArray'. 
			self assert: definition typeName = 'geometry_msgs/PoseArray'.
			self assert: definition md5Sum = '916c28c5764443f268b296bb671b9d97'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/PoseStamped'. 
			self assert: definition typeName = 'geometry_msgs/PoseStamped'.
			self assert: definition md5Sum = 'd3812c3cbc69362b77dc0b19b345f8f5'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseWithCovariance [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/PoseWithCovariance'. 
			self assert: definition typeName = 'geometry_msgs/PoseWithCovariance'.
			self assert: definition md5Sum = 'c23e848cf1b7533a8d7c259073a97e6f'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseWithCovarianceStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/PoseWithCovarianceStamped'. 
			self assert: definition typeName = 'geometry_msgs/PoseWithCovarianceStamped'.
			self assert: definition md5Sum = '953b798c0f514ff060a53a3498ce6246'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Quaternion [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Quaternion'. 
			self assert: definition typeName = 'geometry_msgs/Quaternion'.
			self assert: definition md5Sum = 'a779879fadf0160734f906b8c19c7004'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_QuaternionStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/QuaternionStamped'. 
			self assert: definition typeName = 'geometry_msgs/QuaternionStamped'.
			self assert: definition md5Sum = 'e57f1e547e0e1fd13504588ffc8334e2'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Transform [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Transform'. 
			self assert: definition typeName = 'geometry_msgs/Transform'.
			self assert: definition md5Sum = 'ac9eff44abf714214112b05d54a3cf9b'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TransformStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/TransformStamped'. 
			self assert: definition typeName = 'geometry_msgs/TransformStamped'.
			self assert: definition md5Sum = 'b5764a33bfeb3588febc2682852579b0'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Twist [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Twist'. 
			self assert: definition typeName = 'geometry_msgs/Twist'.
			self assert: definition md5Sum = '9f195f881246fdfa2798d1d3eebca84a'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TwistStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/TwistStamped'. 
			self assert: definition typeName = 'geometry_msgs/TwistStamped'.
			self assert: definition md5Sum = '98d34b0043a2093cf9d9345ab6eef12e'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TwistWithCovariance [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/TwistWithCovariance'. 
			self assert: definition typeName = 'geometry_msgs/TwistWithCovariance'.
			self assert: definition md5Sum = '1fe8a28e6890a4cc3ae4c3ca5c7d82e6'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TwistWithCovarianceStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/TwistWithCovarianceStamped'. 
			self assert: definition typeName = 'geometry_msgs/TwistWithCovarianceStamped'.
			self assert: definition md5Sum = '8927a1a12fb2607ceea095b2dc440a96'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Vector3 [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Vector3'. 
			self assert: definition typeName = 'geometry_msgs/Vector3'.
			self assert: definition md5Sum = '4a842b65f413084dc2b10fb484ea7f17'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Vector3Stamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Vector3Stamped'. 
			self assert: definition typeName = 'geometry_msgs/Vector3Stamped'.
			self assert: definition md5Sum = '7b324c7325e683bf02a9b14b01090ec7'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Wrench [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/Wrench'. 
			self assert: definition typeName = 'geometry_msgs/Wrench'.
			self assert: definition md5Sum = '4f539cf138b23283b520fd271b567936'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_WrenchStamped [
		| definition | 
			definition :=  browser definition: 'geometry_msgs/WrenchStamped'. 
			self assert: definition typeName = 'geometry_msgs/WrenchStamped'.
			self assert: definition md5Sum = 'd78d3cb249ce23087ade7e7d0c40cfa7'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseAction [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseAction'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseAction'.
			self assert: definition md5Sum = '70b6aca7c7f7746d8d1609ad94c80bb8'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseActionFeedback [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseActionFeedback'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseActionFeedback'.
			self assert: definition md5Sum = '7d1870ff6e0decea702b943b5af0b42e'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseActionGoal [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseActionGoal'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseActionGoal'.
			self assert: definition md5Sum = '660d6895a1b9a16dce51fbdd9a64a56b'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseActionResult [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseActionResult'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseActionResult'.
			self assert: definition md5Sum = '1eb06eeff08fa7ea874431638cb52332'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseFeedback [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseFeedback'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseFeedback'.
			self assert: definition md5Sum = '3fb824c456a757373a226f6d08071bf0'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseGoal [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseGoal'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseGoal'.
			self assert: definition md5Sum = '257d089627d7eb7136c24d3593d05a16'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseResult [
		| definition | 
			definition :=  browser definition: 'move_base_msgs/MoveBaseResult'. 
			self assert: definition typeName = 'move_base_msgs/MoveBaseResult'.
			self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GridCells [
		| definition | 
			definition :=  browser definition: 'nav_msgs/GridCells'. 
			self assert: definition typeName = 'nav_msgs/GridCells'.
			self assert: definition md5Sum = 'b9e4f5df6d28e272ebde00a3994830f5'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_MapMetaData [
		| definition | 
			definition :=  browser definition: 'nav_msgs/MapMetaData'. 
			self assert: definition typeName = 'nav_msgs/MapMetaData'.
			self assert: definition md5Sum = '10cfc8a2818024d3248802c00c95f11b'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_OccupancyGrid [
		| definition | 
			definition :=  browser definition: 'nav_msgs/OccupancyGrid'. 
			self assert: definition typeName = 'nav_msgs/OccupancyGrid'.
			self assert: definition md5Sum = '3381f2d731d4076ec5c71b0759edbe4e'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_Odometry [
		| definition | 
			definition :=  browser definition: 'nav_msgs/Odometry'. 
			self assert: definition typeName = 'nav_msgs/Odometry'.
			self assert: definition md5Sum = 'cd5e73d190d741a2f92e81eda573aca7'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_Path [
		| definition | 
			definition :=  browser definition: 'nav_msgs/Path'. 
			self assert: definition typeName = 'nav_msgs/Path'.
			self assert: definition md5Sum = '6227e2b7e9cce15051f669a5e197bbf7'.
		
]

{ #category : #'test-perf_roscpp/' }
PhaROSTypeBrowserTests >> testperf_roscpp_LatencyMessage [
		| definition | 
			definition :=  browser definition: 'perf_roscpp/LatencyMessage'. 
			self assert: definition typeName = 'perf_roscpp/LatencyMessage'.
			self assert: definition md5Sum = 'be90d117303321f392404ed7edeb7c8c'.
		
]

{ #category : #'test-perf_roscpp/' }
PhaROSTypeBrowserTests >> testperf_roscpp_ThroughputMessage [
		| definition | 
			definition :=  browser definition: 'perf_roscpp/ThroughputMessage'. 
			self assert: definition typeName = 'perf_roscpp/ThroughputMessage'.
			self assert: definition md5Sum = 'dda33390139e301b6c212139192418ca'.
		
]

{ #category : #'test-roscpp/' }
PhaROSTypeBrowserTests >> testroscpp_Logger [
		| definition | 
			definition :=  browser definition: 'roscpp/Logger'. 
			self assert: definition typeName = 'roscpp/Logger'.
			self assert: definition md5Sum = 'a6069a2ff40db7bd32143dd66e1f408e'.
		
]

{ #category : #'test-rosgraph_msgs/' }
PhaROSTypeBrowserTests >> testrosgraph_msgs_Clock [
		| definition | 
			definition :=  browser definition: 'rosgraph_msgs/Clock'. 
			self assert: definition typeName = 'rosgraph_msgs/Clock'.
			self assert: definition md5Sum = 'a9c97c1d230cfc112e270351a944ee47'.
		
]

{ #category : #'test-rosgraph_msgs/' }
PhaROSTypeBrowserTests >> testrosgraph_msgs_Log [
		| definition | 
			definition :=  browser definition: 'rosgraph_msgs/Log'. 
			self assert: definition typeName = 'rosgraph_msgs/Log'.
			self assert: definition md5Sum = 'acffd30cd6b6de30f120938c17c593fb'.
		
]

{ #category : #'test-rospy_tutorials/' }
PhaROSTypeBrowserTests >> testrospy_tutorials_Floats [
		| definition | 
			definition :=  browser definition: 'rospy_tutorials/Floats'. 
			self assert: definition typeName = 'rospy_tutorials/Floats'.
			self assert: definition md5Sum = '420cd38b6b071cd49f2970c3e2cee511'.
		
]

{ #category : #'test-rospy_tutorials/' }
PhaROSTypeBrowserTests >> testrospy_tutorials_HeaderString [
		| definition | 
			definition :=  browser definition: 'rospy_tutorials/HeaderString'. 
			self assert: definition typeName = 'rospy_tutorials/HeaderString'.
			self assert: definition md5Sum = 'c99a9440709e4d4a9716d55b8270d5e7'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_CameraInfo [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/CameraInfo'. 
			self assert: definition typeName = 'sensor_msgs/CameraInfo'.
			self assert: definition md5Sum = 'c9a58c1b0b154e0e6da7578cb991d214'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_ChannelFloat32 [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/ChannelFloat32'. 
			self assert: definition typeName = 'sensor_msgs/ChannelFloat32'.
			self assert: definition md5Sum = '3d40139cdd33dfedcb71ffeeeb42ae7f'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_CompressedImage [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/CompressedImage'. 
			self assert: definition typeName = 'sensor_msgs/CompressedImage'.
			self assert: definition md5Sum = '8f7a12909da2c9d3332d540a0977563f'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Image [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/Image'. 
			self assert: definition typeName = 'sensor_msgs/Image'.
			self assert: definition md5Sum = '060021388200f6f0f447d0fcd9c64743'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Imu [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/Imu'. 
			self assert: definition typeName = 'sensor_msgs/Imu'.
			self assert: definition md5Sum = '6a62c6daae103f4ff57a132d6f95cec2'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_JointState [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/JointState'. 
			self assert: definition typeName = 'sensor_msgs/JointState'.
			self assert: definition md5Sum = '3066dcd76a6cfaef579bd0f34173e9fd'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Joy [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/Joy'. 
			self assert: definition typeName = 'sensor_msgs/Joy'.
			self assert: definition md5Sum = '5a9ea5f83505693b71e785041e67a8bb'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_JoyFeedback [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/JoyFeedback'. 
			self assert: definition typeName = 'sensor_msgs/JoyFeedback'.
			self assert: definition md5Sum = 'f4dcd73460360d98f36e55ee7f2e46f1'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_JoyFeedbackArray [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/JoyFeedbackArray'. 
			self assert: definition typeName = 'sensor_msgs/JoyFeedbackArray'.
			self assert: definition md5Sum = 'cde5730a895b1fc4dee6f91b754b213d'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_LaserScan [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/LaserScan'. 
			self assert: definition typeName = 'sensor_msgs/LaserScan'.
			self assert: definition md5Sum = '90c7ef2dc6895d81024acba2ac42f369'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_NavSatFix [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/NavSatFix'. 
			self assert: definition typeName = 'sensor_msgs/NavSatFix'.
			self assert: definition md5Sum = '2d3a8cd499b9b4a0249fb98fd05cfa48'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_NavSatStatus [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/NavSatStatus'. 
			self assert: definition typeName = 'sensor_msgs/NavSatStatus'.
			self assert: definition md5Sum = '331cdbddfa4bc96ffc3b9ad98900a54c'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_PointCloud [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/PointCloud'. 
			self assert: definition typeName = 'sensor_msgs/PointCloud'.
			self assert: definition md5Sum = 'd8e9c3f5afbdd8a130fd1d2763945fca'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_PointCloud2 [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/PointCloud2'. 
			self assert: definition typeName = 'sensor_msgs/PointCloud2'.
			self assert: definition md5Sum = '1158d486dd51d683ce2f1be655c3c181'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_PointField [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/PointField'. 
			self assert: definition typeName = 'sensor_msgs/PointField'.
			self assert: definition md5Sum = '268eacb2962780ceac86cbd17e328150'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Range [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/Range'. 
			self assert: definition typeName = 'sensor_msgs/Range'.
			self assert: definition md5Sum = 'c005c34273dc426c67a020a87bc24148'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_RegionOfInterest [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/RegionOfInterest'. 
			self assert: definition typeName = 'sensor_msgs/RegionOfInterest'.
			self assert: definition md5Sum = 'bdb633039d588fcccb441a4d43ccfe09'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_TimeReference [
		| definition | 
			definition :=  browser definition: 'sensor_msgs/TimeReference'. 
			self assert: definition typeName = 'sensor_msgs/TimeReference'.
			self assert: definition md5Sum = 'fded64a0265108ba86c3d38fb11c0c16'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_Mesh [
		| definition | 
			definition :=  browser definition: 'shape_msgs/Mesh'. 
			self assert: definition typeName = 'shape_msgs/Mesh'.
			self assert: definition md5Sum = '1ffdae9486cd3316a121c578b47a85cc'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_MeshTriangle [
		| definition | 
			definition :=  browser definition: 'shape_msgs/MeshTriangle'. 
			self assert: definition typeName = 'shape_msgs/MeshTriangle'.
			self assert: definition md5Sum = '23688b2e6d2de3d32fe8af104a903253'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_Plane [
		| definition | 
			definition :=  browser definition: 'shape_msgs/Plane'. 
			self assert: definition typeName = 'shape_msgs/Plane'.
			self assert: definition md5Sum = '2c1b92ed8f31492f8e73f6a4a44ca796'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_SolidPrimitive [
		| definition | 
			definition :=  browser definition: 'shape_msgs/SolidPrimitive'. 
			self assert: definition typeName = 'shape_msgs/SolidPrimitive'.
			self assert: definition md5Sum = 'd8f8cbc74c5ff283fca29569ccefb45d'.
		
]

{ #category : #'test-smach_msgs/' }
PhaROSTypeBrowserTests >> testsmach_msgs_SmachContainerInitialStatusCmd [
		| definition | 
			definition :=  browser definition: 'smach_msgs/SmachContainerInitialStatusCmd'. 
			self assert: definition typeName = 'smach_msgs/SmachContainerInitialStatusCmd'.
			self assert: definition md5Sum = '45f8cf31fc29b829db77f23001f788d6'.
		
]

{ #category : #'test-smach_msgs/' }
PhaROSTypeBrowserTests >> testsmach_msgs_SmachContainerStatus [
		| definition | 
			definition :=  browser definition: 'smach_msgs/SmachContainerStatus'. 
			self assert: definition typeName = 'smach_msgs/SmachContainerStatus'.
			self assert: definition md5Sum = '5ba2bb79ac19e3842d562a191f2a675b'.
		
]

{ #category : #'test-smach_msgs/' }
PhaROSTypeBrowserTests >> testsmach_msgs_SmachContainerStructure [
		| definition | 
			definition :=  browser definition: 'smach_msgs/SmachContainerStructure'. 
			self assert: definition typeName = 'smach_msgs/SmachContainerStructure'.
			self assert: definition md5Sum = '3d3d1e0d0f99779ee9e58101a5dcf7ea'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Bool [
		| definition | 
			definition :=  browser definition: 'std_msgs/Bool'. 
			self assert: definition typeName = 'std_msgs/Bool'.
			self assert: definition md5Sum = '8b94c1b53db61fb6aed406028ad6332a'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Byte [
		| definition | 
			definition :=  browser definition: 'std_msgs/Byte'. 
			self assert: definition typeName = 'std_msgs/Byte'.
			self assert: definition md5Sum = 'ad736a2e8818154c487bb80fe42ce43b'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_ByteMultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/ByteMultiArray'. 
			self assert: definition typeName = 'std_msgs/ByteMultiArray'.
			self assert: definition md5Sum = '70ea476cbcfd65ac2f68f3cda1e891fe'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Char [
		| definition | 
			definition :=  browser definition: 'std_msgs/Char'. 
			self assert: definition typeName = 'std_msgs/Char'.
			self assert: definition md5Sum = '1bf77f25acecdedba0e224b162199717'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_ColorRGBA [
		| definition | 
			definition :=  browser definition: 'std_msgs/ColorRGBA'. 
			self assert: definition typeName = 'std_msgs/ColorRGBA'.
			self assert: definition md5Sum = 'a29a96539573343b1310c73607334b00'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Duration [
		| definition | 
			definition :=  browser definition: 'std_msgs/Duration'. 
			self assert: definition typeName = 'std_msgs/Duration'.
			self assert: definition md5Sum = '3e286caf4241d664e55f3ad380e2ae46'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Empty [
		| definition | 
			definition :=  browser definition: 'std_msgs/Empty'. 
			self assert: definition typeName = 'std_msgs/Empty'.
			self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float32 [
		| definition | 
			definition :=  browser definition: 'std_msgs/Float32'. 
			self assert: definition typeName = 'std_msgs/Float32'.
			self assert: definition md5Sum = '73fcbf46b49191e672908e50842a83d4'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float32MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/Float32MultiArray'. 
			self assert: definition typeName = 'std_msgs/Float32MultiArray'.
			self assert: definition md5Sum = '6a40e0ffa6a17a503ac3f8616991b1f6'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float64 [
		| definition | 
			definition :=  browser definition: 'std_msgs/Float64'. 
			self assert: definition typeName = 'std_msgs/Float64'.
			self assert: definition md5Sum = 'fdb28210bfa9d7c91146260178d9a584'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float64MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/Float64MultiArray'. 
			self assert: definition typeName = 'std_msgs/Float64MultiArray'.
			self assert: definition md5Sum = '4b7d974086d4060e7db4613a7e6c3ba4'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Header [
		| definition | 
			definition :=  browser definition: 'std_msgs/Header'. 
			self assert: definition typeName = 'std_msgs/Header'.
			self assert: definition md5Sum = '2176decaecbce78abc3b96ef049fabed'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int16 [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int16'. 
			self assert: definition typeName = 'std_msgs/Int16'.
			self assert: definition md5Sum = '8524586e34fbd7cb1c08c5f5f1ca0e57'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int16MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int16MultiArray'. 
			self assert: definition typeName = 'std_msgs/Int16MultiArray'.
			self assert: definition md5Sum = 'd9338d7f523fcb692fae9d0a0e9f067c'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int32 [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int32'. 
			self assert: definition typeName = 'std_msgs/Int32'.
			self assert: definition md5Sum = 'da5909fbe378aeaf85e547e830cc1bb7'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int32MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int32MultiArray'. 
			self assert: definition typeName = 'std_msgs/Int32MultiArray'.
			self assert: definition md5Sum = '1d99f79f8b325b44fee908053e9c945b'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int64 [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int64'. 
			self assert: definition typeName = 'std_msgs/Int64'.
			self assert: definition md5Sum = '34add168574510e6e17f5d23ecc077ef'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int64MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int64MultiArray'. 
			self assert: definition typeName = 'std_msgs/Int64MultiArray'.
			self assert: definition md5Sum = '54865aa6c65be0448113a2afc6a49270'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int8 [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int8'. 
			self assert: definition typeName = 'std_msgs/Int8'.
			self assert: definition md5Sum = '27ffa0c9c4b8fb8492252bcad9e5c57b'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int8MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/Int8MultiArray'. 
			self assert: definition typeName = 'std_msgs/Int8MultiArray'.
			self assert: definition md5Sum = 'd7c1af35a1b4781bbe79e03dd94b7c13'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_MultiArrayDimension [
		| definition | 
			definition :=  browser definition: 'std_msgs/MultiArrayDimension'. 
			self assert: definition typeName = 'std_msgs/MultiArrayDimension'.
			self assert: definition md5Sum = '4cd0c83a8683deae40ecdac60e53bfa8'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_MultiArrayLayout [
		| definition | 
			definition :=  browser definition: 'std_msgs/MultiArrayLayout'. 
			self assert: definition typeName = 'std_msgs/MultiArrayLayout'.
			self assert: definition md5Sum = '0fed2a11c13e11c5571b4e2a995a91a3'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_String [
		| definition | 
			definition :=  browser definition: 'std_msgs/String'. 
			self assert: definition typeName = 'std_msgs/String'.
			self assert: definition md5Sum = '992ce8a1687cec8c8bd883ec73ca41d1'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Time [
		| definition | 
			definition :=  browser definition: 'std_msgs/Time'. 
			self assert: definition typeName = 'std_msgs/Time'.
			self assert: definition md5Sum = 'cd7166c74c552c311fbcc2fe5a7bc289'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt16 [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt16'. 
			self assert: definition typeName = 'std_msgs/UInt16'.
			self assert: definition md5Sum = '1df79edf208b629fe6b81923a544552d'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt16MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt16MultiArray'. 
			self assert: definition typeName = 'std_msgs/UInt16MultiArray'.
			self assert: definition md5Sum = '52f264f1c973c4b73790d384c6cb4484'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt32 [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt32'. 
			self assert: definition typeName = 'std_msgs/UInt32'.
			self assert: definition md5Sum = '304a39449588c7f8ce2df6e8001c5fce'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt32MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt32MultiArray'. 
			self assert: definition typeName = 'std_msgs/UInt32MultiArray'.
			self assert: definition md5Sum = '4d6a180abc9be191b96a7eda6c8a233d'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt64 [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt64'. 
			self assert: definition typeName = 'std_msgs/UInt64'.
			self assert: definition md5Sum = '1b2a79973e8bf53d7b53acb71299cb57'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt64MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt64MultiArray'. 
			self assert: definition typeName = 'std_msgs/UInt64MultiArray'.
			self assert: definition md5Sum = '6088f127afb1d6c72927aa1247e945af'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt8 [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt8'. 
			self assert: definition typeName = 'std_msgs/UInt8'.
			self assert: definition md5Sum = '7c8164229e7d2c17eb95e9231617fdee'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt8MultiArray [
		| definition | 
			definition :=  browser definition: 'std_msgs/UInt8MultiArray'. 
			self assert: definition typeName = 'std_msgs/UInt8MultiArray'.
			self assert: definition md5Sum = '82373f1612381bb6ee473b5cd6f5d89c'.
		
]

{ #category : #'test-stereo_msgs/' }
PhaROSTypeBrowserTests >> teststereo_msgs_DisparityImage [
		| definition | 
			definition :=  browser definition: 'stereo_msgs/DisparityImage'. 
			self assert: definition typeName = 'stereo_msgs/DisparityImage'.
			self assert: definition md5Sum = '04a177815f75271039fa21f16acad8c9'.
		
]

{ #category : #'test-test_crosspackage/' }
PhaROSTypeBrowserTests >> testtest_crosspackage_TestMsgRename [
		| definition | 
			definition :=  browser definition: 'test_crosspackage/TestMsgRename'. 
			self assert: definition typeName = 'test_crosspackage/TestMsgRename'.
			self assert: definition md5Sum = '796739ec6543fa03d2eb39f3aacaa2c0'.
		
]

{ #category : #'test-test_crosspackage/' }
PhaROSTypeBrowserTests >> testtest_crosspackage_TestSubMsgRename [
		| definition | 
			definition :=  browser definition: 'test_crosspackage/TestSubMsgRename'. 
			self assert: definition typeName = 'test_crosspackage/TestSubMsgRename'.
			self assert: definition md5Sum = 'cb68fa50979d62961325d38238e6074d'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_Arrays [
		| definition | 
			definition :=  browser definition: 'test_ros/Arrays'. 
			self assert: definition typeName = 'test_ros/Arrays'.
			self assert: definition md5Sum = 'c5a1f18379b10bdd4df210944f6007a4'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_Composite [
		| definition | 
			definition :=  browser definition: 'test_ros/Composite'. 
			self assert: definition typeName = 'test_ros/Composite'.
			self assert: definition md5Sum = 'd8fb6eb869ad3956b50e8737d96dc9fa'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_CompositeA [
		| definition | 
			definition :=  browser definition: 'test_ros/CompositeA'. 
			self assert: definition typeName = 'test_ros/CompositeA'.
			self assert: definition md5Sum = 'a779879fadf0160734f906b8c19c7004'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_CompositeB [
		| definition | 
			definition :=  browser definition: 'test_ros/CompositeB'. 
			self assert: definition typeName = 'test_ros/CompositeB'.
			self assert: definition md5Sum = '4a842b65f413084dc2b10fb484ea7f17'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_Embed [
		| definition | 
			definition :=  browser definition: 'test_ros/Embed'. 
			self assert: definition typeName = 'test_ros/Embed'.
			self assert: definition md5Sum = '6dec891298f3675c2d964c161d28efaa'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_Floats [
		| definition | 
			definition :=  browser definition: 'test_ros/Floats'. 
			self assert: definition typeName = 'test_ros/Floats'.
			self assert: definition md5Sum = '1ee8aba2d870f75f2b5916e2cddbd928'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_RosmsgA [
		| definition | 
			definition :=  browser definition: 'test_ros/RosmsgA'. 
			self assert: definition typeName = 'test_ros/RosmsgA'.
			self assert: definition md5Sum = '5c9fb1a886e81e3162a5c87bf55c072b'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_RosmsgB [
		| definition | 
			definition :=  browser definition: 'test_ros/RosmsgB'. 
			self assert: definition typeName = 'test_ros/RosmsgB'.
			self assert: definition md5Sum = '6aac6c697d5414bc0fcede8c33981d0e'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_RosmsgC [
		| definition | 
			definition :=  browser definition: 'test_ros/RosmsgC'. 
			self assert: definition typeName = 'test_ros/RosmsgC'.
			self assert: definition md5Sum = 'cc91a7e3c1498150f3554cbcab2800d2'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_Simple [
		| definition | 
			definition :=  browser definition: 'test_ros/Simple'. 
			self assert: definition typeName = 'test_ros/Simple'.
			self assert: definition md5Sum = 'c9940b1313e61fed87cd22c50742578f'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_TVals [
		| definition | 
			definition :=  browser definition: 'test_ros/TVals'. 
			self assert: definition typeName = 'test_ros/TVals'.
			self assert: definition md5Sum = 'ae4d4f9600b9ab683a5dc9372c031758'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_TestArrays [
		| definition | 
			definition :=  browser definition: 'test_ros/TestArrays'. 
			self assert: definition typeName = 'test_ros/TestArrays'.
			self assert: definition md5Sum = '4cc9b5e2cebe791aa3e994f5bc159eb6'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_TestHeader [
		| definition | 
			definition :=  browser definition: 'test_ros/TestHeader'. 
			self assert: definition typeName = 'test_ros/TestHeader'.
			self assert: definition md5Sum = '4b5a00f536da2f756ba6aebcf795a967'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_TestPrimitives [
		| definition | 
			definition :=  browser definition: 'test_ros/TestPrimitives'. 
			self assert: definition typeName = 'test_ros/TestPrimitives'.
			self assert: definition md5Sum = '3e70f428a22c0d26ca67f87802c8e00f'.
		
]

{ #category : #'test-test_ros/' }
PhaROSTypeBrowserTests >> testtest_ros_TestString [
		| definition | 
			definition :=  browser definition: 'test_ros/TestString'. 
			self assert: definition typeName = 'test_ros/TestString'.
			self assert: definition md5Sum = '334ff4377be93faa44ebc66d23d40fd3'.
		
]

{ #category : #'test-test_roscpp/' }
PhaROSTypeBrowserTests >> testtest_roscpp_TestArray [
		| definition | 
			definition :=  browser definition: 'test_roscpp/TestArray'. 
			self assert: definition typeName = 'test_roscpp/TestArray'.
			self assert: definition md5Sum = 'f7c2f87680985b118316f81f28b4cfd5'.
		
]

{ #category : #'test-test_roscpp/' }
PhaROSTypeBrowserTests >> testtest_roscpp_TestEmpty [
		| definition | 
			definition :=  browser definition: 'test_roscpp/TestEmpty'. 
			self assert: definition typeName = 'test_roscpp/TestEmpty'.
			self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-test_roscpp/' }
PhaROSTypeBrowserTests >> testtest_roscpp_TestStringInt [
		| definition | 
			definition :=  browser definition: 'test_roscpp/TestStringInt'. 
			self assert: definition typeName = 'test_roscpp/TestStringInt'.
			self assert: definition md5Sum = '2f0ceb8aa4bbf4dbd240039d0bf240ca'.
		
]

{ #category : #'test-test_roscpp/' }
PhaROSTypeBrowserTests >> testtest_roscpp_TestWithHeader [
		| definition | 
			definition :=  browser definition: 'test_roscpp/TestWithHeader'. 
			self assert: definition typeName = 'test_roscpp/TestWithHeader'.
			self assert: definition md5Sum = 'd7be0bb39af8fb9129d5a76e6b63a290'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_ArrayOfFixedLength [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/ArrayOfFixedLength'. 
			self assert: definition typeName = 'test_roscpp_serialization/ArrayOfFixedLength'.
			self assert: definition md5Sum = '770e15962592d1fbea70b6b820ba16d9'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_ArrayOfVariableLength [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/ArrayOfVariableLength'. 
			self assert: definition typeName = 'test_roscpp_serialization/ArrayOfVariableLength'.
			self assert: definition md5Sum = 'e7404d454a50b82c426a3a2c76fbcefd'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_Constants [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/Constants'. 
			self assert: definition typeName = 'test_roscpp_serialization/Constants'.
			self assert: definition md5Sum = '0032309c8dd2c569e0e0d0e75974e750'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_CustomHeader [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/CustomHeader'. 
			self assert: definition typeName = 'test_roscpp_serialization/CustomHeader'.
			self assert: definition md5Sum = 'a5233fa4f3f6e00d1d85da1779d19d1e'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_EmbeddedExternal [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/EmbeddedExternal'. 
			self assert: definition typeName = 'test_roscpp_serialization/EmbeddedExternal'.
			self assert: definition md5Sum = 'a09b324865f98bbf605e59ed0cefbc1d'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_EmbeddedFixedLength [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/EmbeddedFixedLength'. 
			self assert: definition typeName = 'test_roscpp_serialization/EmbeddedFixedLength'.
			self assert: definition md5Sum = '770e15962592d1fbea70b6b820ba16d9'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_EmbeddedVariableLength [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/EmbeddedVariableLength'. 
			self assert: definition typeName = 'test_roscpp_serialization/EmbeddedVariableLength'.
			self assert: definition md5Sum = 'e7404d454a50b82c426a3a2c76fbcefd'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_FixedLength [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/FixedLength'. 
			self assert: definition typeName = 'test_roscpp_serialization/FixedLength'.
			self assert: definition md5Sum = '74143e1090cf694294f589605908b555'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_FixedLengthArrayOfExternal [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/FixedLengthArrayOfExternal'. 
			self assert: definition typeName = 'test_roscpp_serialization/FixedLengthArrayOfExternal'.
			self assert: definition md5Sum = 'cc431047757f431ecd2754e03aa592f8'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_FixedLengthStringArray [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/FixedLengthStringArray'. 
			self assert: definition typeName = 'test_roscpp_serialization/FixedLengthStringArray'.
			self assert: definition md5Sum = '8e291ac046196a95bbe34c1555b382cc'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_HeaderNotFirstMember [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/HeaderNotFirstMember'. 
			self assert: definition typeName = 'test_roscpp_serialization/HeaderNotFirstMember'.
			self assert: definition md5Sum = 'c7ed781820d7a36c5947d0f441f50964'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_VariableLength [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/VariableLength'. 
			self assert: definition typeName = 'test_roscpp_serialization/VariableLength'.
			self assert: definition md5Sum = 'd9a532f93b9aeffe09e3bc21ff3de0f0'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_VariableLengthArrayOfExternal [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/VariableLengthArrayOfExternal'. 
			self assert: definition typeName = 'test_roscpp_serialization/VariableLengthArrayOfExternal'.
			self assert: definition md5Sum = 'cc431047757f431ecd2754e03aa592f8'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_VariableLengthStringArray [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/VariableLengthStringArray'. 
			self assert: definition typeName = 'test_roscpp_serialization/VariableLengthStringArray'.
			self assert: definition md5Sum = 'fa992b5cca963995275d2a2f3ee7615f'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_WithDuration [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/WithDuration'. 
			self assert: definition typeName = 'test_roscpp_serialization/WithDuration'.
			self assert: definition md5Sum = '7ad52ba9d0229ba8b9c032400c77c367'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_WithHeader [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/WithHeader'. 
			self assert: definition typeName = 'test_roscpp_serialization/WithHeader'.
			self assert: definition md5Sum = 'ea0b9ad283b0d4dcc850b560da7b6965'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_WithMemberNamedHeaderThatIsNotAHeader [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/WithMemberNamedHeaderThatIsNotAHeader'. 
			self assert: definition typeName = 'test_roscpp_serialization/WithMemberNamedHeaderThatIsNotAHeader'.
			self assert: definition md5Sum = '59a71bc6c7b0e5643fa9d213cdf4c63c'.
		
]

{ #category : #'test-test_roscpp_serialization/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_WithTime [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization/WithTime'. 
			self assert: definition typeName = 'test_roscpp_serialization/WithTime'.
			self assert: definition md5Sum = '60f189e40cfeaefbc79e6cdbd1605364'.
		
]

{ #category : #'test-test_roscpp_serialization_perf/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_perf_ChannelFloat32 [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization_perf/ChannelFloat32'. 
			self assert: definition typeName = 'test_roscpp_serialization_perf/ChannelFloat32'.
			self assert: definition md5Sum = '61c47e4621e471c885edb248b5dcafd5'.
		
]

{ #category : #'test-test_roscpp_serialization_perf/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_perf_Point32 [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization_perf/Point32'. 
			self assert: definition typeName = 'test_roscpp_serialization_perf/Point32'.
			self assert: definition md5Sum = 'cc153912f1453b708d221682bc23d9ac'.
		
]

{ #category : #'test-test_roscpp_serialization_perf/' }
PhaROSTypeBrowserTests >> testtest_roscpp_serialization_perf_PointCloud [
		| definition | 
			definition :=  browser definition: 'test_roscpp_serialization_perf/PointCloud'. 
			self assert: definition typeName = 'test_roscpp_serialization_perf/PointCloud'.
			self assert: definition md5Sum = 'c47b5cedd2b77d241b27547ed7624840'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_ArrayOfMsgs [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/ArrayOfMsgs'. 
			self assert: definition typeName = 'test_roslib_comm/ArrayOfMsgs'.
			self assert: definition md5Sum = '1f4cf3ffabe2555a0cfe19c974f01a01'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_FieldNameChange1 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/FieldNameChange1'. 
			self assert: definition typeName = 'test_roslib_comm/FieldNameChange1'.
			self assert: definition md5Sum = '31a9992534c4d020bfc4045e7dc1a786'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_FieldNameChange2 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/FieldNameChange2'. 
			self assert: definition typeName = 'test_roslib_comm/FieldNameChange2'.
			self assert: definition md5Sum = 'dde34a89b93706fc183fd13c24ae090a'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_FillEmbedTime [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/FillEmbedTime'. 
			self assert: definition typeName = 'test_roslib_comm/FillEmbedTime'.
			self assert: definition md5Sum = '90e08039be001a899b8c20e680c289b0'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_FillSimple [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/FillSimple'. 
			self assert: definition typeName = 'test_roslib_comm/FillSimple'.
			self assert: definition md5Sum = 'da04a60d03fa22f7d301f9bd5f9a08ab'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_HeaderTest [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/HeaderTest'. 
			self assert: definition typeName = 'test_roslib_comm/HeaderTest'.
			self assert: definition md5Sum = '4426b8931bec8509041d64c6a89b54a2'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_SameSubMsg1 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/SameSubMsg1'. 
			self assert: definition typeName = 'test_roslib_comm/SameSubMsg1'.
			self assert: definition md5Sum = '49145a54e4be1a218629e518575a0bf3'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_SameSubMsg2 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/SameSubMsg2'. 
			self assert: definition typeName = 'test_roslib_comm/SameSubMsg2'.
			self assert: definition md5Sum = '49145a54e4be1a218629e518575a0bf3'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_SameSubMsg3 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/SameSubMsg3'. 
			self assert: definition typeName = 'test_roslib_comm/SameSubMsg3'.
			self assert: definition md5Sum = '49145a54e4be1a218629e518575a0bf3'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_TypeNameChange1 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/TypeNameChange1'. 
			self assert: definition typeName = 'test_roslib_comm/TypeNameChange1'.
			self assert: definition md5Sum = '31a9992534c4d020bfc4045e7dc1a786'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_TypeNameChange2 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/TypeNameChange2'. 
			self assert: definition typeName = 'test_roslib_comm/TypeNameChange2'.
			self assert: definition md5Sum = '31a9992534c4d020bfc4045e7dc1a786'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_TypeNameChangeArray1 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/TypeNameChangeArray1'. 
			self assert: definition typeName = 'test_roslib_comm/TypeNameChangeArray1'.
			self assert: definition md5Sum = '31a9992534c4d020bfc4045e7dc1a786'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_TypeNameChangeArray2 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/TypeNameChangeArray2'. 
			self assert: definition typeName = 'test_roslib_comm/TypeNameChangeArray2'.
			self assert: definition md5Sum = '31a9992534c4d020bfc4045e7dc1a786'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_TypeNameChangeComplex1 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/TypeNameChangeComplex1'. 
			self assert: definition typeName = 'test_roslib_comm/TypeNameChangeComplex1'.
			self assert: definition md5Sum = 'a01688a0991b9d7d9facf6d94b993e93'.
		
]

{ #category : #'test-test_roslib_comm/' }
PhaROSTypeBrowserTests >> testtest_roslib_comm_TypeNameChangeComplex2 [
		| definition | 
			definition :=  browser definition: 'test_roslib_comm/TypeNameChangeComplex2'. 
			self assert: definition typeName = 'test_roslib_comm/TypeNameChangeComplex2'.
			self assert: definition md5Sum = 'a01688a0991b9d7d9facf6d94b993e93'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_ArrayVal [
		| definition | 
			definition :=  browser definition: 'test_rospy/ArrayVal'. 
			self assert: definition typeName = 'test_rospy/ArrayVal'.
			self assert: definition md5Sum = '94e095e6a59bceb3466e4b23c166732e'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_EmbedTest [
		| definition | 
			definition :=  browser definition: 'test_rospy/EmbedTest'. 
			self assert: definition typeName = 'test_rospy/EmbedTest'.
			self assert: definition md5Sum = 'f8b1fc6a0f70f541c9d6bd2886b9e249'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_Floats [
		| definition | 
			definition :=  browser definition: 'test_rospy/Floats'. 
			self assert: definition typeName = 'test_rospy/Floats'.
			self assert: definition md5Sum = '420cd38b6b071cd49f2970c3e2cee511'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_HeaderHeaderVal [
		| definition | 
			definition :=  browser definition: 'test_rospy/HeaderHeaderVal'. 
			self assert: definition typeName = 'test_rospy/HeaderHeaderVal'.
			self assert: definition md5Sum = 'ae71c365b9bafbc4abaf37150c80a6b5'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_HeaderVal [
		| definition | 
			definition :=  browser definition: 'test_rospy/HeaderVal'. 
			self assert: definition typeName = 'test_rospy/HeaderVal'.
			self assert: definition md5Sum = 'c3262d64205f82361bc7aa4173b8fe64'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_PythonKeyword [
		| definition | 
			definition :=  browser definition: 'test_rospy/PythonKeyword'. 
			self assert: definition typeName = 'test_rospy/PythonKeyword'.
			self assert: definition md5Sum = '1330d6bbfad8e75334346fec949d5133'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_TestConstants [
		| definition | 
			definition :=  browser definition: 'test_rospy/TestConstants'. 
			self assert: definition typeName = 'test_rospy/TestConstants'.
			self assert: definition md5Sum = 'e60959d2ccf9718dc5e42767bebd1644'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_TestFixedArray [
		| definition | 
			definition :=  browser definition: 'test_rospy/TestFixedArray'. 
			self assert: definition typeName = 'test_rospy/TestFixedArray'.
			self assert: definition md5Sum = '1557473dc09f1a01a00123a713c822a7'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_TransitiveImport [
		| definition | 
			definition :=  browser definition: 'test_rospy/TransitiveImport'. 
			self assert: definition typeName = 'test_rospy/TransitiveImport'.
			self assert: definition md5Sum = '27665539bacd6d2d02a7538692d3d3d0'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_TransitiveMsg1 [
		| definition | 
			definition :=  browser definition: 'test_rospy/TransitiveMsg1'. 
			self assert: definition typeName = 'test_rospy/TransitiveMsg1'.
			self assert: definition md5Sum = '72751523a989ee2c7a44c006464315e9'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_TransitiveMsg2 [
		| definition | 
			definition :=  browser definition: 'test_rospy/TransitiveMsg2'. 
			self assert: definition typeName = 'test_rospy/TransitiveMsg2'.
			self assert: definition md5Sum = 'eb1fa3c8b51b0e31f74e89c2eecc441e'.
		
]

{ #category : #'test-test_rospy/' }
PhaROSTypeBrowserTests >> testtest_rospy_Val [
		| definition | 
			definition :=  browser definition: 'test_rospy/Val'. 
			self assert: definition typeName = 'test_rospy/Val'.
			self assert: definition md5Sum = 'c45577ce53559408f0f69fe465be7c70'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformAction [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformAction'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformAction'.
			self assert: definition md5Sum = '7ee01ba91a56c2245c610992dbaa3c37'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformActionFeedback [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformActionFeedback'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformActionFeedback'.
			self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformActionGoal [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformActionGoal'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformActionGoal'.
			self assert: definition md5Sum = 'f2e7bcdb75c847978d0351a13e699da5'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformActionResult [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformActionResult'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformActionResult'.
			self assert: definition md5Sum = 'ac26ce75a41384fa8bb4dc10f491ab90'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformFeedback [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformFeedback'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformFeedback'.
			self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformGoal [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformGoal'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformGoal'.
			self assert: definition md5Sum = '35e3720468131d675a18bb6f3e5f22f8'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformResult [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/LookupTransformResult'. 
			self assert: definition typeName = 'tf2_msgs/LookupTransformResult'.
			self assert: definition md5Sum = '3fe5db6a19ca9cfb675418c5ad875c36'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_TF2Error [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/TF2Error'. 
			self assert: definition typeName = 'tf2_msgs/TF2Error'.
			self assert: definition md5Sum = 'bc6848fd6fd750c92e38575618a4917d'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_TFMessage [
		| definition | 
			definition :=  browser definition: 'tf2_msgs/TFMessage'. 
			self assert: definition typeName = 'tf2_msgs/TFMessage'.
			self assert: definition md5Sum = '94810edda583a504dfda3829e70d7eec'.
		
]

{ #category : #'test-tf/' }
PhaROSTypeBrowserTests >> testtf_tfMessage [
		| definition | 
			definition :=  browser definition: 'tf/tfMessage'. 
			self assert: definition typeName = 'tf/tfMessage'.
			self assert: definition md5Sum = '94810edda583a504dfda3829e70d7eec'.
		
]

{ #category : #'test-theora_image_transport/' }
PhaROSTypeBrowserTests >> testtheora_image_transport_Packet [
		| definition | 
			definition :=  browser definition: 'theora_image_transport/Packet'. 
			self assert: definition typeName = 'theora_image_transport/Packet'.
			self assert: definition md5Sum = '33ac4e14a7cff32e7e0d65f18bb410f3'.
		
]

{ #category : #'test-trajectory_msgs/' }
PhaROSTypeBrowserTests >> testtrajectory_msgs_JointTrajectory [
		| definition | 
			definition :=  browser definition: 'trajectory_msgs/JointTrajectory'. 
			self assert: definition typeName = 'trajectory_msgs/JointTrajectory'.
			self assert: definition md5Sum = '72214029c6fba47b2135714577dd745e'.
		
]

{ #category : #'test-trajectory_msgs/' }
PhaROSTypeBrowserTests >> testtrajectory_msgs_JointTrajectoryPoint [
		| definition | 
			definition :=  browser definition: 'trajectory_msgs/JointTrajectoryPoint'. 
			self assert: definition typeName = 'trajectory_msgs/JointTrajectoryPoint'.
			self assert: definition md5Sum = '84fd2dcf68773c3dc0e9db894f4e8b40'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeAction [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeAction'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeAction'.
			self assert: definition md5Sum = 'd73b17d6237a925511f5d7727a1dc903'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeActionFeedback [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeActionFeedback'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeActionFeedback'.
			self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeActionGoal [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeActionGoal'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeActionGoal'.
			self assert: definition md5Sum = 'dbfccd187f2ec9c593916447ffd6cc77'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeActionResult [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeActionResult'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeActionResult'.
			self assert: definition md5Sum = 'c8d13d5d140f1047a2e4d3bf5c045822'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeFeedback [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeFeedback'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeFeedback'.
			self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeGoal [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeGoal'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeGoal'.
			self assert: definition md5Sum = '3b9202ab7292cebe5a95ab2bf6b9c091'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeResult [
		| definition | 
			definition :=  browser definition: 'turtle_actionlib/ShapeResult'. 
			self assert: definition typeName = 'turtle_actionlib/ShapeResult'.
			self assert: definition md5Sum = 'b06c6e2225f820dbc644270387cd1a7c'.
		
]

{ #category : #'test-turtlesim/' }
PhaROSTypeBrowserTests >> testturtlesim_Color [
		| definition | 
			definition :=  browser definition: 'turtlesim/Color'. 
			self assert: definition typeName = 'turtlesim/Color'.
			self assert: definition md5Sum = '353891e354491c51aabe32df673fb446'.
		
]

{ #category : #'test-turtlesim/' }
PhaROSTypeBrowserTests >> testturtlesim_Pose [
		| definition | 
			definition :=  browser definition: 'turtlesim/Pose'. 
			self assert: definition typeName = 'turtlesim/Pose'.
			self assert: definition md5Sum = '863b248d5016ca62ea2e895ae5265cf9'.
		
]

{ #category : #'test-turtlesim/' }
PhaROSTypeBrowserTests >> testturtlesim_Velocity [
		| definition | 
			definition :=  browser definition: 'turtlesim/Velocity'. 
			self assert: definition typeName = 'turtlesim/Velocity'.
			self assert: definition md5Sum = '9d5c2dcd348ac8f76ce2a4307bd63a13'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_ImageMarker [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/ImageMarker'. 
			self assert: definition typeName = 'visualization_msgs/ImageMarker'.
			self assert: definition md5Sum = '1de93c67ec8858b831025a08fbf1b35c'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarker [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/InteractiveMarker'. 
			self assert: definition typeName = 'visualization_msgs/InteractiveMarker'.
			self assert: definition md5Sum = '311bd5f6cd6a20820ac0ba84315f4e22'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerControl [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/InteractiveMarkerControl'. 
			self assert: definition typeName = 'visualization_msgs/InteractiveMarkerControl'.
			self assert: definition md5Sum = 'e3a939c98cdd4f709d8e1dec2a9c3f37'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerFeedback [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/InteractiveMarkerFeedback'. 
			self assert: definition typeName = 'visualization_msgs/InteractiveMarkerFeedback'.
			self assert: definition md5Sum = 'ab0f1eee058667e28c19ff3ffc3f4b78'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerInit [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/InteractiveMarkerInit'. 
			self assert: definition typeName = 'visualization_msgs/InteractiveMarkerInit'.
			self assert: definition md5Sum = 'aa2f1dcea79533d1710675195653028d'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerPose [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/InteractiveMarkerPose'. 
			self assert: definition typeName = 'visualization_msgs/InteractiveMarkerPose'.
			self assert: definition md5Sum = 'a6e6833209a196a38d798dadb02c81f8'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerUpdate [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/InteractiveMarkerUpdate'. 
			self assert: definition typeName = 'visualization_msgs/InteractiveMarkerUpdate'.
			self assert: definition md5Sum = '83e22f99d3b31fde725e0a338200e036'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_Marker [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/Marker'. 
			self assert: definition typeName = 'visualization_msgs/Marker'.
			self assert: definition md5Sum = '18326976df9d29249efc939e00342cde'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_MarkerArray [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/MarkerArray'. 
			self assert: definition typeName = 'visualization_msgs/MarkerArray'.
			self assert: definition md5Sum = '90da67007c26525f655c1c269094e39f'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_MenuEntry [
		| definition | 
			definition :=  browser definition: 'visualization_msgs/MenuEntry'. 
			self assert: definition typeName = 'visualization_msgs/MenuEntry'.
			self assert: definition md5Sum = 'b90ec63024573de83b57aa93eb39be2d'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_ImagePercept [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/ImagePercept'. 
			self assert: definition typeName = 'worldmodel_msgs/ImagePercept'.
			self assert: definition md5Sum = 'cfe1ba9ccbb3e43950b420f7336a3c6c'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_Object [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/Object'. 
			self assert: definition typeName = 'worldmodel_msgs/Object'.
			self assert: definition md5Sum = 'bc2b29ddef39c215dc87ef727bf53447'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_ObjectInfo [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/ObjectInfo'. 
			self assert: definition typeName = 'worldmodel_msgs/ObjectInfo'.
			self assert: definition md5Sum = 'd394469df540d3963132564bb1e1b6c6'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_ObjectModel [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/ObjectModel'. 
			self assert: definition typeName = 'worldmodel_msgs/ObjectModel'.
			self assert: definition md5Sum = 'f9cae8b2109e6f4fe92735ca9596083c'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_ObjectState [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/ObjectState'. 
			self assert: definition typeName = 'worldmodel_msgs/ObjectState'.
			self assert: definition md5Sum = 'df53bf1a788b2816bf176c016550e177'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_PerceptInfo [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/PerceptInfo'. 
			self assert: definition typeName = 'worldmodel_msgs/PerceptInfo'.
			self assert: definition md5Sum = '6d276cf0fa6b560cbfd07a3f9eab88b5'.
		
]

{ #category : #'test-worldmodel_msgs/' }
PhaROSTypeBrowserTests >> testworldmodel_msgs_PosePercept [
		| definition | 
			definition :=  browser definition: 'worldmodel_msgs/PosePercept'. 
			self assert: definition typeName = 'worldmodel_msgs/PosePercept'.
			self assert: definition md5Sum = '3b0c987b9e39c7b12b9e71be97a0c021'.
		
]
