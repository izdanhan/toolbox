def main():
    print("=== Number Calculator ===")
    
    numbers = []
    
    print("Enter numbers (type 'done' to finish):")
    
    while True:
        user_input = input("> ").strip()
        
        if user_input.lower() == 'done':
            break
        
        try:
            num = float(user_input)
            numbers.append(num)
        except ValueError:
            print(f"'{user_input}' is not a valid number. Try again.")
    
    if not numbers:
        print("No numbers entered.")
        return
    
    total = sum(numbers)
    average = total / len(numbers)
    maximum = max(numbers)
    minimum = min(numbers)
    
    print(f"\nResults:")
    print(f"Count: {len(numbers)}")
    print(f"Sum: {total:.2f}")
    print(f"Average: {average:.2f}")
    print(f"Max: {maximum:.2f}")
    print(f"Min: {minimum:.2f}")
    
    print(f"\nNumbers entered: {numbers}")

if __name__ == "__main__":
    main()