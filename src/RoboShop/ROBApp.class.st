"
ROBApp 
	useRobotMock ;
	start

"
Class {
	#name : #ROBApp,
	#superclass : #WATask,
	#classVars : [
		'UseRobotMock'
	],
	#category : #RoboShop
}

{ #category : #accessing }
ROBApp class >> applicationName [
	^'RoboShop'
]

{ #category : #'class initialization' }
ROBApp class >> initialize [ 
	| application |
	UseRobotMock := false.
	application :=  WAAdmin register: self asApplicationAt: self applicationName.
	application preferenceAt: #scriptGeneratorClass put: JQScriptGenerator.
	application preferenceAt: #sessionClass put: ROBSession.
	application
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: TWBSDeploymentLibrary 
]

{ #category : #accessing }
ROBApp class >> robotProxyClass [
	UseRobotMock 
		ifTrue: [ ^ROBRobotXMLRPCClientMock  ]
		ifFalse: [ ^ROBRobotXMLRPCClient ]
	
]

{ #category : #'start / stop' }
ROBApp class >> start [
	ZnZincServerAdaptor startOn: 8080
]

{ #category : #'start / stop' }
ROBApp class >> stop [	
	ZnZincServerAdaptor stop
]

{ #category : #'class initialization' }
ROBApp class >> useRealRobot [
	UseRobotMock := false
]

{ #category : #'class initialization' }
ROBApp class >> useRobotMock [
	UseRobotMock := true
]

{ #category : #running }
ROBApp >> go [
	[  | stargazerIds shoppingCart robotProxy  |
	
		"self call: ROBWelcomePage new."
		
		
		
		
		shoppingCart := self call: ROBFillCartPage new.
		
		
		"try to connect to the robot --- only one connection at a time is possible"
		
		
		robotProxy := self class robotProxyClass new.
		[ robotProxy acquireRobot ] on: Error do: [ :e | 
			self call: ROBRobotBusyPage new ].
		true ifTrue: [  

			self session robotProxy: robotProxy.
		
			"send stargazer ids that the robot should visit"
			stargazerIds := shoppingCart collect: [  :cartItem | cartItem product stargazerIdPosition ].
			robotProxy initializeRobotPathWithStargazerIds: stargazerIds.
			[
				[  
					| currentStargazerId |
					
					
					currentStargazerId := robotProxy goToNextId.
					self call: (ROBFollowMePage toStargazerId: currentStargazerId).
					
					
					"First error page"
					robotProxy hasError ifTrue:[
						self call: (ROBErrorRetry  new).
						robotProxy retry.
						
						self call: (ROBFollowMePage toStargazerId: currentStargazerId).
					].
				
				
					robotProxy hasError ifTrue: [ 
						
						self call: (ROBAskForHelp new).
						self error.
						
					] ifFalse: [
						"fetch all products at currentStargazerId"
						shoppingCart 
							select: [ :cartItem | cartItem product stargazerIdPosition = currentStargazerId ]
							thenDo: [  :cartItem | 
								self call: (ROBFetchCartItemPage with: cartItem) ]			
					].
					
					
				] doWhileFalse: [ robotProxy hasFinished ] .
			] on: Error do: [ 
				
				self call: (ROBTryLater new).
			].
			robotProxy hasError ifFalse: [ 
				"the robot arrived @ home point"
				self call: (ROBCheckouPage forCart: shoppingCart).
				
				robotProxy parking.
				
				robotProxy releaseRobot.

				self session robotProxy: nil.
				"self session unregister" 
			] ifTrue:[
				self call: (ROBTryLater new).
			]
			
		]
	] repeat
	
]
