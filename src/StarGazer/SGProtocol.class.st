Class {
	#name : #SGProtocol,
	#superclass : #Object,
	#category : #'StarGazer-Kernel'
}

{ #category : #parameters }
SGProtocol class >> baudRate [
	^ 'BaudRate'. "BaudRate"
	
"	


	MarkHeight:='MarkHeight'.
	MarkType:='MarkType'.
	MarkMode:='MarkMode'.
	BaudRate:='BaudRate'.
	HeightCals:='HeightCalc'.
	MapMode:='MapMode'.
	CalcStart:='CalcStart'.
	CalcStop:='CalcStop'.
	SetEnd:='SetEnd'.
	Reset:='Reset'.
	
	separator:='|'."
]

{ #category : #commands }
SGProtocol class >> commandCalcStart [
	^'CalcStart'.

]

{ #category : #commands }
SGProtocol class >> commandCalcStop [
	^'CalcStop'.

]

{ #category : #commands }
SGProtocol class >> commandReset [
	^'Reset'.

]

{ #category : #commands }
SGProtocol class >> commandSetEnd [
	^'SetEnd'.

]

{ #category : #parameters }
SGProtocol class >> heightCalc [
	^ 'HeightCalc'. "HeightCalc"
	
"	


	MapMode:='MapMode'.
	CalcStart:='CalcStart'.
	CalcStop:='CalcStop'.
	SetEnd:='SetEnd'.
	Reset:='Reset'.
	
	separator:='|'."
]

{ #category : #parameters }
SGProtocol class >> heightFix [
	^ 'HeightFix'. "HeightFix"
	
]

{ #category : #parameters }
SGProtocol class >> idNum [
	^ 'IDNum'. "IDNum"
	
]

{ #category : #parameters }
SGProtocol class >> mapMode [
	^ 'MapMode'. "MapMode"
	
]

{ #category : #parameters }
SGProtocol class >> markHeight [
	^ 'MarkHeight'. "MarkHeight"
	
]

{ #category : #parameters }
SGProtocol class >> markMode [
	^ 'MarkMode'. "MarkMode"
	
]

{ #category : #parameters }
SGProtocol class >> markType [
	^ 'MarkType'. "MarkType"
	
]

{ #category : #'message split' }
SGProtocol class >> messageEnd [
	^ '`'. "ETX"
	
]

{ #category : #'message split' }
SGProtocol class >> messageStart [
	^ '~'. "STX"
	
]

{ #category : #parameters }
SGProtocol class >> refID [
	^ 'RefID'. "RefID"
	
]

{ #category : #'message split' }
SGProtocol class >> separator [
	^ '|'. 
	
]

{ #category : #'message type' }
SGProtocol class >> typeACK [
	^ '!'. "ACK"
	
]

{ #category : #'message type' }
SGProtocol class >> typePlainMessage [
	^ '*'. "Msg"
	
]

{ #category : #'message type' }
SGProtocol class >> typeRead [
	^ '@'. "Read"
	
]

{ #category : #'message type' }
SGProtocol class >> typeReturn [
	^ '$'. "Return"
	
]

{ #category : #'message type' }
SGProtocol class >> typeWrite [
	^ '#'. "Write"
	
]

{ #category : #parameters }
SGProtocol class >> version [
	^ 'Version'. "Version"
	
]
