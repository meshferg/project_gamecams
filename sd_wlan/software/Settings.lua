-- Test settings --
test_image          = "/I__00001.JPG"
test_target_dir     = "/DCIM/400CUDDY/LOC__001"
test_log_file       = "/TestPut.log"
-- FTP Settings --
log_file            = "/FTPLog.txt"                -- Where to log output on the FA
folder              = "/DCIM/400CUDDY"             -- What folder to upload files from
extension           = ".JPG"                       -- Filename suffixes to include in upload
server              = <numeric ip address>         -- The FTP server's IP
serverPicDir        = "pic_intake"                 -- The path on the FTP server to use, relative to anonymous' default dir.
serverSTSDir        = "sts"                        -- FTP sub directory to hold Cudde STS files
user                = "anonymous"                  -- FTP username
passwd              = <password>                   -- FTP password
delete_after_upload = true                         -- Delete the files from SD card after upload
