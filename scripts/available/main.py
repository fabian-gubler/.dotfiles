import arrow
import os
from icalendar import Calendar, Event
from datetime import timedelta

# Variables
working_hours = {'start': '07:00', 'end': '16:00'}
lunch_hours = {'start': '12:00', 'end': '13:00'}
period = '1 month'  # or '1 month'
directories = ['/data/nextcloud/.calendars/pers', '/data/nextcloud/.calendars/uni']

# Find all .ics files in the specified directories
directory_ics_files = {}
for directory in directories:
    ics_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.ics'):
                ics_files.append(os.path.join(root, file))
    directory_ics_files[directory] = ics_files

# Read and parse .ics files to extract events
all_events = []
directory_events = {}
for directory, ics_files in directory_ics_files.items():
    directory_events_list = []
    for ics_file in ics_files:
        with open(ics_file, 'r') as file:
            cal = Calendar.from_ical(file.read())
        for component in cal.walk():
            if component.name == "VEVENT":
                directory_events_list.append(component)
                all_events.append(component)
    directory_events[directory] = directory_events_list

# Calculate the available time
def calculate_available_time(working_hours, lunch_hours, period, all_events):
    now = arrow.utcnow()
    if period == '1 week':
        period_end = now.shift(weeks=1)
    elif period == '1 month':
        period_end = now.shift(months=1)
    else:
        raise ValueError("Invalid period specified")

    total_working_time = 0
    total_lunch_time = 0
    total_busy_time = 0

    # Calculate working time and lunch time in the period
    day = now
    while day < period_end:
        if day.weekday() < 5:  # Weekdays only
            morning_start = day.replace(hour=int(working_hours['start'].split(':')[0]), minute=int(working_hours['start'].split(':')[1]))
            evening_end = day.replace(hour=int(working_hours['end'].split(':')[0]), minute=int(working_hours['end'].split(':')[1]))
            lunch_start = day.replace(hour=int(lunch_hours['start'].split(':')[0]), minute=int(lunch_hours['start'].split(':')[1]))
            lunch_end = day.replace(hour=int(lunch_hours['end'].split(':')[0]), minute=int(lunch_hours['end'].split(':')[1]))

            total_working_time += (evening_end - morning_start).seconds
            total_lunch_time += (lunch_end - lunch_start).seconds

        day = day.shift(days=1)

    # Calculate busy time based on events
    for event in all_events:
        event_start = arrow.get(event['DTSTART'].dt)
        event_end = arrow.get(event['DTEND'].dt)

        if event_start < period_end and event_end > now:
            event_duration = (event_end - event_start).seconds
            total_busy_time += event_duration

    # Calculate available time
    total_available_time = total_working_time - total_lunch_time - total_busy_time
    return total_available_time / 3600, total_busy_time / 3600

# Calculate and output the total available hours and scheduled hours for each directory
total_available_hours, _ = calculate_available_time(working_hours, lunch_hours, period, all_events)
print(f'Total available hours in the next {period}: {total_available_hours}')
print()

for directory, events in directory_events.items():
    _, scheduled_hours = calculate_available_time(working_hours, lunch_hours, period, events)
    print(f'Directory: {directory}')
    print(f'  Time already scheduled in the next {period}: {scheduled_hours} hours')
