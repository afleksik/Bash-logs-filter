# Log Processing Script

## Overview

This project contains a Bash script that searches for log files with the `.log` extension in a specified directory, validates them according to a predefined format, and outputs the logs sorted by their ID in descending order. The script can display either the top or bottom set of logs based on user-specified options.

## Purpose

The goal of this assignment is to create a script that:
- **Collects Logs:** Searches for all files with the `.log` extension within a given directory.
- **Validates Logs:** Filters the collected logs using a specific format.
- **Sorts Logs:** Orders the valid logs in descending order by their log identifier (ID).
- **Outputs Logs:** Prints the first or last set of logs based on the chosen option:
  - **Option "up":** Prints the top `N` logs.
  - **Option "down":** Prints the bottom `N` logs.
  
If the total number of valid logs is less than the specified limit, all valid logs are printed.

## Log File Format

A correct log entry must match the following regular expression pattern:

```
^\[ (INFO|DEBUG|WARNING|ERROR) \]\s+[0-9]{2}:[0-9]{2}:[0-9]{4}\s+(0|[1-9][0-9]*)\s+[a-zA-Z_]*$
```

This means each log should be structured as:

```
[ <descriptor> ] dd:mm:yyyy <id> <message>
```

Where:
- **Descriptor:** One of the following logging levels: `INFO`, `DEBUG`, `WARNING`, or `ERROR`.
- **Date:** A date in the format `dd:mm:yyyy` (day-month-year).
- **ID:** A non-negative integer that serves as the log identifier.
- **Message:** An arbitrary message consisting of Latin characters or underscores. The message may be empty.

## Usage

```bash
./parse-logs.sh [OPTION]... DIR
```

### Positional Argument

- **DIR:** The directory where the log files are located.

### Options

- **-l, --lines NUMBER**  
  Limit the number of logs to display. The default is `10`.

- **-o, --order [up|down]**  
  Determines the order in which the logs are printed:
  - `up` (default): Returns the top `NUMBER` logs.
  - `down`: Returns the last `NUMBER` logs.

### Example

To display the top 5 logs from the `/path/to/logs` directory:

```bash
./parse-logs.sh -l 5 -o up /path/to/logs
```

## How It Works

1. **Argument Parsing:**  
   The script processes command-line arguments to determine the target directory, the number of logs to display, and the order (up or down).

2. **Log Collection:**  
   It uses the `find` command to locate all `.log` files within the specified directory and concatenates their contents.

3. **Log Validation:**  
   The concatenated logs are filtered using `grep` with a regular expression that enforces the correct log format.

4. **Sorting:**  
   The valid logs are then sorted in descending order based on the log ID using the `sort` command.

5. **Output:**  
   Depending on the specified order:
   - If `up`, the script prints the first `N` lines.
   - If `down`, it prints the last `N` lines.
   If there are fewer valid logs than the specified limit, all valid logs are displayed.

## Error Handling

- **Invalid Options:**  
  The script checks for invalid options. For example, if the number provided with `-l` is not a valid number or the value for `-o` is not `up` or `down`, an error message is displayed.

- **Directory Check:**  
  If the specified directory does not exist or is not a directory, the script prints an error message and exits.

- **Empty Log Set:**  
  If no valid logs are found after filtering, the script notifies the user by outputting "LOGS NOT FOUND" and exits gracefully.

<div style="text-align: center">
    <img src="img/cat.gif">
</div>
