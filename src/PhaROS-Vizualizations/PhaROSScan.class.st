"
A PhaROSScan shows a Sensor_msgsLaserScan

It requires a stream object, <scan holder> that understands the selector <value message>, which returns the new instance of Sensor_msgsLaserScan. 

PhaROSScan new stream: <scan holder>; selector: <value message>

Example of manual refresh:
|inst|
inst := PhaROSScan new stream: <scan holder>; selector: <value message>.
inst open. ""open the window""
inst refresh. ""redraw the visualization""

Example of automatic refresh:
|inst|
inst := PhaROSScan new stream: <scan holder>; selector: <value message>.
inst autorfresh ""opens and refreshes every 200 milis""
"
Class {
	#name : #PhaROSScan,
	#superclass : #Object,
	#instVars : [
		'stream',
		'selector',
		'low',
		'high',
		'first',
		'last',
		'builder'
	],
	#category : #'PhaROS-Vizualizations'
}

{ #category : #visualization }
PhaROSScan >> autorefresh [
	| thread |
	self open.
	(Delay forMilliseconds: 200) wait.
	thread := [[ true ] whileTrue: [ self refresh. (Delay forMilliseconds: 200) wait ]] fork.
	thread name: 'PhaROSScan autorefresh'.
]

{ #category : #visualization }
PhaROSScan >> bandpass: anArray low: min high: max [

	"INPLACE bandpass filter that puts outliers to max"

	1 to: anArray size do: [ :idx | |val|
		val := anArray at: idx.
		val < min ifTrue: [ anArray at: idx put: max]
			ifFalse: [ val > max ifTrue: [ anArray at: idx put: max]]]
]

{ #category : #visualization }
PhaROSScan >> buildDataset [
	| points dataset |

	points := (stream perform: selector) ranges.
	last = 0 ifFalse: [ points := points copyFrom: first to: last ].
	
	self bandpass: points low: self low high: self high.

	dataset := RTStackedDataSet new.
	dataset points: points.
	dataset dotShape size: 5; color: Color blue.
	dataset y: #yourself.
	^ dataset
]

{ #category : #accessing }
PhaROSScan >> first: anObject [
	first := anObject
]

{ #category : #accessing }
PhaROSScan >> high [
	^ high
]

{ #category : #accessing }
PhaROSScan >> high: anObject [
	high := anObject
]

{ #category : #initialization }
PhaROSScan >> initialize [

	" min and max values for the distances"
	self low: 0.18.
	self high: 8.
	
	" what is the first and the last point of the sweep to graph"
	self first: 1.
	self last: 0. "the entire sweep"
]

{ #category : #accessing }
PhaROSScan >> last: anObject [
	last := anObject
]

{ #category : #accessing }
PhaROSScan >> low [
	^ low
]

{ #category : #accessing }
PhaROSScan >> low: anObject [
	low := anObject
]

{ #category : #visualization }
PhaROSScan >> open [

	builder := RTGrapher new.
	builder add: self buildDataset.
	builder build open
]

{ #category : #visualization }
PhaROSScan >> refresh [
	 | view |
	view := builder view.
	view cleanAll.
	builder := RTGrapher new.
	builder view: view.
	builder add: self buildDataset.
	builder build
	view signalUpdate
]

{ #category : #accessing }
PhaROSScan >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
PhaROSScan >> stream: anObject [
	stream := anObject
]
