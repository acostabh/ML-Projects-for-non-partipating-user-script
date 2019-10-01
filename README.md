# Un-archive Project & invite members - Sample Shell Script - Mac/Linux Version #

This shell script bundle (Mac/Linux) uses various Mavenlink API endpoints to:

  1. Get a list of archived Projects onto a CSV file (ML_Archived_Projects.csv)
  2. Get a list of account users onto a CSV files (users.csv)
  3. Bulk un-archive Projects
  4. Bulk invite account members to the newly un-archived projects

Disclaimer: These scripts are provided as sample code and they are NOT official Mavenlink tools, they have been generated as part of an exercise to investigate the use of Mavenlink's API based on specific scenarios. The developer accepts no liability for any issues that could arise from using these scripts.

## Pre-Requisites ##

  1. Make the shell scripts executable
      - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-Unarchive-Projects-add-new-member-sample-script)
      - Run this code (inside that folder only): chmod +x *.sh
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
  3. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - run the setup script: ./setup.sh (follow the prompts)
  4. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Data prep ##

  1. open terminal
  2. Navigate to the folder where you saved the scripts
    - E.G: cd ~/Documents/ML-Unarchive-Projects-add-new-member-sample-script
  3. Run the script: ./get_projects.sh w and ./get_users.sh w
    - this step will write out the ML_Archived_Projects.csv and users.csv files into the folder above
  4. Follow the instructions on the prompt (if any)
  5. Use the file users.csv to update the ML_Archived_Projects.csv file.
      - Delete from ML_Archived_Projects.csv any project that you DON'T want to un-archive
      - Add the respective user IDs to the column "user_id" on ML_Archived_Projects.csv. You can add multiple IDs to this field, but they must each be separated by a / without spaces.
      - test the script with a small set of data to ensure everything is correct
      - you can see the results on a dated log file in the same folder as the script

## Un-archiving the Projects ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-Unarchive-Projects-add-new-member-sample-script
  3. Run the script: ./bulk_unarchive.sh
      - this script uses the ML_Archived_Projects.csv file to select the Project ID to un-rchive. Please ensure the file and script are in the same folder.
  4. Go to the Mavelink web interface and confirm that the Projects are now indeed un-archived
  5. View results/response on log file in the same folder as the script (yyy-mm-dd_log.txt)

## Inviting Account Members to Projects ##
This step can be easily done via the Web Interface instead, but it's been added here as part of the proof of concept for this scenario.

  1. Open terminal
  2. Navigate to the folder where you saved the script
      - E.G: cd ~/Documents/ML-Unarchive-Projects-add-new-member-sample-script
  3. Run the script: ./bulk_invite.sh
      - this script uses the ML_Archived_Projects.csv file to select the Project ID and User ID to proceed. Please ensure the file and script are in the same folder.
  4. Go to the Mavelink web interface and confirm that the account members have been added to the Projects.
      - Note that all members will be added with the default permissions of "Edit" and "Can Invite".
  5. View results/response on log file in the same folder as the script (yyy-mm-dd_log.txt)
