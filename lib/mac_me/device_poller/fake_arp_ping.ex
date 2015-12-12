defmodule MacMe.DevicePoller.FakeArpPing do
  @arpPingOutput """
    Interface: en0, datalink type: EN10MB (Ethernet)
    Starting arp-scan 1.9 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
    172.19.131.2	00:e0:4b:22:96:d9	JUMP INDUSTRIELLE COMPUTERTECHNIK GmbH
    172.19.131.94	58:7f:57:6b:be:e1	(Unknown)
    172.19.131.95	a4:db:30:e8:9a:a8	(Unknown)
    172.19.131.107	7c:e9:d3:29:2d:68	Hon Hai Precision Ind. Co.,Ltd.
    172.19.131.110	5c:f9:38:ad:a9:d2	(Unknown)
    172.19.131.114	7c:7a:91:47:1b:84	Intel Corporate
    172.19.131.115	74:81:14:42:11:b8	(Unknown)
    172.19.131.122	9c:f3:87:d4:76:9a	(Unknown)
    172.19.131.123	90:8d:6c:6a:2d:c8	(Unknown)
    172.19.131.131	cc:20:e8:9a:8b:ae	(Unknown)
    172.19.131.137	b8:4f:d5:44:c5:b4	(Unknown)
    172.19.131.138	30:59:b7:0c:0e:82	(Unknown)
    172.19.131.147	a0:99:9b:0a:3e:cd	(Unknown)
    172.19.131.160	90:8d:6c:14:9c:3a	(Unknown)
    172.19.131.167	80:be:05:42:45:88	(Unknown)
    172.19.131.120	a4:4e:31:3b:7a:80	Intel Corporate
    172.19.131.144	34:12:98:aa:42:7e	(Unknown)

    529 packets received by filter, 0 packets dropped by kernel
    Ending arp-scan 1.9: 256 hosts scanned in 1.834 seconds (139.59 hosts/sec). 17 responded
    """

  def run(_subnets) do
    @arpPingOutput |> MacMe.Support.Helpers.extract_mac
  end
end
