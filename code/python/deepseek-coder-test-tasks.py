# task_manager.py

def load_tasks():
    # Function to read tasks from a file or initialize an empty list if the file doesn't exist
    pass

def save_tasks(tasks):
    # Function to write tasks to a file
    pass

def add_task(name, description):
    # Function to add a new task
    pass

def view_tasks():
    # Function to display all tasks
    pass

def mark_completed(index):
    # Function to mark a task as completed by index
    pass

def delete_task(index):
    # Function to delete a task by index
    pass
1
def main():
    print("Welcome to the Task Manager App")
    tasks = load_tasks()
    
    while True:
        print("\nMenu:")
        print("1. Add Task")
        print("2. View Tasks")
        print("3. Mark Task as Completed")
        print("4. Delete Task")
        print("5. Exit")
        
        choice = input("Enter your choice: ")
        
        if choice == '1':
            name = input("Enter task name: ")
            description = input("Enter task description: ")
            add_task(name, description)
        elif choice == '2':
            view_tasks()
        elif choice == '3':
            index = int(input("Enter the task number to mark as completed: "))
            mark_completed(index - 1)  # Subtract 1 for zero-based indexing
        elif choice == '4':
            index = int(input("Enter the task number to delete: "))
            delete_task(index - 1)  # Subtract 1 for zero-based indexing
        elif choice == '5':
            save_tasks(tasks)
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
    