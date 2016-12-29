set flowtable [exec "sh ip cache flow"]

set fmt1 "%-13s %-15s %-13s %-15s %2s %5i %5i %4s"
foreach flowline [split $flowtable "\r\n"] {
	if {$flowline != ""} {
		if [regexp {([a-zA-Z0-9/:\.]+)\s+([0-9\.]+)\s+([a-zA-Z0-9/:\.\*]+)\s+([0-9\.]+)\s+([0-9][0-9])\s+([A-F0-9]+)\s+([A-F0-9]+)\s+([KMG0-9]+)} $flowline -> srcif srcip dstif dstip proto srcport dstport pkts] {
			#puts "---> $flowline"
			#puts "$srcport -- [expr 0x$srcport] $dstport -- [expr 0x$dstport]"
			puts "[format $fmt1 $srcif $srcip $dstif $dstip $proto [expr 0x$srcport] [expr 0x$dstport] $pkts]"
		} else {
			if [regexp {SrcIf         SrcIPaddress    DstIf         DstIPaddress    Pr SrcP DstP  Pkts} $flowline] {
				puts "REPLf         SrcIPaddress    DstIf         DstIPaddress    Pr SrcP  DstP   Pkts"
			} else {
				puts "$flowline"
			}
		}
	}
}