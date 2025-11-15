# Bash-Text-Processing
This project provides two Bash tools: one for auto-compiling source files and one for performing Caesar cipher text rotation.

# Caesar Cipher & Disk Usage

This repository contains two Bash scripts written for Homework 05:

- **disk_usage.sh** → lists the largest directories/files  
- **caesar.sh** → rotates text using the Caesar cipher  

---

# 📌 disk_usage.sh

## Description
Prints the largest items (directories by default, or directories + files with `-a`) inside each given directory.  
Supports limiting output with `-n N`.

## Usage
```
./disk_usage.sh [-a -n N] directory...
```

## Examples
```
$ ./disk_usage.sh /etc
15M  /etc
6.5M /etc/udev
2.0M /etc/ssl
```

```
$ ./disk_usage.sh -n 5 /etc
15M  /etc
6.5M /etc/udev
2.0M /etc/ssl
```

```
$ ./disk_usage.sh -a /etc
15M  /etc
6.5M /etc/udev/hwdb.bin
6.5M /etc/udev
```

---

# 📌 caesar.sh

## Description
Reads from **STDIN** and applies a Caesar rotation (default: 13).  
Handles rotations larger than 26 using modulo arithmetic.

## Usage
```
./caesar.sh [rotation]
```

## Examples
```
$ echo "I came, I saw, I conquered." | ./caesar.sh
V pnzr, V fnj, V pbadhrerq.
```

```
$ echo "I came, I saw, I conquered." | ./caesar.sh | ./caesar.sh
I came, I saw, I conquered.
```

```
$ echo "Experience is the teacher of all things." | ./caesar.sh 10
Ohzobsoxmo sc dro dokmrob yp kvv drsxqc.
```

---

# 📌 QUESTIONS & ANSWERS

## Caesar Script
**How was SET1 constructed?**  
By combining uppercase + lowercase alphabets into one translation source string.

**How was SET2 constructed?**  
Each alphabet was duplicated, shifted using `cut`, and trimmed to 26 characters to form the rotated target alphabet.

**How were SET1 and SET2 used?**  
Using `tr SET1 SET2` to perform character-by-character rotation.

---

## Disk Usage Script
**a. How were command-line arguments parsed?**  
Using `getopts` to capture `-a` and `-n N`, validate input, and handle errors.

**b. How was the “no arguments” case handled?**  
The script prints usage and exits if no directories are provided.

**c. How was each directory processed?**  
Each directory is validated with `-d` and passed through `du`, `sort`, and `head`.

**d. How were flags used in the computation?**  
- With `-a`: `du -ah`  
- Without `-a`: `du -h`  
Then sorted and truncated to top N entries.

**Hardest part?**  
Argument parsing & error handling (more code than core logic).

---

## 📌 Test Scripts

### Download
```
curl -O http://www3.nd.edu/~pbui/teaching/cse.20189.sp16/static/sh/test_caesar.sh
curl -O http://www3.nd.edu/~pbui/teaching/cse.20189.sp16/static/sh/test_disk_usage.sh
```

### Make executable
```
chmod +x test_caesar.sh
chmod +x test_disk_usage.sh
```

### Run tests
```
./test_caesar.sh
./test_disk_usage.sh
```

---

## 📸 Test Results

Below are my test outputs confirming both scripts pass successfully:

<img src="https://github.com/user-attachments/assets/227e69ea-da05-4c39-9f83-795ae130c240" width="520" alt="disk_usage_test"/>

<br>

<img src="https://github.com/user-attachments/assets/f0c996ab-080d-4cfa-9c83-0d7b38ea0d6d" width="520" alt="caesar_test"/>
>>>>>>> a0e4df8 (README added.)
