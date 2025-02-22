Prerequisites:
- A Microsoft Azure account
- Installed Azure CLI
- Installed Terraform

Steps
Login into the Azure account using Azure Cli:
az login

Create a new service principal to grant permissions for managing Azure resources:

`
az ad sp create-for-rbac --name SomeName --role owner --scopes /subscriptions/<your-subscriptions>
`

Save the output, which looks like this:



    "appId": "<appId>",
    "displayName": "<display_name>",
    "password": "<password>",
    "tenant": "<tenant>"



Task 1:
Clone the repository. Go to the Task 1 folder and initialize and run Terraform locally.

Task 2:
Download the Power BI dashboard for checking.

Task 3:
Create an Azure DevOps Project.
Sign in to Azure DevOps: Go to Azure DevOps and sign in with your credentials.
Create a New Project: Click on “New Project,” provide a name for your project and click on "Create".

Create Pipelines:
Navigate to Pipelines > Pipelines and click on "New Pipeline".
Using YAML files in folder `task3/.azuredevops` create new pipelines

Create a new variables group:
Using service principal details add variables into a group named `terraform-azure-devops`

Run pipelines:
Create infrastructure and deploy the application. 
