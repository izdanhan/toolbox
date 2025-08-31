# Linux File Permissions & Ownership

## Basics
Every file has:
- **Owner**
- **Group**
- **Permissions** (read, write, execute)

Check with:
```bash
ls -l file.txt
```
Output:
```
-rw-r--r-- 1 user group 1234 Aug 31 12:00 file.txt
```

Breakdown:
- `-rw-r--r--` → permissions
- `user` → owner
- `group` → group

---

## Permission Types
- **r** = read  
- **w** = write  
- **x** = execute  

Three groups:
1. Owner
2. Group
3. Others

Example: `-rwxr-x---`
- Owner: read/write/execute
- Group: read/execute
- Others: no access

---

## Changing Permissions
```bash
chmod 644 file.txt    # rw-r--r--
chmod +x script.sh    # add execute
```

## Changing Ownership
```bash
sudo chown user:group file.txt
```

---

## Best Practices
- Scripts → `755` (rwxr-xr-x)
- Config files → `644` (rw-r--r--)
- Sensitive files → `600` (rw-------)

