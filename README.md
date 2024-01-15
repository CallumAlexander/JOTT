# Jargon of the Terminal (JOTT)

Author : _Callum Alexander_ (TheCatThatBarks)

Name credits mainly but not completely : _Callum Groeger_ (groegercesg)

## What is JOTT?

Jargon of the Terminal (JOTT) is a command-line program that displays random glossary terms and their corresponding definitions sourced from [The Jargon File](http://www.catb.org/jargon/html/online-preface.html).

## Installation

To install JOTT, follow these simple steps:

1. **Clone the Repository:**

   Open your terminal and navigate to the directory where you want to install JOTT. Then, use the following command to clone the repository:

   ```bash
   git clone https://github.com/CallumAlexander/JOTT.git
   ```

2. **Navigate to the Repository Directory:**

   Change your current directory to the newly cloned repository:

   ```bash
   cd JOTT
   ```

3. **Run the Makefile:**

   To build and install JOTT, you just need to run the included Makefile. Use the following command:

   ```bash
   make
   ```

   This command will copy the program and its config file to the relevant directories, and sure that the program is in PATH.

## Usage

   To use the program, simply run:

   ```bash
   jott
   ```
   
   in any terminal emulator.

   - Program settings can be changed in the accompanying `jott.cfg` file located in `~/.config/jott` after the Makefile installation process.


### To-do list of things to do
- [x] Make file and include `curl` dependency check 
- [ ] Fix the text formatting/colour interference
- [ ] Argument to query a specific term
- [x] Install instructions on README.md
- [ ] Option for `n` number of random definition requests
- [ ] Punctuation and Grammar inclusion if applicable for the term
- [x] Handling when the source is down
- [x] Exclude subdirectories in the random search
- [x] Specify the request timeout - default is 2 seconds currently
- [x] Fix handling and removal of `<i>` tags
   - I think? I've not done rigorous tests for it
- [x] Fix handling and removal of `<span>` tags
- [x] Fix the newline problem
- [x] strip spaces at the start and end of string
- [ ] Ability to click and follow redirects and links
- [ ] Install script/command that adds it to your MOTD or terminal rc file
- [ ] Handle bold tags like this command class: `<b class="command">Unable to kill all processes.  Blast them (y/n)?</b>`
- [x] Handle italic tags like this: `<em>which</em>`
- [x] Handle italic tags like this: `<i class="citetitle">A Stress Analysis Of A Strapless Evening
   Gown: And Other Essays For A Scientific Eye</i>`
- [x] Have the JOTT logo as ASCII art
- [x] create a timeout in seconds variable in config file
- [x] Implement limited column width for definition
- [x] Implement no-header variable for config file
- [ ] Implement indented definition
- [x] Underline other glossary terms
- [x] Figure out why `make uninstall` doesn't install the script
- [ ] Handle `tt` tags

---
ASCII Art credits: textkool.com

