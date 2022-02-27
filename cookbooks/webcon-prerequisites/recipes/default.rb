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

windows_feature "Web-Server" do
  all true
  action :install
  install_method :windows_feature_powershell
end

windows_feature "Web-Mgmt-Tools" do
  all true
  action :install
  install_method :windows_feature_powershell
end
