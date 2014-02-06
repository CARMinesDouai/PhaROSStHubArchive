Class {
	#name : #ChatterPackage,
	#superclass : #PhaROSPackage,
	#category : #ChatterPackage
}

{ #category : #'private - configuration' }
ChatterPackage >> buildController [
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self nodeletInjectionExample: super buildController.

]

{ #category : #'private - configuration' }
ChatterPackage >> nodeletInjectionExample: aController [
	"
		Nodelets are units objects responsible for solving common problems, meaning that there are reusable. 
	In order to access to a nodelet from a package we use a simple mechanism of dependency injection, so we 
	can easily change one implementation for other. 
		The main problem is the management of name for registration. Try to be clean and obvious with names. Comment and make them visible.
	For know more about nodelets go to the reference or check subclasses (PhaROSTransformationNodelet is a cool place to go)"

	aController nodelets use: ChatterNodelets as:#chatter.
	^ aController.
	

]

{ #category : #scripts }
ChatterPackage >> scriptListener [


	self log: 'Starting up Listener '.
	
	(self node buildConnectionFor:  '/chat/channel') 
				typedAs: 'std_msgs/String' ; 
				for: [ : aMsg :aChannel | 
					self stdout nextPutAll: aChannel owner name, ' said:'.
					self stdout  nextPutAll: aMsg data.
					self stdout  nextPutAll: String lf.
				 ];
				connect.
				
	self log: 'You will read here all the text written in talker nodes'.
]

{ #category : #'nodelet scripts' }
ChatterPackage >> scriptNodeletListener [
	self log: 'Starting up Listener '.
	self nodelets chatter listener output: self stdout.
	self log: 'You will read here all the text written in talker nodes'.
]

{ #category : #'nodelet scripts' }
ChatterPackage >> scriptNodeletTalker [
	self log: 'Starting up Talker'.
	self nodelets chatter talker consume: self stdin.
	self log: 'Write your input and press enter'.
]

{ #category : #scripts }
ChatterPackage >> scriptTalker [
	| publisher |
	self log: 'Starting up Talker'.
	publisher := self node topicPublisher: '/chat/channel' typedAs: 'std_msgs/String'.
	self paralellize looping talkTo: publisher.
	self log: 'Write your input and press enter'.
]

{ #category : #'private - talker' }
ChatterPackage >> talkTo: publisher [
	| token |
	publisher send: [ : m | 
		token :=self stdin upTo: Character lf.
		self log: 'Sending data to all subscribers'.
		m data: token. 
	].
]
