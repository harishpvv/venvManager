# envm – Simple Python Virtual Environment Manager

`envm` is a lightweight bash function for managing Python virtual environments in a single centralized location (`~/.venvs`). It allows you to create, activate, list, delete, and add info to virtual environments easily from the terminal.

---

## Features

- Create virtual environments with optional descriptions.  
- Activate environments in the current shell (auto-deactivates previous venv).  
- List all environments with their info.  
- Delete single, multiple, or all environments.  
- Update information/description for any environment.  
- No external dependencies besides Python 3 and bash.  

---

## Installation

1. Make sure you have Python 3 installed.
2. Ensure you have a `.venvs` folder in your home directory:

```bash
mkdir -p ~/.venvs
```

3. Add the `envm()` function to your `~/.bashrc`:

```bash
# Add this at the end of your ~/.bashrc
envm() {
    # (Paste the full envm() function here)
}
```
or

```
source PATH_TO_ENVM.SH_FILE
```

4. Reload your shell:

```bash
source ~/.bashrc
```

---

## Usage

### 1. Create a new virtual environment

```bash
envm c myenv "Optional description for this environment"
```

- `myenv` – name of the venv  
- `"Optional description..."` – free text info stored in `.info`  

---

### 2. List all environments

```bash
envm l
```

Example output:

```
NAME                 INFO
------------------------------------------------------------
myenv                Python project for testing
data-science         Data analysis project
```

---

### 3. Activate an environment

```bash
envm a myenv
```

- Automatically deactivates any currently active venv.  
- Prompts confirmation: `✅ Activated 'myenv'`.

---

### 4. Delete environments

```bash
# Delete a single environment
envm d myenv

# Delete multiple environments
envm d myenv data-science

# Delete all environments
envm d all
```

- Confirmation will be printed for each deleted environment.  

---

### 5. Update info for an environment

```bash
envm i myenv "Updated description for this environment"
```

---

### 6. Help / Usage

```bash
envm
```

Displays:

```
Usage: envm [a|c|l|d|i] ...
a name        Activate venv
c name info   Create venv with optional info
l             List all venvs
d name.../all Delete one, multiple, or all venvs
i name info   Update info for venv
```

---

## Notes

- All virtual environments are stored in `~/.venvs/`.  
- No “active” tracking file; activation affects only the current shell session.  
- Compatible with Bash (`[[ ... ]]`) and requires Python 3.

