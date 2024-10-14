# IntelX Credential Extractor

**IntelX Credential Extractor** is a tool designed to process IntelX search results, which you download as a `.zip` file from IntelX and extract to a folder. This script will then extract and organize email/username and password pairs present within the IntelX search results files. It filters domain-specific credentials, removes duplicates, and generates multiple output files in various formats (CSV, TXT, etc.) for easy analysis.

## Features
- **Search** for domain-specific email/username and password pairs within IntelX search result files.
- **Remove duplicates** and clean up the results.
- **Generate multiple output files**:
  - `Results/output.csv`: Email/Username and Password pairs in CSV format.
  - `Results/output.txt`: A list of Email/Username and Password pairs in plain text format.
  - `Results/username.txt`: A list of only Email/Usernames.
  - `Results/password.txt`: A list of only Passwords.
  - `Results/creds.txt`: Email/Username:Password pairs.
  - `Results/grep_results.txt`: Contains the raw grep search results for domain-specific credentials.
- All output files are saved in a folder called `Results`.

## Requirements
- **Git Bash** or any terminal that supports `bash` scripts.
- **grep** (comes pre-installed with Git Bash).

## Installation

1. Clone this repository or download the `intelx-credentials-extractor.sh` script.
   ```bash
   git clone https://github.com/hamzairshad02/intelx-credentials-extractor.git
   ```

2. Place the script in the same folder as your extracted IntelX .zip results folder. It should look something like this:
   ![image](https://github.com/user-attachments/assets/ae0d7a32-167d-4f92-b349-8570a805a45f)

3. Give execute permission to the script:
   ```bash
   chmod +x intelx-credentials-extractor.sh
   ```

## Usage

1. Run the script:
   ```bash
   ./intelx-credentials-extractor.sh
   ```
   OR
   ```bash
   bash intelx-credentials-extractor.sh
   ```
2. The script will prompt you for a domain name. Enter the domain (e.g., `domain.com`).

3. The script will:
   - Search for email/username and password pairs related to the given domain.
   - Process the results and generate multiple output files inside a folder called `Results`.

### Generated Files
- **`Results/output.csv`**: Contains Email/Username and Password pairs in CSV format.
- **`Results/output.txt`**: Contains Email/Username and Password pairs in plain text.
- **`Results/username.txt`**: Contains only Email/Usernames.
- **`Results/password.txt`**: Contains only Passwords.
- **`Results/creds.txt`**: Contains Email/Username:Password pairs.
- **`Results/grep_results.txt`**: Contains the raw grep search results for domain-specific credentials.

### Example Output
![image](https://github.com/user-attachments/assets/c59154ec-7cb3-41dd-a7c7-4641439f97c7)


#### `output.csv`
```
Email/Username,Password
user1@domain.com,p@ssw0rd
user2@domain.com,
```

#### `output.txt`
```
user1@domain.com:p@ssw0rd
user2@domain.com
```

#### `username.txt`
```
user1@domain.com
user2@domain.com
```

#### `password.txt`
```
p@ssw0rd
```

#### `creds.txt`
```
user1@domain.com:p@ssw0rd
```

#### `grep_results.txt`
```
user1@domain.com:p@ssw0rd
user2@domain.com:
```

## Additional Features
- The script removes any duplicate entries to avoid unnecessary repetitions in the output files.
- If an email is found without a password, the password field will be left empty.
- The raw `grep` results are saved to `Results/grep_results.txt` for further reference.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Thanks to the open-source community for tools like `grep` that make this process much easier.
- Thanks to anyone who will or has contributed to this project!
