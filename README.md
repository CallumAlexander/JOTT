# Jargon of the Terminal (JOTT)

Author : _Callum Alexander_ (TheCatThatBarks)

Name credits mainly but not completely : _Callum Groeger_ (groegercesg)

## What is JOTT?

Jargon of the Terminal (JOTT) is a command-line program that displays random glossary terms and their corresponding definitions sourced from [The Jargon File](http://www.catb.org/jargon/html/online-preface.html), amongst other interfaced features.

## What is The Jargon File?

As taken from the source, The Jargon File is "_a comprehensive compendium of hacker slang illuminating many aspects of hackish tradition, folklore, and humor._"

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

Dependencies required by JOTT are as follows:
```
git awk curl timeout sed grep tr fold
```
You can check your dependencies by using the following command `make check_dependencies` after completing points 1 and 2 in the installation process above. 

## Usage

### Basic usage 

   To use the program, simply run:

   ```bash
   jott
   ```
   
   in any terminal emulator. This will return a random glossary term and definition straight to STDOUT.

   - Program settings can be changed in the accompanying `jott.cfg` file located in `~/.config/jott` after the Makefile installation process.

### Querying a specific term (*beta*)

To query a specific term for The Jargon File glossary, simply run:

```bash
jott -q "<term>"
```
in any terminal emulator, where `<term>` is the specific term that you want to query for. The term must be enclosed within double quotes (""). **Query terms are currently case sensitive and have to be exact.**

#### Examples of querying a specific term

```bash
jott -q "hack"
jott -q "ANSI standard pizza"
jott -q "bit-paired keyboard"
```
## Reporting Issues

If you encounter any issues while using this project, please don't hesitate to report them. Your feedback is valuable and contributes to the improvement of this project.

Before reporting an issue, please ensure that:

- You have searched existing issues to see if the problem has already been reported.
- You are using the latest version of the project.
- You have checked the documentation and other resources to ensure the issue is not related to improper usage.

### How to Report an Issue

1. **Check Existing Issues**: Before submitting a new issue, please search existing issues to see if the problem has already been reported. If you find an open issue that addresses your concern, feel free to add any additional information or context that might be helpful.

2. **Create a New Issue**: If you couldn't find an existing issue that matches your problem, please create a new issue. When creating a new issue, provide as much detail as possible, including:
    - A clear and descriptive title.
    - Steps to reproduce the issue.
    - Expected behavior and actual behavior.
    - Any error messages or screenshots if applicable.
    - Details about your environment such as operating system, browser, or any relevant software versions.
    - Any additional context or information that might be helpful in diagnosing the problem.

3. **Be Responsive**: After submitting an issue, be responsive to any follow-up questions or requests for clarification. This helps in resolving the issue efficiently.

# To-do list of things to do
- [x] Make file and include `curl` dependency check 
- [ ] Fix the text formatting/colour interference
- [x] Argument to query a specific term
  - [x] Query terms with multiple words, currently only able to query one word terms
  - [ ] remove case sensitivity from query terms
  - [x] Handle ! in terms
  - [x] Handle / in terms
  - [x] Handle . in terms
  - [x] Handle & in terms
  - [x] Handle + in terms
  - [x] Handle $ in terms
  - [x] Handle ' in terms
  - [x] Handle ( in terms
  - [x] Handle ) in terms
  - [ ] Querying bot returns barfulation
  - [ ] Handle the query "Compu$erve". Dollar doesn't like being inside a terminal string and needs to be escaped.
  - [ ] Apostrophes inside contractions are replaced with a dash but are omitted completely when used in possessive form.
  - [ ] Handle query "Bzzzt! Wrong."
  - [ ] If punctuation is at the end 
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

## Disclaimer

Project contributers are not responsible in anyway for unintended modification or deletion of user data. Users are expected to inspect any accompanying MAKE files before installing or uninstalling the program. Good data management, including keeping regular back ups, prevents data loss.

---
ASCII Art credits: textkool.com

