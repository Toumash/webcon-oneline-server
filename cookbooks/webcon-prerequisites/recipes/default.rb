# Cookbook Name:: main
# Recipe:: default
#

batch "disable-firewall" do
  code <<-EOH
      @echo off
      echo Disabling firewall
      netsh advfirewall set allprofiles state off
      EOH
end
