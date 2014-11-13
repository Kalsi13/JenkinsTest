class { "foo":
  firewall      => true,
  firewall_tool => "iptables",
  firewall_src  => "10.42.0.0/24",
  firewall_dst  => "$ipaddress_eth0",
}
