# 🧠 Terminal Deliberate Practice

A zero-friction spaced repetition system that tests your technical knowledge cold every time you open your terminal. 

Instead of traditional flashcards with answers on the back, these are **front-only deliberate practice challenges** designed to force active recall and highlight gaps in your mental models. The script automatically picks a random topic file (`.md`), parses its multi-line items intelligently, and displays a clean challenge card.

## Setup

### 🚀 Step 1: Clone and Make Executable

Clone this repository to your preferred location on your machine:

```bash
git clone git@github.com:andremarcondesteixeira/deliberate-practice.git
cd deliberate-practice
```

Make the script executable (required for Unix-based systems and Git Bash):

```bash
chmod +x challenge.sh
```

---

### 💻 Step 2: Configure Your Terminal Startup

To have a challenge automatically display every time you open a new terminal window or tab, add the execution command to your shell's startup profile. Choose your environment below:

#### 🐧 Linux (Bash or Zsh)
1. Open your shell configuration file:
   ```bash
   nano ~/.bashrc  # (or ~/.zshrc if you use Zsh)
   ```
2. Add this line to the bottom of the file:
   ```bash
   bash <PATH WHERE YOU CLONED THIS REPOSITORY>/challenge.sh
   ```
3. Save (`Ctrl+O`, `Enter`) and exit (`Ctrl+X`), then reload your shell:
   ```bash
   source ~/.bashrc
   ```

---

### 🍏 macOS (Zsh - Default)
1. Open your Zsh profile:
   ```bash
   nano ~/.zshrc
   ```
2. Add this line to the bottom:
   ```bash
   bash <PATH WHERE YOU CLONED THIS REPOSITORY>/challenge.sh
   ```
3. Save (`Ctrl+O`, `Enter`) and exit (`Ctrl+X`), then reload your terminal:
   ```bash
   source ~/.zshrc
   ```

---

### 🪟 Windows: Git Bash
If you use Git Bash as your primary shell on Windows:
1. Open your home profile file:
   ```bash
   nano ~/.bashrc
   ```
   *(If the file doesn't exist, this will create it).*
2. Add this line to the bottom (update the path to match where you cloned the repo):
   ```bash
   bash <PATH WHERE YOU CLONED THIS REPOSITORY>/challenge.sh
   ```
3. Save and exit, then restart your Git Bash window.

---

### 🪟 Windows: PowerShell
If you use PowerShell on Windows, you can invoke the script using the built-in `bash` command (provided by Git Bash):

1. Open your PowerShell profile script:
   ```powershell
   notepad \$PROFILE
   ```
   *(If it says the file doesn't exist, create it first by running: `New-Item -Type File -Force $PROFILE`)*

2. Add this line to the bottom of your profile:
   ```powershell
   # Run deliberate practice challenge on PowerShell startup
   bash "<PATH WHERE YOU CLONED THIS REPOSITORY>\challenge.sh"
   ```

3. Save and close. Every time you open a new PowerShell terminal, a random challenge will be pulled and displayed!

---

## 📝 How to Add New Challenges

1. Create a new `.md` file inside your repository folder (e.g., `distributed-systems.md`). The file name automatically becomes the topic header.
2. Write your challenges as a simple bulleted or numbered list. Multi-line items are automatically supported as long as continuation lines are indented or follow the item:
   ```markdown
   * Explain how consistent hashing solves horizontal scaling hot-spots in distributed caching layers.
   * What is the exact sequence of events during a TCP three-way handshake, and where do SYN-floods target it?
   ```
3. Commit and push your changes to GitHub to sync your practice deck across all your machines!