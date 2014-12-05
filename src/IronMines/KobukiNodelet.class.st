Class {
	#name : #KobukiNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'kobuki'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
KobukiNodelet class >> EtatInitial [
	^Etat .
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> bumperTopic [
	^ '/mobile_base/events/bumper'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> bumperTopicType [
	^ 'kobuki_msgs/BumperEvent'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> canonTopic [
	^ '/canonTrigger'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> canonTopicType [
	^ 'std_msgs/Bool'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> odomResetTopic [
	^ '/mobile_base/commands/reset_odometry'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> odomResetTopicType [
	^ 'std_msgs/Empty'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> soundTopic [
	^ '/mobile_base/commands/sound'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> soundTopicType [
	^ 'kobuki_msgs/Sound'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> startTriggerTopic [
	^ '/startTrigger'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> startTriggerTopicType [
	^ 'std_msgs/Bool'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> velocityTopic [
	^ '/mobile_base/commands/velocity'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> velocityTopicType [
	^ 'geometry_msgs/Twist'
]

{ #category : #'as yet unclassified' }
KobukiNodelet >> kobuki [
	^ kobuki
		ifNil: [ 
			kobuki := Kobuki
				for: (self controller node topicPublisher: KobukiNodelet velocityTopic typedAs: KobukiNodelet velocityTopicType)
				and: (self controller node topicPublisher: KobukiNodelet odomResetTopic typedAs: KobukiNodelet odomResetTopicType)
				and: (self controller node topicPublisher: KobukiNodelet canonTopic typedAs: KobukiNodelet canonTopicType)
				and: (self controller node topicPublisher: KobukiNodelet soundTopic typedAs: KobukiNodelet soundTopicType).
			(self controller node buildConnectionFor: KobukiNodelet bumperTopic)
				typedAs: KobukiNodelet bumperTopicType;
				for: [ :msg | 
							self log: msg asString.
							kobuki bumper: msg state ];
				connect.
			(self controller node buildConnectionFor: '/odom')
				typedAs: 'nav_msgs/Odometry';
				for: [ :msg | kobuki odom: msg ];
				adapted: #pose \> #pose;
				connect.
			(self controller node buildConnectionFor: '/sonnars/0')
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonnar0: msg data ];
				connect.
			(self controller node buildConnectionFor: '/sonnars/1')
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonnar1: msg data ];
				connect.
			(self controller node buildConnectionFor: '/sonnars/2')
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonnar2: msg data ];
				connect.
			(self controller node buildConnectionFor: KobukiNodelet startTriggerTopic)
				typedAs: KobukiNodelet startTriggerTopicType;
				for: [ :msg | 
					kobuki timerStart.
					kobuki event:#onStartTrigger ];
				connect.
			kobuki changeEtat: KobukiNodelet EtatInitial new ]
]

{ #category : #'as yet unclassified' }
KobukiNodelet >> kobukiSansSonar [
	^ kobuki
		ifNil: [ 
			kobuki := Kobuki
				for: (self controller node topicPublisher: KobukiNodelet velocityTopic typedAs: KobukiNodelet velocityTopicType)
				and: (self controller node topicPublisher: KobukiNodelet odomResetTopic typedAs: KobukiNodelet odomResetTopicType)
				and: (self controller node topicPublisher: KobukiNodelet canonTopic typedAs: KobukiNodelet canonTopicType)
				and: (self controller node topicPublisher: KobukiNodelet soundTopic typedAs: KobukiNodelet soundTopicType).
			(self controller node buildConnectionFor: KobukiNodelet bumperTopic)
				typedAs: KobukiNodelet bumperTopicType;
				for: [ :msg | 
							self log: msg asString.
							kobuki bumper: msg state ];
				connect.
			(self controller node buildConnectionFor: '/odom')
				typedAs: 'nav_msgs/Odometry';
				for: [ :msg | self kobuki odom: msg ];
				adapted: #pose \> #pose;
				connect.
				
			"(self controller node buildConnectionFor: KobukiNodelet startTriggerTopic)
				typedAs: KobukiNodelet startTriggerTopicType;
				for: [ :msg | 
					kobuki timerStart.
					kobuki event:#onStartTrigger ];
				connect.
			kobuki changeEtat: KobukiNodelet EtatInitial new" ]
]
