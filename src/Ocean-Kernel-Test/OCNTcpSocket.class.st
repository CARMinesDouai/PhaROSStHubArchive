"
an OCNTcpSocket has the following lifecycle :
 
state 1 : closed
state 2 : connected
state 3 : listening
state 4 : destroyed
1 -> 2, 3, 4
2 -> 1
3 -> 1

"
Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}
