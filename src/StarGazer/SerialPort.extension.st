Extension { #name : #SerialPort }

{ #category : #'*StarGazer' }
SerialPort >> asSGStream [
	^ SGStream for: ( SerialStream for: self).
]
