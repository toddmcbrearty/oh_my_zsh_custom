# README

## Overview

This project contains custom configurations, functions, aliases, and autocompletes designed to extend the functionality
of the `oh-my-zsh` shell. The directory structure primarily supports custom scripts, aliases, and functions for
optimized terminal usage.

---

## Project Structure

### **Functions**

1. **`functions/to`**  
   Custom function related to a likely navigation utility. This script may serve as a tool for quick navigation between
   directories.

2. **`functions/push_custom_zsh`**  
   A function possibly used for managing or pushing custom `.zsh` configurations to a repository or another environment.

### **Aliases**

1. **`aliases/git`**  
   A collection of custom `git` command aliases to simplify or shorten common Git operations.

2. **`aliases/catch_all`**  
   A set of general-purpose aliases that catch a variety of terminal commands and streamline their usage.

3. **`aliases/ssh`**  
   Custom shortcuts for managing SSH connections, such as quick access to remote servers.

4. **`aliases/local`**  
   Aliases optimized for local development or operations.

### **Autocompletes**

1. **`autocompletes/_to`**  
   Related to the `to` command/function, this file likely enhances its functionality with autocompletion capabilities.

### **Metadata**

1. **`loader.zsh`**  
   Acts as a central script to load all custom functions, aliases, and autocompletes. This file ensures the entire
   configuration is correctly sourced when the shell starts.

---

## Getting Started

1. Clone the `.oh-my-zsh` configuration or add these files manually to your custom folder:
   ```bash
   git clone https://github.com/toddmcbrearty/oh_my_zsh_custom ~/.oh-my-zsh/custom
   ```
