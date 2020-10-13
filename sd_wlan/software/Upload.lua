-- Import settings file
require("Settings")

-- Set the FTP connection string
local ftpstring = "ftp://"..user..":"..passwd.."@"..server .. "/"
-- local ftpstring = "ftp://"..user..":"..passwd.."@"..server
print("FTP: " .. ftpstring)

-- Date / time
now = os.time()
print("Now: " .. now)

-- Recursively iterate through directories
function walk_directory(folder)
	for file in lfs.dir(folder) do
		-- Not sure if this is necessary, but it keeps 'LUA : not enough memory' out of the log
		collectgarbage()

		-- Find file path and type
		local path = folder .. "/" .. file
		local attr = lfs.attributes(path)
		if attr.mode == "file" then
			handle_file(path, file)
		elseif attr.mode == "directory" then
			print("Found directory: " .. path)
			if string.match(path, "STATUS") then
				print(" - Found Status directory. Skipping.")
			else
				walk_directory(path)
			end
		end
	end
end

-- Check file for upload, upload.
function handle_file(path, file)
	print("Found file: Path: " .. path .. " File: " .. file)
	
	if string.upper(string.sub(file, -4, -1)) ~= extension then
		print(" - File not JPEG. Skipping.")
		return
	end
	
	-- Capture subdirectory name with ( )
	subdir = string.match(path, "/(LOC__%d%d%d)/")
	
	prefix = string.sub(file, 1, 3)
	if prefix == "T__" then
		tmp_ftp_str = ftpstring .. serverPicDir .. "/" .. subdir .. "-" .. file
	elseif prefix == "STS" then
		tmp_ftp_str = ftpstring .. serverSTSDir .. "/" .. subdir .. "-" .. file
	else
		print(" - Not Cuddeback image. Skipping.")
		return
	end
	
	print(" - FTP: " .. tmp_ftp_str)
    response = fa.ftp("put", tmp_ftp_str, path)
    if response ~= nil then
		print(" - SUCCESS: FTP put: " .. file .. " Deleting.")
		fa.remove(path)
    else
		print(" - FAIL: FTP put: " .. file .. " Keeping.")
    end
end

walk_directory(folder)

