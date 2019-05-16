# delete table header
1 d

# delete all users who have logged into
# server in 2017
/2017$/d

# isolate user IDs
s/\*\*Never logged in\*\*//g
s/pts\/.*//g

# remove whitespace and add $ to end of user IDs
s/\(^\S*\)/\1$/g
s/*//g
s/ *$//g
