Extension { #name : #Process }

{ #category : #'*ActIT' }
Process >> getProcessSpecificVariableValue: aProcessSpecificVariable [

	self psValueAt: aProcessSpecificVariable soleInstance index
]

{ #category : #'*ActIT' }
Process >> setProcessSpecificVariableValue: aProcessSpecificVariable with: aValue [

	self psValueAt: aProcessSpecificVariable soleInstance index put: aValue
]
