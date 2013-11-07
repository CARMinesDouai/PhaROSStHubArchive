Class {
	#name : #ROBOffice,
	#superclass : #ROBLabElement,
	#instVars : [
		'description',
		'number',
		'employees'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #constructor }
ROBOffice class >> number: aNumber [	
	^ self new number: aNumber; yourself
]

{ #category : #offices }
ROBOffice class >> office3101 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point26); number: 3101;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3102 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point27); number: 3102;description:''; employees: { ROBEmployee JacquesBOONAERT .})
]

{ #category : #offices }
ROBOffice class >> office3103 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point25); number: 3103;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3105 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point24); number: 3105;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3108 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point23); number: 3108;description:''; employees: { ROBEmployee MoamarSAYEDMOUCHAWEH .})
]

{ #category : #offices }
ROBOffice class >> office3109 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point13); number: 3109;description:''; employees: { ROBEmployee InesYanyunLU .})
]

{ #category : #offices }
ROBOffice class >> office3110 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point14); number: 3110;description:''; employees: { ROBEmployee CecileLABARRE .})
]

{ #category : #offices }
ROBOffice class >> office3111 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point16); number: 3111;description:''; employees: { ROBEmployee FredericKLOPCIC .})
]

{ #category : #offices }
ROBOffice class >> office3112 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point17); number: 3112;description:''; employees: { ROBEmployee GabrielHOUSSAYE .})
]

{ #category : #offices }
ROBOffice class >> office3113 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point18); number: 3113;description:''; employees: { ROBEmployee FrancoisCORTE .})
]

{ #category : #offices }
ROBOffice class >> office3114 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point21); number: 3114;description:''; employees: { ROBEmployee LalaRAJAOARISOA .})
]

{ #category : #offices }
ROBOffice class >> office3117 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point20); number: 3117;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3118 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point19); number: 3118;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3119 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point15); number: 3119;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3122 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point10); number: 3122;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3125 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point9); number: 3125;description:''; employees: { ROBEmployee GuillermoPOLITO . ROBEmployee ZhiYAN . ROBEmployee NickolaosPAPOULIAS .})
]

{ #category : #offices }
ROBOffice class >> office3126 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point8); number: 3126;description:''; employees: { ROBEmployee NouryBOURAQUADI .})
]

{ #category : #offices }
ROBOffice class >> office3127 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point7); number: 3127;description:''; employees: { ROBEmployee HouariTOUBAKH . ROBEmployee AntoineCHAMMAS .})
]

{ #category : #offices }
ROBOffice class >> office3128 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point6); number: 3128;description:''; employees: { ROBEmployee AntoineSYLVAIN . ROBEmployee BlaiseGUEPIE .})
]

{ #category : #offices }
ROBOffice class >> office3130 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point4); number: 3130;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3131 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point2); number: 3131;description:''; employees: { ROBEmployee KlaudiaHORVATH . ROBEmployee SantiagoBRAGAGNOLO })
]

{ #category : #offices }
ROBOffice class >> office3134 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point29); number: 3134;description:''; employees: { ROBEmployee EricDUVIELLA .})
]

{ #category : #offices }
ROBOffice class >> office3136 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point30); number: 3136;description:''; employees: { ROBEmployee AnthonyFLEURY .})
]

{ #category : #offices }
ROBOffice class >> office3137 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point31); number: 3137;description:''; employees: { ROBEmployee ArnaudDONIEC .})
]

{ #category : #offices }
ROBOffice class >> office3139 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point33); number: 3139;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3140 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point36); number: 3140;description:''; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3142 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point32); number: 3142;description:''; employees: { ROBEmployee MurielMORGAN .})
]

{ #category : #offices }
ROBOffice class >> office3143 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point34); number: 3143;description:''; employees: { ROBEmployee PhilippeHASBROUCQ .})
]

{ #category : #offices }
ROBOffice class >> office3144 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point35); number: 3144;description:''; employees: { ROBEmployee ChristineDELILLE .})
]

{ #category : #offices }
ROBOffice class >> office3145 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point37); number: 3145;description:''; employees: { ROBEmployee JannikLaval .})
]

{ #category : #dump }
ROBOffice >> asDump [
	| es |
	es := (employees
				inject: '{'
				into: [:acc :mr | acc , mr asDump , '.'])
				, '}'.

	ROBOffice class
		compile: ('office{1} 
^{2}' format: {number asString. '(' , super asDump , '; number: {1};description:''{2}''; employees: {3})' format: {number asString . self description . es}}).
	^ 'ROBOffice office{1}' format: {number asString}
]

{ #category : #accessing }
ROBOffice >> description [
	^ description ifNil:[''].
]

{ #category : #accessing }
ROBOffice >> description: anObject [
	
	description := anObject
]

{ #category : #accessing }
ROBOffice >> employees [
	
	^ employees
]

{ #category : #accessing }
ROBOffice >> employees: aSet [ 
	aSet do: [  : e | self register:e  ].
]

{ #category : #accessing }
ROBOffice >> initialize [ 	
	employees := Set new.
]

{ #category : #accessing }
ROBOffice >> number [
	
	^ number
]

{ #category : #accessing }
ROBOffice >> number: aSmallInteger [ 
	number := aSmallInteger
]

{ #category : #accessing }
ROBOffice >> printOn: aStream [
	('Office {1}' format: { number asString })printOn: aStream
]

{ #category : #accessing }
ROBOffice >> register: anEmployee [
	employees add: anEmployee.
	anEmployee office: self .
]
