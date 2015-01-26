Class {
	#name : #ManifestTaskIT,
	#superclass : #Object,
	#category : #TaskIT
}

{ #category : #'meta data' }
ManifestTaskIT class >> rejectClasses [
^ #()
]

{ #category : #'meta data' }
ManifestTaskIT class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestTaskIT class >> ruleIfTrueBlocksRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#TKTQueue #peekIfNothing: #false)) #'2014-01-25T00:27:14.867000001+01:00') #(#(#RGMethodDefinition #(#TKTQueue #nextIfTimeOut: #false)) #'2014-01-25T00:27:14.867+01:00') )
]

{ #category : #'meta data' }
ManifestTaskIT class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#TKTQueue #peekIfNothing: #false)) #'2014-01-25T00:27:14.944+01:00') #(#(#RGMethodDefinition #(#TKTTask #runOnRunner:withFuture: #false)) #'2014-01-25T00:27:14.944000001+01:00') )
]
