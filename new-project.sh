#!/bin/bash

TEMPLATES_DIR="./templates"


if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "Templates directory not found: $TEMPLATES_DIR" >&2
  exit 1
fi

# echo -e "\n----------------- TEMPLATES -----------------\n"
# echo -e "\033[1;34m\n----------------- TEMPLATES -----------------\n\033[0m"
# echo -e "\033[1;7m\n----------------- TEMPLATES -----------------\n\033[0m"
echo -e "\033[1;7m\n.                 TEMPLATES                  \n\033[0m"

DIRS=()
COUNT=0
for dir in "$TEMPLATES_DIR"/*; do
    [ -f "$dir/meta.yaml" ] || continue

    name=$(grep -E "^name:" "$dir/meta.yaml" | sed -E 's/^name:[[:space:]]*//')
    version=$(grep -E "^version:" "$dir/meta.yaml" | sed -E 's/^version:[[:space:]]*//')
    description=$(grep -E "^description:" "$dir/meta.yaml" | sed -E 's/^description:[[:space:]]*//')

    echo -e "\033[1;32m[${COUNT}]\033[0m \033[1m${name} (${version})\033[0m: ${description}"
    DIRS+=("$dir")
    COUNT=$((COUNT + 1))
done

echo ""
# read -r -p "Select a template [0-$((COUNT-1))]: " CHOICE
# read -r -p $'\033[1;34mSelect a template [0-$((COUNT-1))]: \033[0m' CHOICE
read -r -p $'\033[1;34mSelect a template [0-'"$((COUNT-1))"$']: \033[0m' CHOICE
if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 0 ] || [ "$CHOICE" -ge "$COUNT" ]; then
  echo "Invalid selection." >&2
  exit 1
fi


# echo -e "\n------------------- SETUP -------------------\n"
# echo -e "\033[1;34m\n------------------- SETUP -------------------\n\033[0m"
# echo -e "\033[1;7m\n------------------- SETUP -------------------\n\033[0m"
echo -e "\033[1;7m\n                    SETUP                    \n\033[0m"

while :; do
  #read -r -p "Project parent folder: " PROJECT_PARENT_DIR
  read -r -p $'\033[1;34mProject parent folder: \033[0m' PROJECT_PARENT_DIR
  [ -n "$PROJECT_PARENT_DIR" ] && [ -d "$PROJECT_PARENT_DIR" ] && break
  echo "Invalid path. Please enter an existing folder."
done

while :; do
    # read -r -p "Enter project name: " PROJECT_NAME
    read -r -p $'\033[1;34mEnter project name: \033[0m' PROJECT_NAME
    [ -n "$PROJECT_NAME" ] && [ ! -d "$PROJECT_PARENT_DIR/$PROJECT_NAME" ] && break
    echo "Invalid name. Folder already exists or name is empty."
done


# echo -e "\n------------------ SUMMARY ------------------\n"
# echo -e "\033[1;34m\n------------------ SUMMARY ------------------\n\033[0m"
# echo -e "\033[1;7m\n------------------ SUMMARY ------------------\n\033[0m"
echo -e "\033[1;7m\n                   SUMMARY                   \n\033[0m"

echo -e "\033[1;32mTemplate\033[0m\t${DIRS[$CHOICE]}"
echo -e "\033[1;32mParent folder\033[0m\t$PROJECT_PARENT_DIR"
echo -e "\033[1;32mProject name\033[0m\t$PROJECT_NAME\n"
# read -r -p "Is this correct? [y/N]: " CONFIRM
read -r -p $'\033[1;34mIs this correct? [y/N]: \033[0m' CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Aborting." >&2
  exit 1
fi

echo -e "\033[1;7m\n                INSTALLATION                 \n\033[0m"
echo -en "Creating project directory... "
echo -e "\033[1;32mdone\033[0m"
echo -en "Copying template files... "
echo -e "\033[1;32mdone\033[0m"