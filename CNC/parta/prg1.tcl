1. Simulate a three nodes point-to-point network with duplex links
between them. Set the queue size, vary the bandwidth and find
the number of packets dropped.
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
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns queue-limit $n1 $n2 50
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n2 $null0
$ns connect $udp0 $null0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005

$cbr0 attach-agent $udp0
$ns at 0.5 &quot;$cbr0 start&quot;
$ns at 4.5 &quot;$cbr0 stop&quot;
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
