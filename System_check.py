import psutil
import subprocess
import smtplib

# Replace with your email address
EMAIL_ADDRESS = "prathameshwadile0@gmail.com"

# Thresholds for CPU, memory, and disk usage
CPU_THRESHOLD = 80
MEMORY_THRESHOLD = 90
DISK_SPACE_THRESHOLD = 10  # Percentage of free disk space

def get_cpu_usage():
    """Gets CPU usage as a percentage."""
    return psutil.cpu_percent(interval=1)  # Get usage over 1 second

def get_memory_usage():
    """Gets memory usage as a percentage."""
    memory_usage = psutil.virtual_memory().percent
    return memory_usage

def get_disk_usage():
    """Gets disk usage percentage for the root partition (`/`)."""
    root_usage = psutil.disk_usage('/').percent
    return root_usage

def get_running_processes():
    """Gets the number of running processes."""
    return len(psutil.process_iter())

def send_alert(message):
    """Sends an email notification with the given message."""
    server = smtplib.SMTP('smtp.your_email_provider.com', 587)  # Replace with your SMTP server details
    server.starttls()
    server.login(EMAIL_ADDRESS, 'your_email_password')  # Replace with your email password
    server.sendmail(EMAIL_ADDRESS, EMAIL_ADDRESS, f"Alert: {message}")
    server.quit()

def main():
    while True:
        cpu_usage = get_cpu_usage()
        memory_usage = get_memory_usage()
        disk_space_usage = get_disk_usage()
        running_processes = get_running_processes()

        # Check and send alerts for high usage
        if cpu_usage > CPU_THRESHOLD:
            message = f"CPU usage is high: {cpu_usage}%"
            send_alert(message)
            print(message)

        if memory_usage > MEMORY_THRESHOLD:
            message = f"Memory usage is high: {memory_usage}%"
            send_alert(message)
            print(message)

        if disk_space_usage > DISK_SPACE_THRESHOLD:
            message = f"Disk space is low: {disk_space_usage}%"
            send_alert(message)
            print(message)

        if running_processes > 100:  # Adjust this threshold if needed
            message = f"High number of running processes: {running_processes}"
            send_alert(message)
            print(message)

        # Sleep for 5 minutes before the next check
        print("Sleeping for 5 minutes...")
        time.sleep(300)

if __name__ == "__main__":
    main()