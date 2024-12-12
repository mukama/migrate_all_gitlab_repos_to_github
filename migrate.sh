#!/bin/bash

# Configuration variables
GITLAB_TOKEN="glpat-1234"    # Your GitLab personal access token
GITLAB_GROUP_ID="1234"       # The GitLab group or project ID
GITHUB_ORG="My-New-Account"  # Your GitHub organization name

# GitLab API URL
GITLAB_API_URL="https://gitlab.com/api/v4/groups/${GITLAB_GROUP_ID}/projects"

# Fetch repositories from GitLab
echo "Fetching repositories from GitLab..."

# Get all repositories in the specified GitLab group or project
repos=$(curl -s --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "$GITLAB_API_URL" | jq -r ".[] | .ssh_url_to_repo")

if [ -z "$repos" ]; then
  echo "No repositories found or error fetching repositories."
  exit 1
fi

# Clone each repository, change remote, and push to GitHub
for repo in $repos; do
  repo_name=$(basename "$repo" .git)
  
  # Check if the GitHub repository already exists
  echo "Checking if GitHub repository $GITHUB_ORG/$repo_name exists..."
  gh repo view "$GITHUB_ORG/$repo_name" &>/dev/null

  if [ $? -eq 0 ]; then
    # If the repository exists on GitHub, skip it
    echo "Repository $GITHUB_ORG/$repo_name already exists on GitHub. Skipping..."
    continue
  fi

  echo "Processing $repo..."
  
  # Clone the GitLab repository
  git clone "$repo"
  cd "$repo_name" || continue  # Enter the cloned repo directory

  # Create the corresponding GitHub repository (private)
  echo "Creating GitHub repository $GITHUB_ORG/$repo_name..."
  gh repo create "$GITHUB_ORG/$repo_name" --private --confirm

  # Change the remote URL to GitHub
  git remote set-url origin "git@github.com:$GITHUB_ORG/$repo_name.git"

  # Push the code to GitHub
  echo "Pushing to GitHub repository $GITHUB_ORG/$repo_name..."
  git push --all origin
  
  # Go back to the original directory
  cd ..

  # Clean up the local clone
  rm -rf "$repo_name"
done

echo "All repositories have been processed. Skipped existing ones."
