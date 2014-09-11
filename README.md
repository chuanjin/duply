duply Cookbook
==============
This simple cookbook installs and configures Duply and backup specified directories from the local file system to Amazon S3 nightly.



Requirements
------------
Ubuntu OS


Attributes
----------

#### duply::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  
  <tr>
    <td><tt>[:duply][:backup_name]</tt></td>
    <td>String</td>
    <td>Your back up name</td>
    <td><tt>"mybackup"</tt></td>
  </tr>
  
  <tr>
    <td><tt>[:duply][:GPG_PW]</tt></td>
    <td>String</td>
    <td>Your symmetric password</td>
    <td><tt>"YourPassword"</tt></td>
  </tr>
  
   <tr>
    <td><tt>[:duply][:s3][:target]</tt></td>
    <td>String</td>
    <td>AWS S3 target</td>
    <td><tt>"s3://s3-eu-west-1.amazonaws.com/YOUR_BUCKET/YOUR_FOLDER"</tt></td>
  </tr>
  
  <tr>
    <td><tt>[:duply][:s3][:target_user]</tt></td>
    <td>String</td>
    <td>AWS access ID</td>
    <td><tt>"AWS access ID"</tt></td>
  </tr>
  
  <tr>
    <td><tt>[:duply][:s3][:target_pass]</tt></td>
    <td>String</td>
    <td>AWS access key</td>
    <td><tt>"AWS access key"</tt></td>
  </tr>
  
  <tr>
    <td><tt>[:duply][:s3][:source]</tt></td>
    <td>String</td>
    <td>Base directory to backup</td>
    <td><tt>"/"</tt></td>
  </tr>

  <tr>
    <td><tt>[:duply][:s3][:includes]</tt></td>
    <td>List</td>
    <td>List directories to backup inside base</td>
    <td><tt>["root", "home"]</tt></td>
  </tr>
    
  <tr>
    <td><tt>[:duply][:day]</tt></td>
    <td>String</td>
    <td>Backup frequency, * means daily</td>
    <td><tt>"*"</tt></td>
  </tr>
  <tr>
    <td><tt>[:duply][:hour]</tt></td>
    <td>String</td>
    <td>Backup time</td>
    <td><tt>"4"</tt></td>
  </tr>

  <tr>
    <td><tt>[:duply][:minuter]</tt></td>
    <td>String</td>
    <td>Backup minute</td>
    <td><tt>"0"</tt></td>
  </tr>
</table>

Usage
-----
#### duply::default


Create your bucket from S3 and Config the attribute :
default[:duply][:s3][:target] 

Get your Access key ID and secret access key from [ IAM console.](https://console.aws.amazon.com/iam/home?#home) and config the attributes:

**default[:duply][:s3][:target_user]**  and
**default[:duply][:s3][:target_pass]**

You might need to attach user policy to your access ID, for test purpose, you can assign *Amazon S3 Full Access policy* , e.g.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
```

Furthermore, you may want to config: 
**default[:duply][:s3][:source]** and **default[:duply][:s3][:includes]** to specify the base directory and sub-folders inside to be included when backup.


Finally, include `duply` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[duply]"
  ]
}
```
