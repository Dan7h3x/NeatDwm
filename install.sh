#!/bin/bash

# Function to display a message box
show_message() {
  dialog --title "$1" --msgbox "$2" 0 0
}

# Function to display a yes/no dialog
ask_yes_no() {
  dialog --title "$1" --yesno "$2" 0 0
  return $?
}

# Function to display an input box
get_input() {
  dialog --title "$1" --inputbox "$2" 0 0 2>&1 >/dev/tty
}

# Function to display a menu
show_menu() {
  dialog --title "$1" --menu "$2" 0 0 0 "${@:3}" 2>&1 >/dev/tty
}

# Function to display a progress bar
show_progress() {
  (
    for i in {1..100}; do
      echo $i
      sleep 0.05
    done
  ) | dialog --title "$1" --gauge "$2" 0 0 0
}

# Main installer function
install_software() {
  show_message "Welcome" "Welcome to the Installer!\n\nThis script will guide you through the installation process."

  # Ask the user if they want to proceed
  if ! ask_yes_no "Confirmation" "Do you want to proceed with the installation?"; then
    show_message "Installation Cancelled" "The installation has been cancelled."
    exit 0
  fi

  # Get user input for installation directory
  install_dir=$(get_input "Installation Directory" "Please enter the directory where you want to install the software:")

  # Validate the installation directory
  if [ -z "$install_dir" ]; then
    show_message "Error" "Installation directory cannot be empty."
    exit 1
  fi

  # Ask the user to select a package to install
  package=$(show_menu "Select Package" "Please select a package to install:" \
    1 "Package A" \
    2 "Package B" \
    3 "Package C")

  # Validate the selected package
  if [ -z "$package" ]; then
    show_message "Error" "No package selected."
    exit 1
  fi

  # Simulate the installation process
  show_progress "Installing" "Installing package $package..."

  # Display a success message
  show_message "Installation Complete" "The installation of package $package has been completed successfully."
}

# Run the installer
install_software
