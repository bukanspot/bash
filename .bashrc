# Set a default theme if none is set
theme=${theme:-default}

# Get the directory of the .bashrc file
dir=$(dirname "$BASH_SOURCE")

# Read the settings.cfg file line by line
while IFS='=' read -r key value
do
  # If the line starts with a '#', ignore it
  if [[ $key =~ ^#.* ]]; then
    continue
  fi

  # Remove the spaces from the key
  key=$(echo $key | tr -d ' ')

  # Extract the value between the quotes
  value=$(echo $value | tr -d ' ' | sed -e 's/^"//' -e 's/"$//')

  # Check if the key is a valid identifier and if both key and value are not empty
  if [[ $key =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] && [[ -n $key ]] && [[ -n $value ]]; then
    # Declare a variable with the name of the key and assign the value to it
    declare "$key=$value"
  fi
done < "$dir/settings.cfg"

# Set theme for the terminal
source ~/.sbash/themes/$theme.sh

# Loop over all files in the directory
for file in ~/.sbash/lib/*
do
    # Check if the file is a regular file and source it
    if [ -f "$file" ]; then
        source "$file"
    fi
done