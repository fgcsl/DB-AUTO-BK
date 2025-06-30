
# 🔄 DB-AUTO-BK: Automated Website & MySQL Backup Tool

**DB-AUTO-BK** is a Bash-based utility that automates the process of backing up website files and MySQL databases from a remote server to your local machine. It is ideal for developers, sysadmins, or researchers who manage websites and need regular, reliable backups.

---

## ✅ Features

- 📁 Website file backup using `rsync` (incremental, efficient)
- 🛢️ MySQL database backup using `mysqldump`
- 📅 Date-wise organized backup folders
- 🔒 Secure file transfers using SSH
- 🕒 Easy scheduling with `cron`

---

## 🚀 How It Works

1. Backs up website code using `rsync` from a remote server.
2. Dumps MySQL databases on the remote server.
3. Copies `.sql` dump files to the local machine.
4. Stores everything under a date-stamped folder.

---

## 📂 Example Backup Structure

/your/local/backup/path/
└── 2025-06-30/
├── website/ # Website files
└── db_backup/ # SQL database dumps


---

## ⚙️ Why `rsync` instead of `scp`?

While both tools use SSH, `rsync` is optimized for backups:

- 🔁 Only transfers modified files
- ⚡ Faster for repeated runs
- 📉 Reduces bandwidth usage
- 💡 Great for syncing folders recursively

---

## 🧰 Requirements

- Bash shell
- `rsync`, `scp`, `ssh`, `mysqldump` installed
- Remote server access with SSH key or credentials

---

## 🛠️ Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/fgcsl/DB-AUTO-BK.git

2. Open the script file (e.g., backup.sh) and edit the following:

```bash
REMOTE_USER

REMOTE_HOST

REMOTE_WEB_PATH

REMOTE_DB_CREDENTIALS

LOCAL_BACKUP_DIR
```
3. Make it executable:

```bash
chmod +x backup.sh
```
4. Run the script:
```bash
./backup.sh
```

🕒 Automate with Cron (Optional)
To run the backup daily at 2 AM, add this line using crontab -e:
```bash
0 2 * * * /path/to/DB-AUTO-BK/backup.sh >> /path/to/logs/db_backup.log 2>&1
```

🙋‍♂️ Maintainer
Abhishek Khatri
System Analyst – Bioinformatics Lab
FGCSL, ICGEB
