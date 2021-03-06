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
KobukiNodelet class >> odomResetTopic [
	^ '/mobile_base/commands/reset_odometry'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> odomResetTopicType [
	^ 'std_msgs/Empty'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> servoTopic [
	^ '/servo'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> servoTopicType [
	^ 'std_msgs/UInt16'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar0Topic [
	^ '/sonar0'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar0TopicType [
	^ 'std_msgs/UInt16'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar1Topic [
	^ '/sonar1'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar1TopicType [
	^ 'std_msgs/UInt16'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar2Topic [
	^ '/sonar2'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar2TopicType [
	^ 'std_msgs/UInt16'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar3Topic [
	^ '/sonar3'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar3TopicType [
	^ 'std_msgs/UInt16'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar4Topic [
	^ '/sonar4'
]

{ #category : #'as yet unclassified' }
KobukiNodelet class >> sonar4TopicType [
	^ 'std_msgs/UInt16'
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
	^ '/depart'
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

{ #category : #'initialize-release' }
KobukiNodelet >> initialize [
	super initialize
]

{ #category : #'as yet unclassified' }
KobukiNodelet >> kobuki [
	^ kobuki
		ifNil: [ 
			kobuki := Kobuki
				for: (self controller node topicPublisher: KobukiNodelet velocityTopic typedAs: KobukiNodelet velocityTopicType)
				and: (self controller node topicPublisher: KobukiNodelet odomResetTopic typedAs: KobukiNodelet odomResetTopicType)
				and: (self controller node topicPublisher: KobukiNodelet servoTopic typedAs: KobukiNodelet servoTopicType)
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
			(self controller node buildConnectionFor: self class sonar0Topic)
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonar0: msg data ];
				connect.
			(self controller node buildConnectionFor: self class sonar1Topic)
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonar1: msg data ];
				connect.
			(self controller node buildConnectionFor: self class sonar2Topic)
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonar2: msg data ];
				connect.
			(self controller node buildConnectionFor: self class sonar3Topic)
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonar3: msg data ];
				connect.
			(self controller node buildConnectionFor: self class sonar4Topic)
				typedAs: 'std_msgs/UInt16';
				for: [ :msg | kobuki sonar4: msg data ];
				connect.
				
			(self controller node buildConnectionFor: KobukiNodelet startTriggerTopic)
				typedAs: KobukiNodelet startTriggerTopicType;
				for: [ :msg | 
							kobuki timerStart.
							kobuki event: #onStartTrigger ];
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
				and: (self controller node topicPublisher: KobukiNodelet servoTopic typedAs: KobukiNodelet servoTopicType)
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
			"pour lire un subscriber-->depart"
			(self controller node buildConnectionFor: KobukiNodelet startTriggerTopic)
				typedAs: KobukiNodelet startTriggerTopicType;
				for: [ :msg | 
					msg data ifTrue: [ kobuki timerStart.
					kobuki event:#onStartTrigger.
					Transcript cr;show:msg.
					]
					];
				connect.

			"pour lire un subscriber-->sonar0"
			(self controller node buildConnectionFor: KobukiNodelet sonar0Topic)
				typedAs: KobukiNodelet sonar0TopicType;
				for: [ :msg | kobuki sonar0: msg data. 
					];
				connect.
			"pour lire un subscriber-->sonar1"
			(self controller node buildConnectionFor: KobukiNodelet sonar1Topic)
				typedAs: KobukiNodelet sonar1TopicType;
				for: [ :msg | kobuki sonar1: msg data. 
					];
				connect.
			"pour lire un subscriber-->sonar2"
			(self controller node buildConnectionFor: KobukiNodelet sonar2Topic)
				typedAs: KobukiNodelet sonar2TopicType;
				for: [ :msg | kobuki sonar2: msg data. 
					];
				connect.
			"pour lire un subscriber-->sonar3"
			(self controller node buildConnectionFor: KobukiNodelet sonar3Topic)
				typedAs: KobukiNodelet sonar3TopicType;
				for: [ :msg | kobuki sonar3: msg data. 
					];
				connect.
			kobuki changeEtat: KobukiNodelet EtatInitial new.
			 ] 
]
