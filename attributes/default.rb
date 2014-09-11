# Your back up name, the profile for duply
default[:duply][:backup_name] = "mybackup"

# Symmetric encryption: here we only uses a single password for encryption, 
default[:duply][:GPG_PW] = "YourPassword"

# AWS S3 credentials 
default[:duply][:s3][:target] = "s3://s3-eu-west-1.amazonaws.com/YOUR_BUCKET/YOUR_FOLDER"
default[:duply][:s3][:target_user] = "AWS access ID"
default[:duply][:s3][:target_pass] = "AWS access key"

# Base directory to backup
default[:duply][:s3][:source] = "/"
# List directories to backup inside base
default[:duply][:s3][:includes] = ["root", "home"]

# Backup frequency 
default[:duply][:day] = "*"
default[:duply][:hour] = "4"
default[:duply][:minute] = "0"