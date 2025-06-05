#!/bin/bash

echo "This script will help you set up the required GitHub secrets for the CI/CD pipeline."
echo "Please make sure you have the GitHub CLI (gh) installed and are authenticated."
echo

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first:"
    echo "https://cli.github.com/"
    exit 1
fi

# Check if logged in
if ! gh auth status &> /dev/null; then
    echo "Please login to GitHub first:"
    echo "gh auth login"
    exit 1
fi

# Get the repository name
REPO=$(git config --get remote.origin.url | sed 's/.*github.com[:\/]\(.*\).git/\1/')

echo "Setting up secrets for repository: $REPO"
echo

# Docker Hub Token
echo "Please enter your Docker Hub access token:"
read -s DOCKERHUB_TOKEN
echo

# Set Docker Hub Token
echo "Setting DOCKERHUB_TOKEN..."
gh secret set DOCKERHUB_TOKEN --body="$DOCKERHUB_TOKEN"

# EC2 SSH Key
echo
echo "Please enter your EC2 SSH private key (paste the content and press Ctrl+D when done):"
EC2_SSH_KEY=$(cat)

# Set EC2 SSH Key
echo "Setting EC2_SSH_KEY..."
gh secret set EC2_SSH_KEY --body="$EC2_SSH_KEY"

echo
echo "Secrets have been set successfully!"
echo
echo "Required secrets:"
echo "✓ DOCKERHUB_TOKEN"
echo "✓ EC2_SSH_KEY"
echo
echo "You can now push your code to trigger the workflow!" 