# delete all users that have 
# 1 occurence in the file
/^[ \t]*1/d

# removes whitespace
s/^[ \t]*2//g
s/*//g
s/^[ \t]*//g

