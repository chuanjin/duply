#
# Cookbook Name:: duply
# Recipe:: default
#
# Copyright 2014, Chuan Jin
# License: MIT

if node[:duply][:s3][:target_user].empty?
fail 'AWS S3 access ID must be configured'
end
if node[:duply][:s3][:target_pass].empty?
fail 'AWS S3 secret key must be configured'
end

execute "apt-get update -y" do
    command "apt-get update -y"
    action :run
end

# install dependencies
%w(duply duplicity python-boto).each do |p|
  package p do
    action :install
  end
end


# Fetch the backup name
backup_name = node[:duply][:backup_name]

directory "/etc/duply/#{backup_name}" do
  action :create
  recursive true
end

template "/etc/duply/#{backup_name}/conf" do
  source "conf.erb"
  action :create
  mode "0600"
  variables ({
  	:gpg_pw => node[:duply][:GPG_PW],
  	:target => node[:duply][:s3][:target],
	:target_user => node[:duply][:s3][:target_user],
	:target_pass => node[:duply][:s3][:target_pass],
	:source => node[:duply][:s3][:source]
	})
end

template "etc/duply/#{backup_name}/exclude" do
  source "exclude.erb"
  action :create
  mode "0664"
  variables ({
  	:prefix => node[:duply][:s3][:source],
	:includes => node[:duply][:s3][:includes]
  	})
end


cron "duply_backup_task" do  
  day node[:duply]["day"]
  hour node[:duply]["hour"]
  minute node[:duply]["minute"]
  command "duply #{backup_name} backup"
end

