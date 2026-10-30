# 🧠 Terminal Deliberate Practice

A zero-friction spaced repetition system that tests your technical knowledge cold every time you open your terminal. 

Instead of traditional flashcards with answers on the back, these are **front-only deliberate practice challenges** designed to force active recall and highlight gaps in your mental models. The script parses every deck (`.md` file, in any folder), picks a random card you haven't seen yet in the current review cycle, and displays a clean challenge card.

## 🔁 The 3-Month Review Cycle

Every card comes up once per cycle (90 days by default), in random order across all decks, until you mark it done. When every card has been marked done, a new cycle starts automatically. Each card shows a progress line telling you how many cards per day you need to finish the cycle on time:

```
| CYCLE:    312/961 cards · day 31/90 · 11/day to stay on track
```

The cycle is a goal, not a deadline. If you take a break, nothing resets: your progress is kept and the daily target rises to cover the cards left in the days left. After day 90 the line shows how far past the goal you are instead (`· 12 day(s) past the 90-day goal`), and the cycle stays open until you finish it. The next cycle starts on the day you mark the last card. To start over with a fresh 90 days after a long break, reset your progress (see below).

After each card you're asked `Mark this card as done? [y/N, s = study guide, q = quit]`. Only `y` counts the card as seen for the cycle; pressing Enter skips it and it stays in the pool for later, and `q` stops a multi-card session. If the script runs without an interactive terminal, nothing is marked.

If you're not up to a challenge, press `s` to show the deck's study guide: the books (and which chapters) to read, official docs and where to look in them, classic papers, related technologies to compare, terms to search for, and a hands-on exercise. Then answer the prompt as usual. Study guides deliberately avoid article links, which tend to die; they point to books, official documentation and search terms that stay findable.

Opening a terminal shows one card. To catch up, or to do a focused session, ask for more:

```bash
bash challenge.sh 5        # show 5 cards
bash challenge.sh --status # show progress only
```

Progress is stored outside the repository in `~/.deliberate-practice` (override with `DELIBERATE_PRACTICE_STATE`), so it never creates Git noise. It holds two files: `seen` (one line per card you marked done) and `cycle_start` (when the current cycle began). To restart the cycle from scratch, delete the folder (`rm -rf ~/.deliberate-practice`); it is recreated on the next run. Set `CYCLE_DAYS` to change the cycle length.

## 🗂️ Deck Layout

Decks are grouped by domain, and each concept lives in exactly one deck:

| Folder | Decks |
| --- | --- |
| `Distributed Systems/` | Time & Clocks, Replication & Consistency, Consensus & Coordination, Partitioning, Distributed Transactions, Batch & Stream Processing |
| `Databases/` | Storage Engines & Indexing, Transactions & Isolation, Query Performance, SQL, PostgreSQL Internals, Operations, Data Models & Encoding, Specialized Datastores, MongoDB, Redis |
| `Messaging/` | Apache Kafka, RabbitMQ |
| `Architecture/` | Architectural Styles, DDD, Microservices, Event-Driven & Data Patterns, Resilience Patterns, Quality Attributes & Governance, System Design (estimation and design labs) |
| `Platform/` | Docker, Kubernetes, CI/CD & Delivery, Infrastructure as Code, Configuration & Secrets, Networking |
| `Observability/` | Metrics, Logging, Tracing, SLOs/Alerting/Incidents, Profiling & Diagnostics |
| `Security/` | Application Security, Authentication & Identity, Cryptography & TLS, Secure Delivery |
| `Java/`, `Spring/` | Language, Concurrency, JVM & GC, Platform & Migration · Core & Boot, Data & Transactions, Web/Security/Cloud |
| `AWS/` | Compute, Storage, Networking, Databases, IAM & Security, Integration, Management & Governance |
| `Fundamentals/` | Operating Systems |

The card topic shown in the terminal is `FOLDER / FILE`, and the subtitle is the `##` section the card belongs to.

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

### 🎨 Step 2 (Optional): Install Glow for Rich Terminal Styling

`challenge.sh` includes optional support for **Glow**, a terminal-based Markdown renderer. If `glow` is installed on your system, challenge cards will be rendered with full Markdown styling, colors, and syntax highlighting. If `glow` is not installed, the script safely falls back to standard text output.

#### 🐧 Linux
* **Debian/Ubuntu:**
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
  sudo apt update && sudo apt install glow

* **Fedora/RHEL:**
  echo '[charm]
  name=Charm
  baseurl=https://repo.charm.sh/yum/
  enabled=1
  gpgcheck=1
  gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
  sudo yum install glow

* **Arch Linux:**
  sudo pacman -S glow

#### 🍏 macOS
Using Homebrew:
brew install glow

#### 🪟 Windows
Using WinGet (PowerShell/CMD):
winget install charmbracelet.glow

Using Scoop:
scoop install glow

Using Chocolatey:
choco install glow

---

### 💻 Step 3: Configure Your Terminal Startup

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

1. **Check whether the concept already has a home.** Search the decks first (`grep -ri "consistent hashing" .`). If a similar card exists, sharpen it instead of adding a near-duplicate.
2. Add the card to the matching deck and `##` section, or create a new `.md` file in the matching folder. The folder and file name become the topic header.
3. Write each challenge as a top-level bullet with a bold title. Indented lines belong to the card above them, which is how labs are written:
   ```markdown
   * **Consistent Hashing:** How does consistent hashing minimize key movement when nodes join or leave?
   * **Lab — TIME_WAIT Port Exhaustion:**
     * *Setup:* A client service starts failing with `EADDRNOTAVAIL`.
     * *Challenge:* Explain why, and fix it.
   ```
4. **Every deck must end with a `## Study Guide` section.** Its bullets are not cards; they're shown when you press `s`. When you add a deck, or cards that the guide doesn't cover yet, update it using the same fields as the other decks:
   ```markdown
   ## Study Guide

   * **Books:**
     * *Book Title* (Author): the chapter on X, named by topic rather than number so it survives new editions.
   * **Official docs:** which manual, specification or RFC to read, and which section.
   * **Papers:** classic papers by title and authors (omit if none apply).
   * **Related technologies:** tools that solve the same problem differently, worth comparing.
   * **Search for:** `exact terms`, `to search for`.
   * **Hands-on:** one exercise that makes the concepts concrete.
   ```
   Don't use article URLs; they die. Point to books, official docs and search terms instead.
5. Keep the deck reviewable: every ~90 new cards adds one card per day to the cycle. Prefer cards that test reasoning and trade-offs over trivia you'd look up anyway.
6. Commit and push your changes to GitHub to sync your practice deck across all your machines!

A card is identified by its first line, so editing that line makes it count as a new, unseen card in the current cycle.