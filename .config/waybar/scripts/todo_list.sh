#!/bin/bash

# Path to the to-do list file
TODO_FILE="$HOME/.config/waybar/todo.txt"

# Function to display the to-do list
display_todo() {
  if [ -f "$TODO_FILE" ]; then
    list=$(cat "$TODO_FILE")
    count=$(wc -l <"$TODO_FILE")
    echo "{\"text\": \"󰄱 $count\", \"tooltip\": \"To-Do List:\\n$list\"}"
  else
    echo "{\"text\": \"󰄲\", \"tooltip\": \"No tasks\"}"
  fi
}

# Function to add a task
add_task() {
  task=$(zenity --entry --title="Add Task" --text="Enter a new task:")
  if [ -n "$task" ]; then
    echo "[ ] $task" >>"$TODO_FILE"
  fi
  display_todo
}

# Function to mark a task as complete
complete_task() {
  if [ -f "$TODO_FILE" ]; then
    task=$(zenity --list --title="Complete Task" --column="Tasks" $(cat "$TODO_FILE"))
    if [ -n "$task" ]; then
      sed -i "/^\[ \] $task$/s/^\[ \]/[✓]/" "$TODO_FILE"
    fi
  fi
  display_todo
}

# Main script logic
case "$1" in
"add") add_task ;;
"complete") complete_task ;;
*) display_todo ;;
esac
