##################################################
# Variables
#
date       := `date +"%Y-%m-%d %T"`
commit-msg := "clean commits"
branch     := "main"

# List all commands
@default:
  just --list


# clean commit history and only keep latest commit
clean-commits:
  echo "--------------------------------------------------"
  echo "-- Cleanup commit history: {{date}}"
  git checkout --orphan latest_branch       # create new branch
  git add .                                 # add all files
  git commit -m "{{date}} - {{commit-msg}}" # commit the changes
  git branch -D {{branch}}                  # delete the branch
  git branch -m {{branch}}                  # rename current branch
  git push -f origin {{branch}}           # force repo update
