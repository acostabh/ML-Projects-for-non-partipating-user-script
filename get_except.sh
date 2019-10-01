#!/bin/sh
#get email address from prompt (if not sent from commandline)
if [ x$1 == "x" ]; then
 echo "#########  Email address not provided ########"
 echo ""
 echo "Options:"
 echo ""
 echo "1. Enter the user's email address below"
 echo "2. Cancel (press Ctrl+c)"
 read user_email
else
  user_email=$1
fi
#fail if prompt field is empty (submission check)
if  [ x$user_email == "x" ]; then
  echo ""
  echo "Email address not provided. Script ended."
  echo ""
else
  #search for user
  token=$(jq -r ".token" token.json)
  users=$(curl -s -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/users?on_my_account=true&by_email_address='$user_email)
  user_count=$(jq -n "$users" | jq -r '.count')
  if [ $user_count == 0 ]; then
    echo ""
    echo "No user found!"
    echo ""
  else
    echo ""
    id=$(jq -n "$users" | jq -r '.results[0].id')
    echo "[" $id "] "$(jq -n "$users" | jq -r '.users["'$id'"].full_name')" "$(jq -n "$users" | jq -r '.users["'$id'"].email_address')" "$(jq -n "$users" | jq -r '.users["'$id'"].headline')
    echo ""
    #get Count of projects wihout user above
    project=$(curl -s -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/workspaces?user_not_participating='$id'&per_page=1&page=1')
    project_count=$(jq -n "$project" | jq -r '.count')
    echo "User ID:  "$id
    echo "Projects: "$project_count "(without the user's participation)"
    echo ""
    #Confirm before searching for projects without the selected user
    echo "Export $project_count Projects to CSV?"
    echo ""
    echo "1. Type Y or N (default: N)"
    echo "2. Cancel (press Ctrl+c)"
    read response
    do_csv=$(echo "$response" | tr '[:lower:]' '[:upper:]')
    #export to CSV check and process
    if [  $do_csv == "Y" ]; then
      max_pages=200 #maximum number of results per page (200 is the limit set by Mavenlink)
      project=$(curl -s -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/workspaces?user_not_participating='$id'&per_page='$max_pages'&page=1')
      project_count=$(jq -n "$project" | jq -r '.count')
      page_count=$(jq -n "$project" | jq -r '.meta.page_count')

      echo ""
      echo "Choice: $do_csv - Writting file ML_Projects_except_$id.CSV"
      #write CSV header
      echo "project_id,project_name" > ML_Projects_except_$id.csv
      #if number of pages > than 1, iterate through
      for (( i=1; i < $((page_count+1)); ++i ))
        do
          if [ $i != 1 ]; then
            project=$(curl -s -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/workspaces?user_not_participating='$id'&per_page='$max_pages'&page='$i)
            project_count=$(jq -n "$project" | jq -r '.count')
          fi
          #iterate the users list per page
          for (( j=0; j < $project_count; ++j ))
            do
              project_id=$(jq -n "$project" | jq -r '.results['$j'].id')
              if [ $project_id != null ]; then
                #append CSV user data by line
                echo $project_id',"'$(jq -n "$project" | jq -r '.workspaces["'$project_id'"].title')'"' >> ML_Projects_except_$id.csv
              fi
            done #end users list iteration
          done #ends page iteration

        echo "Complete!"
    else
        echo ""
        echo "Choice: N (Don't export). Script ended."
    fi


  fi  #end user search
fi  #end submission check
