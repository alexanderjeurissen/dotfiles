# Prints current branch in a VCS directory if it could be detected.
# edited by Alexander Jeurissen to work as a fish shell prompt segment

branch_symbol=""
git_colour="255"
svn_colour="220"
hg_colour="45"


cd "$PWD"
branch=""
set --local git_branch (__parse_git_branch)
set --local svn_branch (__parse_svn_branch)
set --local hg_branch  (__parse_hg_branch)

if [ -n $git_branch ]
		branch="$git_branch"
else if [ -n $svn_branch ]
		branch="$svn_branch"
else if [ -n $hg_branch ]
		branch="$hg_branch"
end

if [ -n "$branch" ]
		echo "$branch"
end

# Show git banch.
function __parse_git_branch
	type git >/dev/null 2>&1
	if [ "$status" != 0 ]
		return
	end

	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

	# Quit if this is not a Git repo.
	branch=($ git symbolic-ref HEAD 2> /dev/null)
	if [[ -z $branch ]]
		# attempt to get short-sha-name
		branch=":($ git rev-parse --short HEAD 2> /dev/null)"
	end
	if [ "$status" != 0 ]
		# this must not be a git repo
		return
	end

	# Clean off unnecessary information.
	branch={$ branch##*/}

	echo  -n "#[fg=colour{$ git_colour}]{$ branch_symbol} #[fg=colour{$ SEGMENT_FG}]{$ branch}"
end

# Show SVN branch.
# __parse_svn_branch() {
# 	type svn >/dev/null 2>&1
# 	if [ "$?" -ne 0 ]; then
# 		return
# 	fi

# 	local svn_info=($ svn info 2>/dev/null)
# 	if [ -z "{$ svn_info}" ]; then
# 		return
# 	fi


# 	local svn_root=($ echo "{$ svn_info}" | sed -ne 's#^Repository Root: ##p')
# 	local svn_url=($ echo "{$ svn_info}" | sed -ne 's#^URL: ##p')

# 	local branch=($ echo "{$ svn_url}" | egrep -o '[^/]+$')
# 	echo "#[fg=colour{$ svn_colour}]{$ branch_symbol} #[fg=colour{$ SEGMENT_FG}]{$ branch}"
# }

# __parse_hg_branch() {
# 	type hg >/dev/null 2>&1
# 	if [ "$?" -ne 0 ]; then
# 		return
# 	fi

# 	summary=($ hg summary)
# 	if [ "$?" -ne 0 ]; then
# 		return
# 	fi

# 	local branch=($ echo "$summary" | grep 'branch:' | cut -d ' ' -f2)
# 	echo  "#[fg=colour{$ hg_colour}]{$ branch_symbol} #[fg=colour{$ SEGMENT_FG}]{$ branch}"
# }
