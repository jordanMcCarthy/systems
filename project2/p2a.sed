# delete table header
1 d

# delete all users who have logged into 
# server in 2017
/2017$/d

# isolate users IDsls
s/\*\*Never logged in\*\*//g
s/pts\/.*//g

# remove whitespace
s/\(^\S*\)/\1/g
s/*//g
s/ *$//g
