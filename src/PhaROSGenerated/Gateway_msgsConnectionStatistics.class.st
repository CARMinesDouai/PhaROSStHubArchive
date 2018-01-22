Class {
	#name : #'Gateway_msgsConnectionStatistics',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics class >> max_ttl [
	^86400

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics class >> rosTypeDefinition [ 
^' int8 WIRED=1
 int8 WIRELESS=2
 int32 MAX_TTL=86400
 bool gateway_available
 int64 time_since_last_seen
 float32 ping_latency_min
 float32 ping_latency_max
 float32 ping_latency_avg
 float32 ping_latency_mdev
 bool network_info_available
 int8 network_type
 float32 wireless_bitrate
 int8 wireless_link_quality
 float32 wireless_signal_level
 float32 wireless_noise_level
'
]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics class >> rosTypeName [ 
^'gateway_msgs/ConnectionStatistics'
]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics class >> wired [
	^1

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics class >> wireless [
	^2

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> gateway_available [
	^ self getAt: #gateway_available. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> gateway_available: aValue [
	^ self at: #gateway_available put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> initialize [
	super initialize.
	 self gateway_available: false. 
	 self time_since_last_seen: 0. 
	 self ping_latency_min: 0.0. 
	 self ping_latency_max: 0.0. 
	 self ping_latency_avg: 0.0. 
	 self ping_latency_mdev: 0.0. 
	 self network_info_available: false. 
	 self network_type: 0. 
	 self wireless_bitrate: 0.0. 
	 self wireless_link_quality: 0. 
	 self wireless_signal_level: 0.0. 
	 self wireless_noise_level: 0.0. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> network_info_available [
	^ self getAt: #network_info_available. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> network_info_available: aValue [
	^ self at: #network_info_available put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> network_type [
	^ self getAt: #network_type. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> network_type: aValue [
	^ self at: #network_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_avg [
	^ self getAt: #ping_latency_avg. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_avg: aValue [
	^ self at: #ping_latency_avg put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_max [
	^ self getAt: #ping_latency_max. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_max: aValue [
	^ self at: #ping_latency_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_mdev [
	^ self getAt: #ping_latency_mdev. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_mdev: aValue [
	^ self at: #ping_latency_mdev put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_min [
	^ self getAt: #ping_latency_min. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> ping_latency_min: aValue [
	^ self at: #ping_latency_min put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> time_since_last_seen [
	^ self getAt: #time_since_last_seen. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> time_since_last_seen: aValue [
	^ self at: #time_since_last_seen put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_bitrate [
	^ self getAt: #wireless_bitrate. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_bitrate: aValue [
	^ self at: #wireless_bitrate put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_link_quality [
	^ self getAt: #wireless_link_quality. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_link_quality: aValue [
	^ self at: #wireless_link_quality put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_noise_level [
	^ self getAt: #wireless_noise_level. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_noise_level: aValue [
	^ self at: #wireless_noise_level put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_signal_level [
	^ self getAt: #wireless_signal_level. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionStatistics >> wireless_signal_level: aValue [
	^ self at: #wireless_signal_level put: aValue. 

]
