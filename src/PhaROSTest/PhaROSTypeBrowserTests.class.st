Class {
	#name : #PhaROSTypeBrowserTests,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'PhaROSTest-Util'
}

{ #category : #'generating tests' }
PhaROSTypeBrowserTests >> creatorScript [
" self new creatorScript "
	(String lf split: (PhaROSSystemLauncher instance rosMsg:'list')) do: 
	
	[ :typeId |
	
	| method |
	method := 
		'test{1}
	| definition | 
	definition :=  browser type: ''{2}''. 
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

{ #category : #running }
PhaROSTypeBrowserTests >> setUp [
	super setUp.
	browser := PhaROSTypeBrowser instance.
]

{ #category : #tests }
PhaROSTypeBrowserTests >> test [
	self should: [ browser type: '' ] raise: PhaROSTypeError 
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestAction [
	| definition | 
	definition :=  browser type: 'actionlib/TestAction'. 
	self assert: definition typeName = 'actionlib/TestAction'.
	self assert: definition md5Sum = '991e87a72802262dfbe5d1b3cf6efc9a'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestActionFeedback [
	| definition | 
	definition :=  browser type: 'actionlib/TestActionFeedback'. 
	self assert: definition typeName = 'actionlib/TestActionFeedback'.
	self assert: definition md5Sum = '6d3d0bf7fb3dda24779c010a9f3eb7cb'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestActionGoal [
	| definition | 
	definition :=  browser type: 'actionlib/TestActionGoal'. 
	self assert: definition typeName = 'actionlib/TestActionGoal'.
	self assert: definition md5Sum = '348369c5b403676156094e8c159720bf'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestActionResult [
	| definition | 
	definition :=  browser type: 'actionlib/TestActionResult'. 
	self assert: definition typeName = 'actionlib/TestActionResult'.
	self assert: definition md5Sum = '3d669e3a63aa986c667ea7b0f46ce85e'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestFeedback [
	| definition | 
	definition :=  browser type: 'actionlib/TestFeedback'. 
	self assert: definition typeName = 'actionlib/TestFeedback'.
	self assert: definition md5Sum = '49ceb5b32ea3af22073ede4a0328249e'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestGoal [
	| definition | 
	definition :=  browser type: 'actionlib/TestGoal'. 
	self assert: definition typeName = 'actionlib/TestGoal'.
	self assert: definition md5Sum = '18df0149936b7aa95588e3862476ebde'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestAction [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestAction'. 
	self assert: definition typeName = 'actionlib/TestRequestAction'.
	self assert: definition md5Sum = 'dc44b1f4045dbf0d1db54423b3b86b30'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestActionFeedback [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestActionFeedback'. 
	self assert: definition typeName = 'actionlib/TestRequestActionFeedback'.
	self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestActionGoal [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestActionGoal'. 
	self assert: definition typeName = 'actionlib/TestRequestActionGoal'.
	self assert: definition md5Sum = '1889556d3fef88f821c7cb004e4251f3'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestActionResult [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestActionResult'. 
	self assert: definition typeName = 'actionlib/TestRequestActionResult'.
	self assert: definition md5Sum = '0476d1fdf437a3a6e7d6d0e9f5561298'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestFeedback [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestFeedback'. 
	self assert: definition typeName = 'actionlib/TestRequestFeedback'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestGoal [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestGoal'. 
	self assert: definition typeName = 'actionlib/TestRequestGoal'.
	self assert: definition md5Sum = 'db5d00ba98302d6c6dd3737e9a03ceea'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestRequestResult [
	| definition | 
	definition :=  browser type: 'actionlib/TestRequestResult'. 
	self assert: definition typeName = 'actionlib/TestRequestResult'.
	self assert: definition md5Sum = '61c2364524499c7c5017e2f3fce7ba06'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TestResult [
	| definition | 
	definition :=  browser type: 'actionlib/TestResult'. 
	self assert: definition typeName = 'actionlib/TestResult'.
	self assert: definition md5Sum = '034a8e20d6a306665e3a5b340fab3f09'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsAction [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsAction'. 
	self assert: definition typeName = 'actionlib/TwoIntsAction'.
	self assert: definition md5Sum = '6d1aa538c4bd6183a2dfb7fcac41ee50'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsActionFeedback [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsActionFeedback'. 
	self assert: definition typeName = 'actionlib/TwoIntsActionFeedback'.
	self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsActionGoal [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsActionGoal'. 
	self assert: definition typeName = 'actionlib/TwoIntsActionGoal'.
	self assert: definition md5Sum = '684a2db55d6ffb8046fb9d6764ce0860'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsActionResult [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsActionResult'. 
	self assert: definition typeName = 'actionlib/TwoIntsActionResult'.
	self assert: definition md5Sum = '3ba7dea8b8cddcae4528ade4ef74b6e7'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsFeedback [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsFeedback'. 
	self assert: definition typeName = 'actionlib/TwoIntsFeedback'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsGoal [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsGoal'. 
	self assert: definition typeName = 'actionlib/TwoIntsGoal'.
	self assert: definition md5Sum = '36d09b846be0b371c5f190354dd3153e'.
		
]

{ #category : #'test-actionlib/' }
PhaROSTypeBrowserTests >> testactionlib_TwoIntsResult [
	| definition | 
	definition :=  browser type: 'actionlib/TwoIntsResult'. 
	self assert: definition typeName = 'actionlib/TwoIntsResult'.
	self assert: definition md5Sum = 'b88405221c77b1878a3cbbfff53428d7'.
		
]

{ #category : #'test-actionlib_msgs/' }
PhaROSTypeBrowserTests >> testactionlib_msgs_GoalID [
	| definition | 
	definition :=  browser type: 'actionlib_msgs/GoalID'. 
	self assert: definition typeName = 'actionlib_msgs/GoalID'.
	self assert: definition md5Sum = '302881f31927c1df708a2dbab0e80ee8'.
		
]

{ #category : #'test-actionlib_msgs/' }
PhaROSTypeBrowserTests >> testactionlib_msgs_GoalStatus [
	| definition | 
	definition :=  browser type: 'actionlib_msgs/GoalStatus'. 
	self assert: definition typeName = 'actionlib_msgs/GoalStatus'.
	self assert: definition md5Sum = 'd388f9b87b3c471f784434d671988d4a'.
		
]

{ #category : #'test-actionlib_msgs/' }
PhaROSTypeBrowserTests >> testactionlib_msgs_GoalStatusArray [
	| definition | 
	definition :=  browser type: 'actionlib_msgs/GoalStatusArray'. 
	self assert: definition typeName = 'actionlib_msgs/GoalStatusArray'.
	self assert: definition md5Sum = '8b2b82f13216d0a8ea88bd3af735e619'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingAction [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingAction'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingAction'.
	self assert: definition md5Sum = '628678f2b4fa6a5951746a4a2d39e716'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingActionFeedback [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingActionFeedback'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingActionFeedback'.
	self assert: definition md5Sum = '78a4a09241b1791069223ae7ebd5b16b'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingActionGoal [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingActionGoal'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingActionGoal'.
	self assert: definition md5Sum = '1561825b734ebd6039851c501e3fb570'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingActionResult [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingActionResult'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingActionResult'.
	self assert: definition md5Sum = '8672cb489d347580acdcd05c5d497497'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingFeedback [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingFeedback'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingFeedback'.
	self assert: definition md5Sum = '9e8dfc53c2f2a032ca33fa80ec46fd4f'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingGoal [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingGoal'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingGoal'.
	self assert: definition md5Sum = '32c9b10ef9b253faa93b93f564762c8f'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_AveragingResult [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/AveragingResult'. 
	self assert: definition typeName = 'actionlib_tutorials/AveragingResult'.
	self assert: definition md5Sum = 'd5c7decf6df75ffb4367a05c1bcc7612'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciAction [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciAction'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciAction'.
	self assert: definition md5Sum = 'f59df5767bf7634684781c92598b2406'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciActionFeedback [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciActionFeedback'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciActionFeedback'.
	self assert: definition md5Sum = '73b8497a9f629a31c0020900e4148f07'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciActionGoal [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciActionGoal'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciActionGoal'.
	self assert: definition md5Sum = '006871c7fa1d0e3d5fe2226bf17b2a94'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciActionResult [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciActionResult'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciActionResult'.
	self assert: definition md5Sum = 'bee73a9fe29ae25e966e105f5553dd03'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciFeedback [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciFeedback'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciFeedback'.
	self assert: definition md5Sum = 'b81e37d2a31925a0e8ae261a8699cb79'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciGoal [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciGoal'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciGoal'.
	self assert: definition md5Sum = '6889063349a00b249bd1661df429d822'.
		
]

{ #category : #'test-actionlib_tutorials/' }
PhaROSTypeBrowserTests >> testactionlib_tutorials_FibonacciResult [
	| definition | 
	definition :=  browser type: 'actionlib_tutorials/FibonacciResult'. 
	self assert: definition typeName = 'actionlib_tutorials/FibonacciResult'.
	self assert: definition md5Sum = 'b81e37d2a31925a0e8ae261a8699cb79'.
		
]

{ #category : #'test-base_local_planner/' }
PhaROSTypeBrowserTests >> testbase_local_planner_Position2DInt [
	| definition | 
	definition :=  browser type: 'base_local_planner/Position2DInt'. 
	self assert: definition typeName = 'base_local_planner/Position2DInt'.
	self assert: definition md5Sum = '3b834ede922a0fff22c43585c533b49f'.
		
]

{ #category : #'test-bond/' }
PhaROSTypeBrowserTests >> testbond_Constants [
	| definition | 
	definition :=  browser type: 'bond/Constants'. 
	self assert: definition typeName = 'bond/Constants'.
	self assert: definition md5Sum = '6fc594dc1d7bd7919077042712f8c8b0'.
		
]

{ #category : #'test-bond/' }
PhaROSTypeBrowserTests >> testbond_Status [
	| definition | 
	definition :=  browser type: 'bond/Status'. 
	self assert: definition typeName = 'bond/Status'.
	self assert: definition md5Sum = 'eacc84bf5d65b6777d4c50f463dfb9c8'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryAction [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryAction'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryAction'.
	self assert: definition md5Sum = 'bc4f9b743838566551c0390c65f1a248'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryActionFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryActionFeedback'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryActionFeedback'.
	self assert: definition md5Sum = 'd8920dc4eae9fc107e00999cce4be641'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryActionGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryActionGoal'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryActionGoal'.
	self assert: definition md5Sum = 'cff5c1d533bf2f82dd0138d57f4304bb'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryActionResult [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryActionResult'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryActionResult'.
	self assert: definition md5Sum = 'c4fb3b000dc9da4fd99699380efcc5d9'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryFeedback'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryFeedback'.
	self assert: definition md5Sum = '10817c60c2486ef6b33e97dcd87f4474'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryGoal'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryGoal'.
	self assert: definition md5Sum = '69636787b6ecbde4d61d711979bc7ecb'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_FollowJointTrajectoryResult [
	| definition | 
	definition :=  browser type: 'control_msgs/FollowJointTrajectoryResult'. 
	self assert: definition typeName = 'control_msgs/FollowJointTrajectoryResult'.
	self assert: definition md5Sum = '493383b18409bfb604b4e26c676401d2'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommand [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommand'. 
	self assert: definition typeName = 'control_msgs/GripperCommand'.
	self assert: definition md5Sum = '680acaff79486f017132a7f198d40f08'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandAction [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandAction'. 
	self assert: definition typeName = 'control_msgs/GripperCommandAction'.
	self assert: definition md5Sum = '950b2a6ebe831f5d4f4ceaba3d8be01e'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandActionFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandActionFeedback'. 
	self assert: definition typeName = 'control_msgs/GripperCommandActionFeedback'.
	self assert: definition md5Sum = '653dff30c045f5e6ff3feb3409f4558d'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandActionGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandActionGoal'. 
	self assert: definition typeName = 'control_msgs/GripperCommandActionGoal'.
	self assert: definition md5Sum = 'aa581f648a35ed681db2ec0bf7a82bea'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandActionResult [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandActionResult'. 
	self assert: definition typeName = 'control_msgs/GripperCommandActionResult'.
	self assert: definition md5Sum = '143702cb2df0f163c5283cedc5efc6b6'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandFeedback'. 
	self assert: definition typeName = 'control_msgs/GripperCommandFeedback'.
	self assert: definition md5Sum = 'e4cbff56d3562bcf113da5a5adeef91f'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandGoal'. 
	self assert: definition typeName = 'control_msgs/GripperCommandGoal'.
	self assert: definition md5Sum = '86fd82f4ddc48a4cb6856cfa69217e43'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_GripperCommandResult [
	| definition | 
	definition :=  browser type: 'control_msgs/GripperCommandResult'. 
	self assert: definition typeName = 'control_msgs/GripperCommandResult'.
	self assert: definition md5Sum = 'e4cbff56d3562bcf113da5a5adeef91f'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointControllerState [
	| definition | 
	definition :=  browser type: 'control_msgs/JointControllerState'. 
	self assert: definition typeName = 'control_msgs/JointControllerState'.
	self assert: definition md5Sum = 'c0d034a7bf20aeb1c37f3eccb7992b69'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTolerance [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTolerance'. 
	self assert: definition typeName = 'control_msgs/JointTolerance'.
	self assert: definition md5Sum = 'f544fe9c16cf04547e135dd6063ff5be'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryAction [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryAction'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryAction'.
	self assert: definition md5Sum = 'a04ba3ee8f6a2d0985a6aeaf23d9d7ad'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryActionFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryActionFeedback'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryActionFeedback'.
	self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryActionGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryActionGoal'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryActionGoal'.
	self assert: definition md5Sum = 'a99e83ef6185f9fdd7693efe99623a86'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryActionResult [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryActionResult'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryActionResult'.
	self assert: definition md5Sum = '1eb06eeff08fa7ea874431638cb52332'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryControllerState [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryControllerState'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryControllerState'.
	self assert: definition md5Sum = '10817c60c2486ef6b33e97dcd87f4474'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryFeedback'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryFeedback'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryGoal'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryGoal'.
	self assert: definition md5Sum = '2a0eff76c870e8595636c2a562ca298e'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_JointTrajectoryResult [
	| definition | 
	definition :=  browser type: 'control_msgs/JointTrajectoryResult'. 
	self assert: definition typeName = 'control_msgs/JointTrajectoryResult'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadAction [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadAction'. 
	self assert: definition typeName = 'control_msgs/PointHeadAction'.
	self assert: definition md5Sum = '7252920f1243de1b741f14f214125371'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadActionFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadActionFeedback'. 
	self assert: definition typeName = 'control_msgs/PointHeadActionFeedback'.
	self assert: definition md5Sum = '33c9244957176bbba97dd641119e8460'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadActionGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadActionGoal'. 
	self assert: definition typeName = 'control_msgs/PointHeadActionGoal'.
	self assert: definition md5Sum = 'b53a8323d0ba7b310ba17a2d3a82a6b8'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadActionResult [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadActionResult'. 
	self assert: definition typeName = 'control_msgs/PointHeadActionResult'.
	self assert: definition md5Sum = '1eb06eeff08fa7ea874431638cb52332'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadFeedback'. 
	self assert: definition typeName = 'control_msgs/PointHeadFeedback'.
	self assert: definition md5Sum = 'cce80d27fd763682da8805a73316cab4'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadGoal'. 
	self assert: definition typeName = 'control_msgs/PointHeadGoal'.
	self assert: definition md5Sum = '8b92b1cd5e06c8a94c917dc3209a4c1d'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_PointHeadResult [
	| definition | 
	definition :=  browser type: 'control_msgs/PointHeadResult'. 
	self assert: definition typeName = 'control_msgs/PointHeadResult'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionAction [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionAction'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionAction'.
	self assert: definition md5Sum = 'c4a786b7d53e5d0983decf967a5a779e'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionActionFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionActionFeedback'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionActionFeedback'.
	self assert: definition md5Sum = '3503b7cf8972f90d245850a5d8796cfa'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionActionGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionActionGoal'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionActionGoal'.
	self assert: definition md5Sum = '4b0d3d091471663e17749c1d0db90f61'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionActionResult [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionActionResult'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionActionResult'.
	self assert: definition md5Sum = '1eb06eeff08fa7ea874431638cb52332'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionFeedback [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionFeedback'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionFeedback'.
	self assert: definition md5Sum = '8cee65610a3d08e0a1bded82f146f1fd'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionGoal [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionGoal'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionGoal'.
	self assert: definition md5Sum = 'fbaaa562a23a013fd5053e5f72cbb35c'.
		
]

{ #category : #'test-control_msgs/' }
PhaROSTypeBrowserTests >> testcontrol_msgs_SingleJointPositionResult [
	| definition | 
	definition :=  browser type: 'control_msgs/SingleJointPositionResult'. 
	self assert: definition typeName = 'control_msgs/SingleJointPositionResult'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-costmap_2d/' }
PhaROSTypeBrowserTests >> testcostmap_2d_VoxelGrid [
	| definition | 
	definition :=  browser type: 'costmap_2d/VoxelGrid'. 
	self assert: definition typeName = 'costmap_2d/VoxelGrid'.
	self assert: definition md5Sum = '48a040827e1322073d78ece5a497029c'.
		
]

{ #category : #'test-diagnostic_msgs/' }
PhaROSTypeBrowserTests >> testdiagnostic_msgs_DiagnosticArray [
	| definition | 
	definition :=  browser type: 'diagnostic_msgs/DiagnosticArray'. 
	self assert: definition typeName = 'diagnostic_msgs/DiagnosticArray'.
	self assert: definition md5Sum = '60810da900de1dd6ddd437c3503511da'.
		
]

{ #category : #'test-diagnostic_msgs/' }
PhaROSTypeBrowserTests >> testdiagnostic_msgs_DiagnosticStatus [
	| definition | 
	definition :=  browser type: 'diagnostic_msgs/DiagnosticStatus'. 
	self assert: definition typeName = 'diagnostic_msgs/DiagnosticStatus'.
	self assert: definition md5Sum = 'd0ce08bc6e5ba34c7754f563a9cabaf1'.
		
]

{ #category : #'test-diagnostic_msgs/' }
PhaROSTypeBrowserTests >> testdiagnostic_msgs_KeyValue [
	| definition | 
	definition :=  browser type: 'diagnostic_msgs/KeyValue'. 
	self assert: definition typeName = 'diagnostic_msgs/KeyValue'.
	self assert: definition md5Sum = 'cf57fdc6617a881a88c16e768132149c'.
		
]

{ #category : #'test-driver_base/' }
PhaROSTypeBrowserTests >> testdriver_base_ConfigString [
	| definition | 
	definition :=  browser type: 'driver_base/ConfigString'. 
	self assert: definition typeName = 'driver_base/ConfigString'.
	self assert: definition md5Sum = 'bc6ccc4a57f61779c8eaae61e9f422e0'.
		
]

{ #category : #'test-driver_base/' }
PhaROSTypeBrowserTests >> testdriver_base_ConfigValue [
	| definition | 
	definition :=  browser type: 'driver_base/ConfigValue'. 
	self assert: definition typeName = 'driver_base/ConfigValue'.
	self assert: definition md5Sum = 'd8512f27253c0f65f928a67c329cd658'.
		
]

{ #category : #'test-driver_base/' }
PhaROSTypeBrowserTests >> testdriver_base_SensorLevels [
	| definition | 
	definition :=  browser type: 'driver_base/SensorLevels'. 
	self assert: definition typeName = 'driver_base/SensorLevels'.
	self assert: definition md5Sum = '6322637bee96d5489db6e2127c47602c'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_BoolParameter [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/BoolParameter'. 
	self assert: definition typeName = 'dynamic_reconfigure/BoolParameter'.
	self assert: definition md5Sum = '23f05028c1a699fb83e22401228c3a9e'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_Config [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/Config'. 
	self assert: definition typeName = 'dynamic_reconfigure/Config'.
	self assert: definition md5Sum = '958f16a05573709014982821e6822580'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_ConfigDescription [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/ConfigDescription'. 
	self assert: definition typeName = 'dynamic_reconfigure/ConfigDescription'.
	self assert: definition md5Sum = '757ce9d44ba8ddd801bb30bc456f946f'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_DoubleParameter [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/DoubleParameter'. 
	self assert: definition typeName = 'dynamic_reconfigure/DoubleParameter'.
	self assert: definition md5Sum = 'd8512f27253c0f65f928a67c329cd658'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_Group [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/Group'. 
	self assert: definition typeName = 'dynamic_reconfigure/Group'.
	self assert: definition md5Sum = '9e8cd9e9423c94823db3614dd8b1cf7a'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_GroupState [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/GroupState'. 
	self assert: definition typeName = 'dynamic_reconfigure/GroupState'.
	self assert: definition md5Sum = 'a2d87f51dc22930325041a2f8b1571f8'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_IntParameter [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/IntParameter'. 
	self assert: definition typeName = 'dynamic_reconfigure/IntParameter'.
	self assert: definition md5Sum = '65fedc7a0cbfb8db035e46194a350bf1'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_ParamDescription [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/ParamDescription'. 
	self assert: definition typeName = 'dynamic_reconfigure/ParamDescription'.
	self assert: definition md5Sum = '7434fcb9348c13054e0c3b267c8cb34d'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_SensorLevels [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/SensorLevels'. 
	self assert: definition typeName = 'dynamic_reconfigure/SensorLevels'.
	self assert: definition md5Sum = '6322637bee96d5489db6e2127c47602c'.
		
]

{ #category : #'test-dynamic_reconfigure/' }
PhaROSTypeBrowserTests >> testdynamic_reconfigure_StrParameter [
	| definition | 
	definition :=  browser type: 'dynamic_reconfigure/StrParameter'. 
	self assert: definition typeName = 'dynamic_reconfigure/StrParameter'.
	self assert: definition md5Sum = 'bc6ccc4a57f61779c8eaae61e9f422e0'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ContactState [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/ContactState'. 
	self assert: definition typeName = 'gazebo_msgs/ContactState'.
	self assert: definition md5Sum = '48c0ffb054b8c444f870cecea1ee50d9'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ContactsState [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/ContactsState'. 
	self assert: definition typeName = 'gazebo_msgs/ContactsState'.
	self assert: definition md5Sum = 'acbcb1601a8e525bf72509f18e6f668d'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_LinkState [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/LinkState'. 
	self assert: definition typeName = 'gazebo_msgs/LinkState'.
	self assert: definition md5Sum = '0818ebbf28ce3a08d48ab1eaa7309ebe'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_LinkStates [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/LinkStates'. 
	self assert: definition typeName = 'gazebo_msgs/LinkStates'.
	self assert: definition md5Sum = '48c080191eb15c41858319b4d8a609c2'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ModelState [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/ModelState'. 
	self assert: definition typeName = 'gazebo_msgs/ModelState'.
	self assert: definition md5Sum = '9330fd35f2fcd82d457e54bd54e10593'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ModelStates [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/ModelStates'. 
	self assert: definition typeName = 'gazebo_msgs/ModelStates'.
	self assert: definition md5Sum = '48c080191eb15c41858319b4d8a609c2'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ODEJointProperties [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/ODEJointProperties'. 
	self assert: definition typeName = 'gazebo_msgs/ODEJointProperties'.
	self assert: definition md5Sum = '1b744c32a920af979f53afe2f9c3511f'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_ODEPhysics [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/ODEPhysics'. 
	self assert: definition typeName = 'gazebo_msgs/ODEPhysics'.
	self assert: definition md5Sum = '667d56ddbd547918c32d1934503dc335'.
		
]

{ #category : #'test-gazebo_msgs/' }
PhaROSTypeBrowserTests >> testgazebo_msgs_WorldState [
	| definition | 
	definition :=  browser type: 'gazebo_msgs/WorldState'. 
	self assert: definition typeName = 'gazebo_msgs/WorldState'.
	self assert: definition md5Sum = 'de1a9de3ab7ba97ac0e9ec01a4eb481e'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Accel [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Accel'. 
	self assert: definition typeName = 'geometry_msgs/Accel'.
	self assert: definition md5Sum = '9f195f881246fdfa2798d1d3eebca84a'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_AccelStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/AccelStamped'. 
	self assert: definition typeName = 'geometry_msgs/AccelStamped'.
	self assert: definition md5Sum = 'd8a98a5d81351b6eb0578c78557e7659'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_AccelWithCovariance [
	| definition | 
	definition :=  browser type: 'geometry_msgs/AccelWithCovariance'. 
	self assert: definition typeName = 'geometry_msgs/AccelWithCovariance'.
	self assert: definition md5Sum = 'ad5a718d699c6be72a02b8d6a139f334'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_AccelWithCovarianceStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/AccelWithCovarianceStamped'. 
	self assert: definition typeName = 'geometry_msgs/AccelWithCovarianceStamped'.
	self assert: definition md5Sum = '96adb295225031ec8d57fb4251b0a886'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Point [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Point'. 
	self assert: definition typeName = 'geometry_msgs/Point'.
	self assert: definition md5Sum = '4a842b65f413084dc2b10fb484ea7f17'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Point32 [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Point32'. 
	self assert: definition typeName = 'geometry_msgs/Point32'.
	self assert: definition md5Sum = 'cc153912f1453b708d221682bc23d9ac'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PointStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/PointStamped'. 
	self assert: definition typeName = 'geometry_msgs/PointStamped'.
	self assert: definition md5Sum = 'c63aecb41bfdfd6b7e1fac37c7cbe7bf'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Polygon [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Polygon'. 
	self assert: definition typeName = 'geometry_msgs/Polygon'.
	self assert: definition md5Sum = 'cd60a26494a087f577976f0329fa120e'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PolygonStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/PolygonStamped'. 
	self assert: definition typeName = 'geometry_msgs/PolygonStamped'.
	self assert: definition md5Sum = 'c6be8f7dc3bee7fe9e8d296070f53340'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Pose [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Pose'. 
	self assert: definition typeName = 'geometry_msgs/Pose'.
	self assert: definition md5Sum = 'e45d45a5a1ce597b249e23fb30fc871f'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Pose2D [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Pose2D'. 
	self assert: definition typeName = 'geometry_msgs/Pose2D'.
	self assert: definition md5Sum = '938fa65709584ad8e77d238529be13b8'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseArray [
	| definition | 
	definition :=  browser type: 'geometry_msgs/PoseArray'. 
	self assert: definition typeName = 'geometry_msgs/PoseArray'.
	self assert: definition md5Sum = '916c28c5764443f268b296bb671b9d97'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/PoseStamped'. 
	self assert: definition typeName = 'geometry_msgs/PoseStamped'.
	self assert: definition md5Sum = 'd3812c3cbc69362b77dc0b19b345f8f5'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseWithCovariance [
	| definition | 
	definition :=  browser type: 'geometry_msgs/PoseWithCovariance'. 
	self assert: definition typeName = 'geometry_msgs/PoseWithCovariance'.
	self assert: definition md5Sum = 'c23e848cf1b7533a8d7c259073a97e6f'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_PoseWithCovarianceStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/PoseWithCovarianceStamped'. 
	self assert: definition typeName = 'geometry_msgs/PoseWithCovarianceStamped'.
	self assert: definition md5Sum = '953b798c0f514ff060a53a3498ce6246'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Quaternion [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Quaternion'. 
	self assert: definition typeName = 'geometry_msgs/Quaternion'.
	self assert: definition md5Sum = 'a779879fadf0160734f906b8c19c7004'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_QuaternionStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/QuaternionStamped'. 
	self assert: definition typeName = 'geometry_msgs/QuaternionStamped'.
	self assert: definition md5Sum = 'e57f1e547e0e1fd13504588ffc8334e2'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Transform [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Transform'. 
	self assert: definition typeName = 'geometry_msgs/Transform'.
	self assert: definition md5Sum = 'ac9eff44abf714214112b05d54a3cf9b'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TransformStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/TransformStamped'. 
	self assert: definition typeName = 'geometry_msgs/TransformStamped'.
	self assert: definition md5Sum = 'b5764a33bfeb3588febc2682852579b0'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Twist [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Twist'. 
	self assert: definition typeName = 'geometry_msgs/Twist'.
	self assert: definition md5Sum = '9f195f881246fdfa2798d1d3eebca84a'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TwistStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/TwistStamped'. 
	self assert: definition typeName = 'geometry_msgs/TwistStamped'.
	self assert: definition md5Sum = '98d34b0043a2093cf9d9345ab6eef12e'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TwistWithCovariance [
	| definition | 
	definition :=  browser type: 'geometry_msgs/TwistWithCovariance'. 
	self assert: definition typeName = 'geometry_msgs/TwistWithCovariance'.
	self assert: definition md5Sum = '1fe8a28e6890a4cc3ae4c3ca5c7d82e6'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_TwistWithCovarianceStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/TwistWithCovarianceStamped'. 
	self assert: definition typeName = 'geometry_msgs/TwistWithCovarianceStamped'.
	self assert: definition md5Sum = '8927a1a12fb2607ceea095b2dc440a96'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Vector3 [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Vector3'. 
	self assert: definition typeName = 'geometry_msgs/Vector3'.
	self assert: definition md5Sum = '4a842b65f413084dc2b10fb484ea7f17'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Vector3Stamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Vector3Stamped'. 
	self assert: definition typeName = 'geometry_msgs/Vector3Stamped'.
	self assert: definition md5Sum = '7b324c7325e683bf02a9b14b01090ec7'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_Wrench [
	| definition | 
	definition :=  browser type: 'geometry_msgs/Wrench'. 
	self assert: definition typeName = 'geometry_msgs/Wrench'.
	self assert: definition md5Sum = '4f539cf138b23283b520fd271b567936'.
		
]

{ #category : #'test-geometry_msgs/' }
PhaROSTypeBrowserTests >> testgeometry_msgs_WrenchStamped [
	| definition | 
	definition :=  browser type: 'geometry_msgs/WrenchStamped'. 
	self assert: definition typeName = 'geometry_msgs/WrenchStamped'.
	self assert: definition md5Sum = 'd78d3cb249ce23087ade7e7d0c40cfa7'.
		
]

{ #category : #'test-map_msgs/' }
PhaROSTypeBrowserTests >> testmap_msgs_OccupancyGridUpdate [
	| definition | 
	definition :=  browser type: 'map_msgs/OccupancyGridUpdate'. 
	self assert: definition typeName = 'map_msgs/OccupancyGridUpdate'.
	self assert: definition md5Sum = 'b295be292b335c34718bd939deebe1c9'.
		
]

{ #category : #'test-map_msgs/' }
PhaROSTypeBrowserTests >> testmap_msgs_PointCloud2Update [
	| definition | 
	definition :=  browser type: 'map_msgs/PointCloud2Update'. 
	self assert: definition typeName = 'map_msgs/PointCloud2Update'.
	self assert: definition md5Sum = '6c58e4f249ae9cd2b24fb1ee0f99195e'.
		
]

{ #category : #'test-map_msgs/' }
PhaROSTypeBrowserTests >> testmap_msgs_ProjectedMap [
	| definition | 
	definition :=  browser type: 'map_msgs/ProjectedMap'. 
	self assert: definition typeName = 'map_msgs/ProjectedMap'.
	self assert: definition md5Sum = '7bbe8f96e45089681dc1ea7d023cbfca'.
		
]

{ #category : #'test-map_msgs/' }
PhaROSTypeBrowserTests >> testmap_msgs_ProjectedMapInfo [
	| definition | 
	definition :=  browser type: 'map_msgs/ProjectedMapInfo'. 
	self assert: definition typeName = 'map_msgs/ProjectedMapInfo'.
	self assert: definition md5Sum = '2dc10595ae94de23f22f8a6d2a0eef7a'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseAction [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseAction'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseAction'.
	self assert: definition md5Sum = '70b6aca7c7f7746d8d1609ad94c80bb8'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseActionFeedback [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseActionFeedback'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseActionFeedback'.
	self assert: definition md5Sum = '7d1870ff6e0decea702b943b5af0b42e'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseActionGoal [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseActionGoal'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseActionGoal'.
	self assert: definition md5Sum = '660d6895a1b9a16dce51fbdd9a64a56b'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseActionResult [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseActionResult'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseActionResult'.
	self assert: definition md5Sum = '1eb06eeff08fa7ea874431638cb52332'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseFeedback [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseFeedback'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseFeedback'.
	self assert: definition md5Sum = '3fb824c456a757373a226f6d08071bf0'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseGoal [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseGoal'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseGoal'.
	self assert: definition md5Sum = '257d089627d7eb7136c24d3593d05a16'.
		
]

{ #category : #'test-move_base_msgs/' }
PhaROSTypeBrowserTests >> testmove_base_msgs_MoveBaseResult [
	| definition | 
	definition :=  browser type: 'move_base_msgs/MoveBaseResult'. 
	self assert: definition typeName = 'move_base_msgs/MoveBaseResult'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapAction [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapAction'. 
	self assert: definition typeName = 'nav_msgs/GetMapAction'.
	self assert: definition md5Sum = 'e611ad23fbf237c031b7536416dc7cd7'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapActionFeedback [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapActionFeedback'. 
	self assert: definition typeName = 'nav_msgs/GetMapActionFeedback'.
	self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapActionGoal [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapActionGoal'. 
	self assert: definition typeName = 'nav_msgs/GetMapActionGoal'.
	self assert: definition md5Sum = '4b30be6cd12b9e72826df56b481f40e0'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapActionResult [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapActionResult'. 
	self assert: definition typeName = 'nav_msgs/GetMapActionResult'.
	self assert: definition md5Sum = 'ac66e5b9a79bb4bbd33dab245236c892'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapFeedback [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapFeedback'. 
	self assert: definition typeName = 'nav_msgs/GetMapFeedback'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapGoal [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapGoal'. 
	self assert: definition typeName = 'nav_msgs/GetMapGoal'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GetMapResult [
	| definition | 
	definition :=  browser type: 'nav_msgs/GetMapResult'. 
	self assert: definition typeName = 'nav_msgs/GetMapResult'.
	self assert: definition md5Sum = '6cdd0a18e0aff5b0a3ca2326a89b54ff'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_GridCells [
	| definition | 
	definition :=  browser type: 'nav_msgs/GridCells'. 
	self assert: definition typeName = 'nav_msgs/GridCells'.
	self assert: definition md5Sum = 'b9e4f5df6d28e272ebde00a3994830f5'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_MapMetaData [
	| definition | 
	definition :=  browser type: 'nav_msgs/MapMetaData'. 
	self assert: definition typeName = 'nav_msgs/MapMetaData'.
	self assert: definition md5Sum = '10cfc8a2818024d3248802c00c95f11b'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_OccupancyGrid [
	| definition | 
	definition :=  browser type: 'nav_msgs/OccupancyGrid'. 
	self assert: definition typeName = 'nav_msgs/OccupancyGrid'.
	self assert: definition md5Sum = '3381f2d731d4076ec5c71b0759edbe4e'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_Odometry [
	| definition | 
	definition :=  browser type: 'nav_msgs/Odometry'. 
	self assert: definition typeName = 'nav_msgs/Odometry'.
	self assert: definition md5Sum = 'cd5e73d190d741a2f92e81eda573aca7'.
		
]

{ #category : #'test-nav_msgs/' }
PhaROSTypeBrowserTests >> testnav_msgs_Path [
	| definition | 
	definition :=  browser type: 'nav_msgs/Path'. 
	self assert: definition typeName = 'nav_msgs/Path'.
	self assert: definition md5Sum = '6227e2b7e9cce15051f669a5e197bbf7'.
		
]

{ #category : #'test-pcl_msgs/' }
PhaROSTypeBrowserTests >> testpcl_msgs_ModelCoefficients [
	| definition | 
	definition :=  browser type: 'pcl_msgs/ModelCoefficients'. 
	self assert: definition typeName = 'pcl_msgs/ModelCoefficients'.
	self assert: definition md5Sum = 'ca27dea75e72cb894cd36f9e5005e93e'.
		
]

{ #category : #'test-pcl_msgs/' }
PhaROSTypeBrowserTests >> testpcl_msgs_PointIndices [
	| definition | 
	definition :=  browser type: 'pcl_msgs/PointIndices'. 
	self assert: definition typeName = 'pcl_msgs/PointIndices'.
	self assert: definition md5Sum = '458c7998b7eaf99908256472e273b3d4'.
		
]

{ #category : #'test-pcl_msgs/' }
PhaROSTypeBrowserTests >> testpcl_msgs_PolygonMesh [
	| definition | 
	definition :=  browser type: 'pcl_msgs/PolygonMesh'. 
	self assert: definition typeName = 'pcl_msgs/PolygonMesh'.
	self assert: definition md5Sum = '45a5fc6ad2cde8489600a790acc9a38a'.
		
]

{ #category : #'test-pcl_msgs/' }
PhaROSTypeBrowserTests >> testpcl_msgs_Vertices [
	| definition | 
	definition :=  browser type: 'pcl_msgs/Vertices'. 
	self assert: definition typeName = 'pcl_msgs/Vertices'.
	self assert: definition md5Sum = '39bd7b1c23763ddd1b882b97cb7cfe11'.
		
]

{ #category : #'test-roscpp/' }
PhaROSTypeBrowserTests >> testroscpp_Logger [
	| definition | 
	definition :=  browser type: 'roscpp/Logger'. 
	self assert: definition typeName = 'roscpp/Logger'.
	self assert: definition md5Sum = 'a6069a2ff40db7bd32143dd66e1f408e'.
		
]

{ #category : #'test-rosgraph_msgs/' }
PhaROSTypeBrowserTests >> testrosgraph_msgs_Clock [
	| definition | 
	definition :=  browser type: 'rosgraph_msgs/Clock'. 
	self assert: definition typeName = 'rosgraph_msgs/Clock'.
	self assert: definition md5Sum = 'a9c97c1d230cfc112e270351a944ee47'.
		
]

{ #category : #'test-rosgraph_msgs/' }
PhaROSTypeBrowserTests >> testrosgraph_msgs_Log [
	| definition | 
	definition :=  browser type: 'rosgraph_msgs/Log'. 
	self assert: definition typeName = 'rosgraph_msgs/Log'.
	self assert: definition md5Sum = 'acffd30cd6b6de30f120938c17c593fb'.
		
]

{ #category : #'test-rosgraph_msgs/' }
PhaROSTypeBrowserTests >> testrosgraph_msgs_TopicStatistics [
	| definition | 
	definition :=  browser type: 'rosgraph_msgs/TopicStatistics'. 
	self assert: definition typeName = 'rosgraph_msgs/TopicStatistics'.
	self assert: definition md5Sum = '10152ed868c5097a5e2e4a89d7daa710'.
		
]

{ #category : #'test-rospy_tutorials/' }
PhaROSTypeBrowserTests >> testrospy_tutorials_Floats [
	| definition | 
	definition :=  browser type: 'rospy_tutorials/Floats'. 
	self assert: definition typeName = 'rospy_tutorials/Floats'.
	self assert: definition md5Sum = '420cd38b6b071cd49f2970c3e2cee511'.
		
]

{ #category : #'test-rospy_tutorials/' }
PhaROSTypeBrowserTests >> testrospy_tutorials_HeaderString [
	| definition | 
	definition :=  browser type: 'rospy_tutorials/HeaderString'. 
	self assert: definition typeName = 'rospy_tutorials/HeaderString'.
	self assert: definition md5Sum = 'c99a9440709e4d4a9716d55b8270d5e7'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_CameraInfo [
	| definition | 
	definition :=  browser type: 'sensor_msgs/CameraInfo'. 
	self assert: definition typeName = 'sensor_msgs/CameraInfo'.
	self assert: definition md5Sum = 'c9a58c1b0b154e0e6da7578cb991d214'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_ChannelFloat32 [
	| definition | 
	definition :=  browser type: 'sensor_msgs/ChannelFloat32'. 
	self assert: definition typeName = 'sensor_msgs/ChannelFloat32'.
	self assert: definition md5Sum = '3d40139cdd33dfedcb71ffeeeb42ae7f'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_CompressedImage [
	| definition | 
	definition :=  browser type: 'sensor_msgs/CompressedImage'. 
	self assert: definition typeName = 'sensor_msgs/CompressedImage'.
	self assert: definition md5Sum = '8f7a12909da2c9d3332d540a0977563f'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_FluidPressure [
	| definition | 
	definition :=  browser type: 'sensor_msgs/FluidPressure'. 
	self assert: definition typeName = 'sensor_msgs/FluidPressure'.
	self assert: definition md5Sum = '804dc5cea1c5306d6a2eb80b9833befe'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Illuminance [
	| definition | 
	definition :=  browser type: 'sensor_msgs/Illuminance'. 
	self assert: definition typeName = 'sensor_msgs/Illuminance'.
	self assert: definition md5Sum = '8cf5febb0952fca9d650c3d11a81a188'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Image [
	| definition | 
	definition :=  browser type: 'sensor_msgs/Image'. 
	self assert: definition typeName = 'sensor_msgs/Image'.
	self assert: definition md5Sum = '060021388200f6f0f447d0fcd9c64743'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Imu [
	| definition | 
	definition :=  browser type: 'sensor_msgs/Imu'. 
	self assert: definition typeName = 'sensor_msgs/Imu'.
	self assert: definition md5Sum = '6a62c6daae103f4ff57a132d6f95cec2'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_JointState [
	| definition | 
	definition :=  browser type: 'sensor_msgs/JointState'. 
	self assert: definition typeName = 'sensor_msgs/JointState'.
	self assert: definition md5Sum = '3066dcd76a6cfaef579bd0f34173e9fd'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Joy [
	| definition | 
	definition :=  browser type: 'sensor_msgs/Joy'. 
	self assert: definition typeName = 'sensor_msgs/Joy'.
	self assert: definition md5Sum = '5a9ea5f83505693b71e785041e67a8bb'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_JoyFeedback [
	| definition | 
	definition :=  browser type: 'sensor_msgs/JoyFeedback'. 
	self assert: definition typeName = 'sensor_msgs/JoyFeedback'.
	self assert: definition md5Sum = 'f4dcd73460360d98f36e55ee7f2e46f1'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_JoyFeedbackArray [
	| definition | 
	definition :=  browser type: 'sensor_msgs/JoyFeedbackArray'. 
	self assert: definition typeName = 'sensor_msgs/JoyFeedbackArray'.
	self assert: definition md5Sum = 'cde5730a895b1fc4dee6f91b754b213d'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_LaserEcho [
	| definition | 
	definition :=  browser type: 'sensor_msgs/LaserEcho'. 
	self assert: definition typeName = 'sensor_msgs/LaserEcho'.
	self assert: definition md5Sum = '8bc5ae449b200fba4d552b4225586696'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_LaserScan [
	| definition | 
	definition :=  browser type: 'sensor_msgs/LaserScan'. 
	self assert: definition typeName = 'sensor_msgs/LaserScan'.
	self assert: definition md5Sum = '90c7ef2dc6895d81024acba2ac42f369'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_MagneticField [
	| definition | 
	definition :=  browser type: 'sensor_msgs/MagneticField'. 
	self assert: definition typeName = 'sensor_msgs/MagneticField'.
	self assert: definition md5Sum = '2f3b0b43eed0c9501de0fa3ff89a45aa'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_MultiDOFJointState [
	| definition | 
	definition :=  browser type: 'sensor_msgs/MultiDOFJointState'. 
	self assert: definition typeName = 'sensor_msgs/MultiDOFJointState'.
	self assert: definition md5Sum = '690f272f0640d2631c305eeb8301e59d'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_MultiEchoLaserScan [
	| definition | 
	definition :=  browser type: 'sensor_msgs/MultiEchoLaserScan'. 
	self assert: definition typeName = 'sensor_msgs/MultiEchoLaserScan'.
	self assert: definition md5Sum = '6fefb0c6da89d7c8abe4b339f5c2f8fb'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_NavSatFix [
	| definition | 
	definition :=  browser type: 'sensor_msgs/NavSatFix'. 
	self assert: definition typeName = 'sensor_msgs/NavSatFix'.
	self assert: definition md5Sum = '2d3a8cd499b9b4a0249fb98fd05cfa48'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_NavSatStatus [
	| definition | 
	definition :=  browser type: 'sensor_msgs/NavSatStatus'. 
	self assert: definition typeName = 'sensor_msgs/NavSatStatus'.
	self assert: definition md5Sum = '331cdbddfa4bc96ffc3b9ad98900a54c'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_PointCloud [
	| definition | 
	definition :=  browser type: 'sensor_msgs/PointCloud'. 
	self assert: definition typeName = 'sensor_msgs/PointCloud'.
	self assert: definition md5Sum = 'd8e9c3f5afbdd8a130fd1d2763945fca'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_PointCloud2 [
	| definition | 
	definition :=  browser type: 'sensor_msgs/PointCloud2'. 
	self assert: definition typeName = 'sensor_msgs/PointCloud2'.
	self assert: definition md5Sum = '1158d486dd51d683ce2f1be655c3c181'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_PointField [
	| definition | 
	definition :=  browser type: 'sensor_msgs/PointField'. 
	self assert: definition typeName = 'sensor_msgs/PointField'.
	self assert: definition md5Sum = '268eacb2962780ceac86cbd17e328150'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Range [
	| definition | 
	definition :=  browser type: 'sensor_msgs/Range'. 
	self assert: definition typeName = 'sensor_msgs/Range'.
	self assert: definition md5Sum = 'c005c34273dc426c67a020a87bc24148'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_RegionOfInterest [
	| definition | 
	definition :=  browser type: 'sensor_msgs/RegionOfInterest'. 
	self assert: definition typeName = 'sensor_msgs/RegionOfInterest'.
	self assert: definition md5Sum = 'bdb633039d588fcccb441a4d43ccfe09'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_RelativeHumidity [
	| definition | 
	definition :=  browser type: 'sensor_msgs/RelativeHumidity'. 
	self assert: definition typeName = 'sensor_msgs/RelativeHumidity'.
	self assert: definition md5Sum = '8730015b05955b7e992ce29a2678d90f'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_Temperature [
	| definition | 
	definition :=  browser type: 'sensor_msgs/Temperature'. 
	self assert: definition typeName = 'sensor_msgs/Temperature'.
	self assert: definition md5Sum = 'ff71b307acdbe7c871a5a6d7ed359100'.
		
]

{ #category : #'test-sensor_msgs/' }
PhaROSTypeBrowserTests >> testsensor_msgs_TimeReference [
	| definition | 
	definition :=  browser type: 'sensor_msgs/TimeReference'. 
	self assert: definition typeName = 'sensor_msgs/TimeReference'.
	self assert: definition md5Sum = 'fded64a0265108ba86c3d38fb11c0c16'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_Mesh [
	| definition | 
	definition :=  browser type: 'shape_msgs/Mesh'. 
	self assert: definition typeName = 'shape_msgs/Mesh'.
	self assert: definition md5Sum = '1ffdae9486cd3316a121c578b47a85cc'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_MeshTriangle [
	| definition | 
	definition :=  browser type: 'shape_msgs/MeshTriangle'. 
	self assert: definition typeName = 'shape_msgs/MeshTriangle'.
	self assert: definition md5Sum = '23688b2e6d2de3d32fe8af104a903253'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_Plane [
	| definition | 
	definition :=  browser type: 'shape_msgs/Plane'. 
	self assert: definition typeName = 'shape_msgs/Plane'.
	self assert: definition md5Sum = '2c1b92ed8f31492f8e73f6a4a44ca796'.
		
]

{ #category : #'test-shape_msgs/' }
PhaROSTypeBrowserTests >> testshape_msgs_SolidPrimitive [
	| definition | 
	definition :=  browser type: 'shape_msgs/SolidPrimitive'. 
	self assert: definition typeName = 'shape_msgs/SolidPrimitive'.
	self assert: definition md5Sum = 'd8f8cbc74c5ff283fca29569ccefb45d'.
		
]

{ #category : #'test-sicktoolbox_wrapper/' }
PhaROSTypeBrowserTests >> testsicktoolbox_wrapper_navtimestamp [
	| definition | 
	definition :=  browser type: 'sicktoolbox_wrapper/navtimestamp'. 
	self assert: definition typeName = 'sicktoolbox_wrapper/navtimestamp'.
	self assert: definition md5Sum = '41f5fa716ef5e0c07df1990b1292d37c'.
		
]

{ #category : #'test-smach_msgs/' }
PhaROSTypeBrowserTests >> testsmach_msgs_SmachContainerInitialStatusCmd [
	| definition | 
	definition :=  browser type: 'smach_msgs/SmachContainerInitialStatusCmd'. 
	self assert: definition typeName = 'smach_msgs/SmachContainerInitialStatusCmd'.
	self assert: definition md5Sum = '45f8cf31fc29b829db77f23001f788d6'.
		
]

{ #category : #'test-smach_msgs/' }
PhaROSTypeBrowserTests >> testsmach_msgs_SmachContainerStatus [
	| definition | 
	definition :=  browser type: 'smach_msgs/SmachContainerStatus'. 
	self assert: definition typeName = 'smach_msgs/SmachContainerStatus'.
	self assert: definition md5Sum = '5ba2bb79ac19e3842d562a191f2a675b'.
		
]

{ #category : #'test-smach_msgs/' }
PhaROSTypeBrowserTests >> testsmach_msgs_SmachContainerStructure [
	| definition | 
	definition :=  browser type: 'smach_msgs/SmachContainerStructure'. 
	self assert: definition typeName = 'smach_msgs/SmachContainerStructure'.
	self assert: definition md5Sum = '3d3d1e0d0f99779ee9e58101a5dcf7ea'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Bool [
	| definition | 
	definition :=  browser type: 'std_msgs/Bool'. 
	self assert: definition typeName = 'std_msgs/Bool'.
	self assert: definition md5Sum = '8b94c1b53db61fb6aed406028ad6332a'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Byte [
	| definition | 
	definition :=  browser type: 'std_msgs/Byte'. 
	self assert: definition typeName = 'std_msgs/Byte'.
	self assert: definition md5Sum = 'ad736a2e8818154c487bb80fe42ce43b'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_ByteMultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/ByteMultiArray'. 
	self assert: definition typeName = 'std_msgs/ByteMultiArray'.
	self assert: definition md5Sum = '70ea476cbcfd65ac2f68f3cda1e891fe'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Char [
	| definition | 
	definition :=  browser type: 'std_msgs/Char'. 
	self assert: definition typeName = 'std_msgs/Char'.
	self assert: definition md5Sum = '1bf77f25acecdedba0e224b162199717'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_ColorRGBA [
	| definition | 
	definition :=  browser type: 'std_msgs/ColorRGBA'. 
	self assert: definition typeName = 'std_msgs/ColorRGBA'.
	self assert: definition md5Sum = 'a29a96539573343b1310c73607334b00'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Duration [
	| definition | 
	definition :=  browser type: 'std_msgs/Duration'. 
	self assert: definition typeName = 'std_msgs/Duration'.
	self assert: definition md5Sum = '3e286caf4241d664e55f3ad380e2ae46'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Empty [
	| definition | 
	definition :=  browser type: 'std_msgs/Empty'. 
	self assert: definition typeName = 'std_msgs/Empty'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float32 [
	| definition | 
	definition :=  browser type: 'std_msgs/Float32'. 
	self assert: definition typeName = 'std_msgs/Float32'.
	self assert: definition md5Sum = '73fcbf46b49191e672908e50842a83d4'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float32MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/Float32MultiArray'. 
	self assert: definition typeName = 'std_msgs/Float32MultiArray'.
	self assert: definition md5Sum = '6a40e0ffa6a17a503ac3f8616991b1f6'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float64 [
	| definition | 
	definition :=  browser type: 'std_msgs/Float64'. 
	self assert: definition typeName = 'std_msgs/Float64'.
	self assert: definition md5Sum = 'fdb28210bfa9d7c91146260178d9a584'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Float64MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/Float64MultiArray'. 
	self assert: definition typeName = 'std_msgs/Float64MultiArray'.
	self assert: definition md5Sum = '4b7d974086d4060e7db4613a7e6c3ba4'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Header [
	| definition | 
	definition :=  browser type: 'std_msgs/Header'. 
	self assert: definition typeName = 'std_msgs/Header'.
	self assert: definition md5Sum = '2176decaecbce78abc3b96ef049fabed'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int16 [
	| definition | 
	definition :=  browser type: 'std_msgs/Int16'. 
	self assert: definition typeName = 'std_msgs/Int16'.
	self assert: definition md5Sum = '8524586e34fbd7cb1c08c5f5f1ca0e57'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int16MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/Int16MultiArray'. 
	self assert: definition typeName = 'std_msgs/Int16MultiArray'.
	self assert: definition md5Sum = 'd9338d7f523fcb692fae9d0a0e9f067c'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int32 [
	| definition | 
	definition :=  browser type: 'std_msgs/Int32'. 
	self assert: definition typeName = 'std_msgs/Int32'.
	self assert: definition md5Sum = 'da5909fbe378aeaf85e547e830cc1bb7'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int32MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/Int32MultiArray'. 
	self assert: definition typeName = 'std_msgs/Int32MultiArray'.
	self assert: definition md5Sum = '1d99f79f8b325b44fee908053e9c945b'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int64 [
	| definition | 
	definition :=  browser type: 'std_msgs/Int64'. 
	self assert: definition typeName = 'std_msgs/Int64'.
	self assert: definition md5Sum = '34add168574510e6e17f5d23ecc077ef'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int64MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/Int64MultiArray'. 
	self assert: definition typeName = 'std_msgs/Int64MultiArray'.
	self assert: definition md5Sum = '54865aa6c65be0448113a2afc6a49270'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int8 [
	| definition | 
	definition :=  browser type: 'std_msgs/Int8'. 
	self assert: definition typeName = 'std_msgs/Int8'.
	self assert: definition md5Sum = '27ffa0c9c4b8fb8492252bcad9e5c57b'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Int8MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/Int8MultiArray'. 
	self assert: definition typeName = 'std_msgs/Int8MultiArray'.
	self assert: definition md5Sum = 'd7c1af35a1b4781bbe79e03dd94b7c13'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_MultiArrayDimension [
	| definition | 
	definition :=  browser type: 'std_msgs/MultiArrayDimension'. 
	self assert: definition typeName = 'std_msgs/MultiArrayDimension'.
	self assert: definition md5Sum = '4cd0c83a8683deae40ecdac60e53bfa8'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_MultiArrayLayout [
	| definition | 
	definition :=  browser type: 'std_msgs/MultiArrayLayout'. 
	self assert: definition typeName = 'std_msgs/MultiArrayLayout'.
	self assert: definition md5Sum = '0fed2a11c13e11c5571b4e2a995a91a3'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_String [
	| definition | 
	definition :=  browser type: 'std_msgs/String'. 
	self assert: definition typeName = 'std_msgs/String'.
	self assert: definition md5Sum = '992ce8a1687cec8c8bd883ec73ca41d1'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_Time [
	| definition | 
	definition :=  browser type: 'std_msgs/Time'. 
	self assert: definition typeName = 'std_msgs/Time'.
	self assert: definition md5Sum = 'cd7166c74c552c311fbcc2fe5a7bc289'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt16 [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt16'. 
	self assert: definition typeName = 'std_msgs/UInt16'.
	self assert: definition md5Sum = '1df79edf208b629fe6b81923a544552d'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt16MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt16MultiArray'. 
	self assert: definition typeName = 'std_msgs/UInt16MultiArray'.
	self assert: definition md5Sum = '52f264f1c973c4b73790d384c6cb4484'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt32 [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt32'. 
	self assert: definition typeName = 'std_msgs/UInt32'.
	self assert: definition md5Sum = '304a39449588c7f8ce2df6e8001c5fce'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt32MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt32MultiArray'. 
	self assert: definition typeName = 'std_msgs/UInt32MultiArray'.
	self assert: definition md5Sum = '4d6a180abc9be191b96a7eda6c8a233d'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt64 [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt64'. 
	self assert: definition typeName = 'std_msgs/UInt64'.
	self assert: definition md5Sum = '1b2a79973e8bf53d7b53acb71299cb57'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt64MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt64MultiArray'. 
	self assert: definition typeName = 'std_msgs/UInt64MultiArray'.
	self assert: definition md5Sum = '6088f127afb1d6c72927aa1247e945af'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt8 [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt8'. 
	self assert: definition typeName = 'std_msgs/UInt8'.
	self assert: definition md5Sum = '7c8164229e7d2c17eb95e9231617fdee'.
		
]

{ #category : #'test-std_msgs/' }
PhaROSTypeBrowserTests >> teststd_msgs_UInt8MultiArray [
	| definition | 
	definition :=  browser type: 'std_msgs/UInt8MultiArray'. 
	self assert: definition typeName = 'std_msgs/UInt8MultiArray'.
	self assert: definition md5Sum = '82373f1612381bb6ee473b5cd6f5d89c'.
		
]

{ #category : #'test-stereo_msgs/' }
PhaROSTypeBrowserTests >> teststereo_msgs_DisparityImage [
	| definition | 
	definition :=  browser type: 'stereo_msgs/DisparityImage'. 
	self assert: definition typeName = 'stereo_msgs/DisparityImage'.
	self assert: definition md5Sum = '04a177815f75271039fa21f16acad8c9'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformAction [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformAction'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformAction'.
	self assert: definition md5Sum = '7ee01ba91a56c2245c610992dbaa3c37'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformActionFeedback [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformActionFeedback'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformActionFeedback'.
	self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformActionGoal [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformActionGoal'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformActionGoal'.
	self assert: definition md5Sum = 'f2e7bcdb75c847978d0351a13e699da5'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformActionResult [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformActionResult'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformActionResult'.
	self assert: definition md5Sum = 'ac26ce75a41384fa8bb4dc10f491ab90'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformFeedback [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformFeedback'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformFeedback'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformGoal [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformGoal'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformGoal'.
	self assert: definition md5Sum = '35e3720468131d675a18bb6f3e5f22f8'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_LookupTransformResult [
	| definition | 
	definition :=  browser type: 'tf2_msgs/LookupTransformResult'. 
	self assert: definition typeName = 'tf2_msgs/LookupTransformResult'.
	self assert: definition md5Sum = '3fe5db6a19ca9cfb675418c5ad875c36'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_TF2Error [
	| definition | 
	definition :=  browser type: 'tf2_msgs/TF2Error'. 
	self assert: definition typeName = 'tf2_msgs/TF2Error'.
	self assert: definition md5Sum = 'bc6848fd6fd750c92e38575618a4917d'.
		
]

{ #category : #'test-tf2_msgs/' }
PhaROSTypeBrowserTests >> testtf2_msgs_TFMessage [
	| definition | 
	definition :=  browser type: 'tf2_msgs/TFMessage'. 
	self assert: definition typeName = 'tf2_msgs/TFMessage'.
	self assert: definition md5Sum = '94810edda583a504dfda3829e70d7eec'.
		
]

{ #category : #'test-tf/' }
PhaROSTypeBrowserTests >> testtf_tfMessage [
	| definition | 
	definition :=  browser type: 'tf/tfMessage'. 
	self assert: definition typeName = 'tf/tfMessage'.
	self assert: definition md5Sum = '94810edda583a504dfda3829e70d7eec'.
		
]

{ #category : #'test-theora_image_transport/' }
PhaROSTypeBrowserTests >> testtheora_image_transport_Packet [
	| definition | 
	definition :=  browser type: 'theora_image_transport/Packet'. 
	self assert: definition typeName = 'theora_image_transport/Packet'.
	self assert: definition md5Sum = '33ac4e14a7cff32e7e0d65f18bb410f3'.
		
]

{ #category : #'test-trajectory_msgs/' }
PhaROSTypeBrowserTests >> testtrajectory_msgs_JointTrajectory [
	| definition | 
	definition :=  browser type: 'trajectory_msgs/JointTrajectory'. 
	self assert: definition typeName = 'trajectory_msgs/JointTrajectory'.
	self assert: definition md5Sum = '65b4f94a94d1ed67169da35a02f33d3f'.
		
]

{ #category : #'test-trajectory_msgs/' }
PhaROSTypeBrowserTests >> testtrajectory_msgs_JointTrajectoryPoint [
	| definition | 
	definition :=  browser type: 'trajectory_msgs/JointTrajectoryPoint'. 
	self assert: definition typeName = 'trajectory_msgs/JointTrajectoryPoint'.
	self assert: definition md5Sum = 'f3cd1e1c4d320c79d6985c904ae5dcd3'.
		
]

{ #category : #'test-trajectory_msgs/' }
PhaROSTypeBrowserTests >> testtrajectory_msgs_MultiDOFJointTrajectory [
	| definition | 
	definition :=  browser type: 'trajectory_msgs/MultiDOFJointTrajectory'. 
	self assert: definition typeName = 'trajectory_msgs/MultiDOFJointTrajectory'.
	self assert: definition md5Sum = 'ef145a45a5f47b77b7f5cdde4b16c942'.
		
]

{ #category : #'test-trajectory_msgs/' }
PhaROSTypeBrowserTests >> testtrajectory_msgs_MultiDOFJointTrajectoryPoint [
	| definition | 
	definition :=  browser type: 'trajectory_msgs/MultiDOFJointTrajectoryPoint'. 
	self assert: definition typeName = 'trajectory_msgs/MultiDOFJointTrajectoryPoint'.
	self assert: definition md5Sum = '3ebe08d1abd5b65862d50e09430db776'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeAction [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeAction'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeAction'.
	self assert: definition md5Sum = 'd73b17d6237a925511f5d7727a1dc903'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeActionFeedback [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeActionFeedback'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeActionFeedback'.
	self assert: definition md5Sum = 'aae20e09065c3809e8a8e87c4c8953fd'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeActionGoal [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeActionGoal'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeActionGoal'.
	self assert: definition md5Sum = 'dbfccd187f2ec9c593916447ffd6cc77'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeActionResult [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeActionResult'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeActionResult'.
	self assert: definition md5Sum = 'c8d13d5d140f1047a2e4d3bf5c045822'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeFeedback [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeFeedback'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeFeedback'.
	self assert: definition md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeGoal [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeGoal'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeGoal'.
	self assert: definition md5Sum = '3b9202ab7292cebe5a95ab2bf6b9c091'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_ShapeResult [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/ShapeResult'. 
	self assert: definition typeName = 'turtle_actionlib/ShapeResult'.
	self assert: definition md5Sum = 'b06c6e2225f820dbc644270387cd1a7c'.
		
]

{ #category : #'test-turtle_actionlib/' }
PhaROSTypeBrowserTests >> testturtle_actionlib_Velocity [
	| definition | 
	definition :=  browser type: 'turtle_actionlib/Velocity'. 
	self assert: definition typeName = 'turtle_actionlib/Velocity'.
	self assert: definition md5Sum = '9d5c2dcd348ac8f76ce2a4307bd63a13'.
		
]

{ #category : #'test-turtlesim/' }
PhaROSTypeBrowserTests >> testturtlesim_Color [
	| definition | 
	definition :=  browser type: 'turtlesim/Color'. 
	self assert: definition typeName = 'turtlesim/Color'.
	self assert: definition md5Sum = '353891e354491c51aabe32df673fb446'.
		
]

{ #category : #'test-turtlesim/' }
PhaROSTypeBrowserTests >> testturtlesim_Pose [
	| definition | 
	definition :=  browser type: 'turtlesim/Pose'. 
	self assert: definition typeName = 'turtlesim/Pose'.
	self assert: definition md5Sum = '863b248d5016ca62ea2e895ae5265cf9'.
		
]

{ #category : #'test-turtlesim/' }
PhaROSTypeBrowserTests >> testturtlesim_Velocity [
		| definition | 
			definition :=  browser type: 'geometry_msgs/Twist'. 
			self assert: definition typeName = 'geometry_msgs/Twist'.
			self assert: definition md5Sum =  '9f195f881246fdfa2798d1d3eebca84a'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_ImageMarker [
	| definition | 
	definition :=  browser type: 'visualization_msgs/ImageMarker'. 
	self assert: definition typeName = 'visualization_msgs/ImageMarker'.
	self assert: definition md5Sum = '1de93c67ec8858b831025a08fbf1b35c'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarker [
	| definition | 
	definition :=  browser type: 'visualization_msgs/InteractiveMarker'. 
	self assert: definition typeName = 'visualization_msgs/InteractiveMarker'.
	self assert: definition md5Sum = '311bd5f6cd6a20820ac0ba84315f4e22'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerControl [
	| definition | 
	definition :=  browser type: 'visualization_msgs/InteractiveMarkerControl'. 
	self assert: definition typeName = 'visualization_msgs/InteractiveMarkerControl'.
	self assert: definition md5Sum = 'e3a939c98cdd4f709d8e1dec2a9c3f37'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerFeedback [
	| definition | 
	definition :=  browser type: 'visualization_msgs/InteractiveMarkerFeedback'. 
	self assert: definition typeName = 'visualization_msgs/InteractiveMarkerFeedback'.
	self assert: definition md5Sum = 'ab0f1eee058667e28c19ff3ffc3f4b78'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerInit [
	| definition | 
	definition :=  browser type: 'visualization_msgs/InteractiveMarkerInit'. 
	self assert: definition typeName = 'visualization_msgs/InteractiveMarkerInit'.
	self assert: definition md5Sum = 'aa2f1dcea79533d1710675195653028d'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerPose [
	| definition | 
	definition :=  browser type: 'visualization_msgs/InteractiveMarkerPose'. 
	self assert: definition typeName = 'visualization_msgs/InteractiveMarkerPose'.
	self assert: definition md5Sum = 'a6e6833209a196a38d798dadb02c81f8'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_InteractiveMarkerUpdate [
	| definition | 
	definition :=  browser type: 'visualization_msgs/InteractiveMarkerUpdate'. 
	self assert: definition typeName = 'visualization_msgs/InteractiveMarkerUpdate'.
	self assert: definition md5Sum = '83e22f99d3b31fde725e0a338200e036'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_Marker [
	| definition | 
	definition :=  browser type: 'visualization_msgs/Marker'. 
	self assert: definition typeName = 'visualization_msgs/Marker'.
	self assert: definition md5Sum = '18326976df9d29249efc939e00342cde'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_MarkerArray [
	| definition | 
	definition :=  browser type: 'visualization_msgs/MarkerArray'. 
	self assert: definition typeName = 'visualization_msgs/MarkerArray'.
	self assert: definition md5Sum = '90da67007c26525f655c1c269094e39f'.
		
]

{ #category : #'test-visualization_msgs/' }
PhaROSTypeBrowserTests >> testvisualization_msgs_MenuEntry [
	| definition | 
	definition :=  browser type: 'visualization_msgs/MenuEntry'. 
	self assert: definition typeName = 'visualization_msgs/MenuEntry'.
	self assert: definition md5Sum = 'b90ec63024573de83b57aa93eb39be2d'.
		
]
