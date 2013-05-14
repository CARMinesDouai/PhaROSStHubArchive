Class {
	#name : #PureROSPlotBuilderTests,
	#superclass : #TestCase,
	#category : #'PureROS-Util-Test'
}

{ #category : #'as yet unclassified' }
PureROSPlotBuilderTests >> testBuildSeveral [
	| builder |
	
	builder := PureROSPlotBuilder new.
	builder newLineFor: '/aTopicID'.
	(builder newLineFor: '/anOtherTopic') with type browsing.
	(builder newLineFor: '/anOtherOtherTopic') fields:{#f1 . #f2}.
	(builder newLineFor: '/anOtherTopic') with type browsing fields:{#f1 . #f2}.
	
	self assert: builder plottingLines asArray = {'/aTopicID' . '/anOtherTopic/with/type/browsing' . '/anOtherOtherTopic/f1:f2' . '/anOtherTopic/with/type/browsing/f1:f2' }.
	
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilderTests >> testJustTopicLine [
	self assert: (PureROSPlotTopic for: '/aTopic') plotLine = '/aTopic'.
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilderTests >> testTopicWithFields [
	self assert: ((PureROSPlotTopic for: '/aTopic') fields: { #field1 . #field2 })plotLine = '/aTopic/field1:field2'.
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilderTests >> testTopicWithTypeBrowsing [
	self assert: (PureROSPlotTopic for: '/aTopic') with type browsing plotLine = '/aTopic/with/type/browsing'.
]

{ #category : #'as yet unclassified' }
PureROSPlotBuilderTests >> testTopicWithTypeBrowsingAndFields [
	self assert: ((PureROSPlotTopic for: '/aTopic') with type browsing fields: { #field1 . #field2 })plotLine = '/aTopic/with/type/browsing/field1:field2'.
]
