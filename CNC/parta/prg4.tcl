4. Simulate an Ethernet LAN using N nodes and set multiple traffic
nodes and determine collision across different nodes.
set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
set tf [open out.tr w]
$ns trace-all $tf
proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam out.nam &amp;
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]

set n9 [$ns node]
$ns make-lan &quot;$n0 $n1 $n2 $n3 $n4 $n5 $n6 $n7 $n8 $n9&quot; 100Mb
10ms LL
Queue/DropTail Mac/802_3
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
Agent/TCP set packetSize_ 1000
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
set telnet0 [new Application/Telnet]
$telnet0 set interval_ 0.005
$telnet0 attach-agent $tcp1
$ns at 0.75 &quot;$ftp0 start&quot;
$ns at 4.75 &quot;$ftp0 stop&quot;
$ns at 0.5 &quot;$telnet0 start&quot;
$ns at 4.5 &quot;$telnet0 stop&quot;
$ns at 5.0 &quot;finish&quot;
$ns run
AWK
BEGIN{
count=0;
}
{
event=$1;
if(event==&quot;d&quot;)
{
count++;
}
}
END{
printf(&quot;\nNumber of packets dropped is :%d\n&quot;,count);

}
