3. Simulate the different types of Internet traffic such as FTP a
TELNET over a network and analyze the throughput.
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
BEGIN {
sSize = 0;
startTime = 5.0;
stopTime = 0.1;
Tput = 0;
}
{
event = $1;
time = $2;
size = $6;
if(event == &quot;+&quot;)
{
if(time &lt; startTime)
{
startTime = time;
}

}
if(event == &quot;r&quot;) 
{
if(time &gt; stopTime)
{
stopTime = time;
}
sSize += size;
}
Tput = (sSize / (stopTime-startTime))*(8/1000);
printf(&quot;%f\t%.2f\n&quot;, time, Tput);
}
END {
}
