# Common Module

This modules is responsible for deploying the common stuff required for the reference archicture for Terraform on Azure and we will use the below reference module to re-use.
The module is developed in its own repository [here](https://github.com/jcorioland/terraform-azure-ref-common-module).

**SSH configuration**
To resolve the SSH authentication issue with WSL from window machine, please follow the below steps, if not you can skip this part. 

Fork the project to update to latest...
If you are using a windows machine, Visual studio code and with WSL terminal then here are the steps to authenticate the forked project. 
cd ~/.ssh/
ssh-keygen -t rsa -b 4096 -C "test@email.com"
It ask for the file or key name (for example sh-keygen-terraform-common-module)

chmod 600 ~/.ssh/ssh-keygen-terraform-common-module
eval "$(ssh-agent -s)"  # Start the agent if not running
ssh-add ~/.ssh/ssh-keygen-terraform-common-module  # Add the key to the agent

Here's a detailed explanation of the steps involved in adding your public SSH key to your GitHub account:

**1. Accessing Your Public Key:**

  - Open a terminal window on your machine or VS code WSl terminal.
  - Navigate to the directory containing your SSH keys using the `cd` command. By default, SSH keys are stored in the hidden `.ssh` directory within your home directory. Here's how to access it:

     ```bash
     cd ~/.ssh  # Replace `~` with your actual home directory path if different
     ```

  - You might need to enable viewing hidden files in your file manager to see the `.ssh` directory.

  - Once in the `.ssh` directory, use the `cat` command to display the contents of the public key file. In your case, it's likely named `ssh-keygen-terraform-common-module.pub`:

     ```bash
     cat ssh-keygen-terraform-common-module.pub
     ```
  - This command will display the entire public key content in the terminal window. Copy the entire text (everything from `ssh-rsa` to the end of the string).

**2. Adding the Key to GitHub:**

  - Log in to your GitHub account using a web browser.
  - Navigate to your profile settings by clicking on your profile picture in the top right corner and selecting "Settings".
  - In the settings menu, locate the "SSH and GPG keys" section. You might need to click on "Security" first to see this section.
  - Click the "New SSH key" button.
  - Provide a descriptive title for your key (e.g., "Terraform for [Your Project Name]").
  - In the "Key" field, paste the entire public key content you copied earlier from the terminal.

**3. Saving the Key:**
 - Once you've entered the title and pasted the public key content, click the "Add SSH key" button to save it to your GitHub account.

Then come back to this module folder
cd PATH_TO_THIS_COMMON_MODULE to run terraform init


# Usage

Fill environment variables and run script:

```bash
export TF_VAR_location="westeurope"
export TF_VAR_tenant_id="<YOUR_TENANT_ID>"

# init terraform and backend storage
./init.sh

terraform apply -auto-approve
```