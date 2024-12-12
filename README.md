
# Migrate All GitLab Repositories to GitHub

This script automates the migration of repositories from a GitLab group or project to a GitHub organization. It uses the GitLab API and GitHub CLI (`gh`) to fetch, clone, and push repositories, ensuring a smooth transition.

## Features

-   Fetch all repositories in a specified GitLab group or project.
-   Clone each repository locally.
-   Create corresponding repositories in the GitHub organization.
-   Push all branches and commits to the new GitHub repositories.
-   Skip repositories that already exist in the GitHub organization.

## Requirements

1.  **GitLab Personal Access Token**:
    
    -   Generate a token with API access from your GitLab account.
    -   [Guide to create a GitLab Personal Access Token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html).
2.  **GitHub CLI (`gh`)**:
    
    -   Install the GitHub CLI and authenticate it with your account.
    -   [Guide to install and authenticate `gh`](https://cli.github.com/manual/).
3.  **Dependencies**:
    
    -   `bash`
    -   `git`
    -   `curl`
    -   `jq`
4.  **Permissions**:
    
    -   Ensure your GitHub account has the necessary permissions to create repositories in the target organization.

## Usage

1.  **Clone the script**: Save the script as `migrate.sh`.
    
2.  **Update configuration variables**: Open the script and update the following variables with your details:
    
    bash
    
    Copy code
    
    `GITLAB_TOKEN="glpat-1234"    # Your GitLab personal access token
    GITLAB_GROUP_ID="1234"       # The GitLab group or project ID
    GITHUB_ORG="My-New-Account"  # Your GitHub organization name` 
    
3.  **Make the script executable**:
    
    bash
    
    Copy code
    
    `chmod +x migrate.sh` 
    
4.  **Run the script**:
    
    bash
    
    Copy code
    
    `./migrate.sh` 
    
5.  **View results**:
    
    -   The script will output the migration status for each repository.
    -   Existing repositories in GitHub will be skipped automatically.

## Example

If your GitLab group ID is `5678`, GitLab token is `glpat-abcdef12345`, and your GitHub organization is `MyOrganization`, update the variables like this:

bash

Copy code

`GITLAB_TOKEN="glpat-abcdef12345"
GITLAB_GROUP_ID="5678"
GITHUB_ORG="MyOrganization"` 

Run the script:

bash

Copy code

`./migrate.sh` 

## Notes

-   The script clones repositories temporarily and removes local copies after pushing to GitHub.
-   All created repositories on GitHub are private by default.
-   Ensure `gh` is logged in and has access to the target GitHub organization.

## Troubleshooting

-   **No repositories found**: Check your `GITLAB_TOKEN` and `GITLAB_GROUP_ID`.
-   **Permission errors**: Ensure the GitHub CLI (`gh`) is authenticated and has access to the organization.
-   **Dependencies missing**: Ensure `curl`, `jq`, and `git` are installed and accessible.

## License

This script is open source and available under the MIT License. Feel free to modify and use it for your migration needs!