2. Simulate a 4 node point to point network and connect the link as
follows n1-n2, n2-n3, and n4-n2. Apply TCP agent between a
relevant application over tcp and udp.
 Determine the number of packets by tcp and udp
 Number of packets dropped during the transmission
 Analyze the throughput by varying the network parameters
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
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns queue-limit $n0 $n2 50
$ns queue-limit $n1 $n2 50
$ns queue-limit $n2 $n3 50
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
Agent/TCP set packetSize_ 1000
set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0
$ns connect $udp0 $null0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
$ns at 0.75 &quot;$ftp0 start&quot;
$ns at 4.75 &quot;$ftp0 stop&quot;
$ns at 0.5 &quot;$cbr0 start&quot;
$ns at 4.5 &quot;$cbr0 stop&quot;
$ns at 5.0 &quot;finish&quot;
$ns run


AWK
BEGIN{
cupd=0;

ctcp=0;
count=0;
}
{
if($5 == &quot;cbr&quot;){cudp++;}
if($5 == &quot;tcp&quot;){ctcp++;}
if($1 == &quot;d&quot;){count++;}
}
END{
printf(&quot;Number of TCP packets= %d\n&quot;,ctcp);
printf(&quot;Number of UDP packets= %d\n&quot;,cudp);
printf(&quot;Number of packets dropped= %d\n&quot;,count);
}
