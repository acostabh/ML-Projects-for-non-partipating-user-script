# Export Projects based on a non-participating user - Sample Shell Script - Mac/Linux Version #

This shell script bundle (Mac/Linux) uses the Mavenlink API endpoints to:

  1. Find a Mavenlink account user based on their email address
  2. Export a list of Projects based on a non-participating user onto a CSV file (ML_Archived_Projects_[user ID].csv)
      - Active projects in which the user is not a participant.

Disclaimer: These scripts are provided as sample code and they are NOT official Mavenlink tools, they have been generated as part of an exercise to investigate the use of Mavenlink's API based on specific scenarios. The developer accepts no liability for any issues that could arise from using these scripts.

## Pre-Requisites ##

  1. Make the shell scripts executable
      - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-Projects-for-non-partipating-user-script)
      - Run this code (inside that folder only): chmod +x *.sh
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
  3. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - run the setup script: ./setup.sh (follow the prompts)
  4. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Running the Script ##

  1. open terminal
  2. Navigate to the folder where you saved the scripts
      - E.G: cd ~/Documents/ML-Projects-for-non-partipating-user-script
  3. Run the script: ./get_exception.sh
  4. Follow the instructions on the prompt
  5. The CSV export file will be created in the same folder as the script. (E.G: cd ~/Documents/ML-Projects-for-non-partipating-user-script/ML_Archived_Projects_[user ID].csv)
