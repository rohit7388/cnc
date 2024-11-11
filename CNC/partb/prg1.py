1. Write a program for frame sorting technique used in buffers.

import random as rd
msg=input(&quot;Enter the message :&quot;)
packets = [[i//3,msg[i:(i+3) if i+3 &lt; len(msg) else None]] for i in
range(0,len(msg),3)]
print(&quot;packets :&quot;,packets)
rd.shuffle(packets)
print(&quot;shuffled packets: &quot;,packets)
packets.sort(key=lambda a: a[0])
print(&quot;sorted packets: &quot;,packets)
