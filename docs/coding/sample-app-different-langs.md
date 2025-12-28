I'll create a simple program that reads numbers from the user, calculates their sum and average, and handles errors. Here's the same program implemented in five different languages:

## 1. **Rust**
```rust
use std::io;

fn main() {
    println!("=== Number Calculator ===");
    
    let mut numbers: Vec<f64> = Vec::new();
    
    println!("Enter numbers (type 'done' to finish):");
    
    loop {
        let mut input = String::new();
        io::stdin().read_line(&mut input).expect("Failed to read line");
        
        let input = input.trim();
        if input.eq_ignore_ascii_case("done") {
            break;
        }
        
        match input.parse::<f64>() {
            Ok(num) => numbers.push(num),
            Err(_) => println!("'{}' is not a valid number. Try again.", input)
        }
    }
    
    if numbers.is_empty() {
        println!("No numbers entered.");
        return;
    }
    
    let sum: f64 = numbers.iter().sum();
    let average = sum / numbers.len() as f64;
    let max = numbers.iter().fold(f64::NEG_INFINITY, |a, &b| a.max(b));
    let min = numbers.iter().fold(f64::INFINITY, |a, &b| a.min(b));
    
    println!("\nResults:");
    println!("Count: {}", numbers.len());
    println!("Sum: {:.2}", sum);
    println!("Average: {:.2}", average);
    println!("Max: {:.2}", max);
    println!("Min: {:.2}", min);
    
    println!("\nNumbers entered: {:?}", numbers);
}
```

## 2. **Python**
```python
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
```

## 3. **Java**
```java
import java.util.ArrayList;
import java.util.Scanner;

public class NumberCalculator {
    public static void main(String[] args) {
        System.out.println("=== Number Calculator ===");
        
        Scanner scanner = new Scanner(System.in);
        ArrayList<Double> numbers = new ArrayList<>();
        
        System.out.println("Enter numbers (type 'done' to finish):");
        
        while (true) {
            String input = scanner.nextLine().trim();
            
            if (input.equalsIgnoreCase("done")) {
                break;
            }
            
            try {
                double num = Double.parseDouble(input);
                numbers.add(num);
            } catch (NumberFormatException e) {
                System.out.printf("'%s' is not a valid number. Try again.%n", input);
            }
        }
        
        scanner.close();
        
        if (numbers.isEmpty()) {
            System.out.println("No numbers entered.");
            return;
        }
        
        double sum = 0;
        double max = Double.NEGATIVE_INFINITY;
        double min = Double.POSITIVE_INFINITY;
        
        for (double num : numbers) {
            sum += num;
            if (num > max) max = num;
            if (num < min) min = num;
        }
        
        double average = sum / numbers.size();
        
        System.out.printf("%nResults:%n");
        System.out.printf("Count: %d%n", numbers.size());
        System.out.printf("Sum: %.2f%n", sum);
        System.out.printf("Average: %.2f%n", average);
        System.out.printf("Max: %.2f%n", max);
        System.out.printf("Min: %.2f%n", min);
        
        System.out.printf("%nNumbers entered: %s%n", numbers);
    }
}
```

## 4. **C++**
```cpp
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <limits>
#include <iomanip>

using namespace std;

int main() {
    cout << "=== Number Calculator ===" << endl;
    
    vector<double> numbers;
    string input;
    
    cout << "Enter numbers (type 'done' to finish):" << endl;
    
    while (true) {
        cout << "> ";
        getline(cin, input);
        
        // Trim whitespace
        input.erase(0, input.find_first_not_of(" \t"));
        input.erase(input.find_last_not_of(" \t") + 1);
        
        if (input == "done" || input == "DONE") {
            break;
        }
        
        try {
            double num = stod(input);
            numbers.push_back(num);
        } catch (const invalid_argument&) {
            cout << "'" << input << "' is not a valid number. Try again." << endl;
        }
    }
    
    if (numbers.empty()) {
        cout << "No numbers entered." << endl;
        return 0;
    }
    
    double sum = 0;
    double maxNum = numeric_limits<double>::lowest();
    double minNum = numeric_limits<double>::max();
    
    for (double num : numbers) {
        sum += num;
        if (num > maxNum) maxNum = num;
        if (num < minNum) minNum = num;
    }
    
    double average = sum / numbers.size();
    
    cout << fixed << setprecision(2);
    cout << "\nResults:" << endl;
    cout << "Count: " << numbers.size() << endl;
    cout << "Sum: " << sum << endl;
    cout << "Average: " << average << endl;
    cout << "Max: " << maxNum << endl;
    cout << "Min: " << minNum << endl;
    
    cout << "\nNumbers entered: ";
    cout << "[";
    for (size_t i = 0; i < numbers.size(); i++) {
        cout << numbers[i];
        if (i < numbers.size() - 1) cout << ", ";
    }
    cout << "]" << endl;
    
    return 0;
}
```

## 5. **C#**
```csharp
using System;
using System.Collections.Generic;

class NumberCalculator
{
    static void Main()
    {
        Console.WriteLine("=== Number Calculator ===");
        
        List<double> numbers = new List<double>();
        
        Console.WriteLine("Enter numbers (type 'done' to finish):");
        
        while (true)
        {
            Console.Write("> ");
            string input = Console.ReadLine()?.Trim();
            
            if (string.IsNullOrEmpty(input)) continue;
            
            if (input.Equals("done", StringComparison.OrdinalIgnoreCase))
            {
                break;
            }
            
            if (double.TryParse(input, out double num))
            {
                numbers.Add(num);
            }
            else
            {
                Console.WriteLine($"'{input}' is not a valid number. Try again.");
            }
        }
        
        if (numbers.Count == 0)
        {
            Console.WriteLine("No numbers entered.");
            return;
        }
        
        double sum = 0;
        double max = double.MinValue;
        double min = double.MaxValue;
        
        foreach (double num in numbers)
        {
            sum += num;
            if (num > max) max = num;
            if (num < min) min = num;
        }
        
        double average = sum / numbers.Count;
        
        Console.WriteLine("\nResults:");
        Console.WriteLine($"Count: {numbers.Count}");
        Console.WriteLine($"Sum: {sum:F2}");
        Console.WriteLine($"Average: {average:F2}");
        Console.WriteLine($"Max: {max:F2}");
        Console.WriteLine($"Min: {min:F2}");
        
        Console.WriteLine($"\nNumbers entered: [{string.Join(", ", numbers)}]");
    }
}
```

## **Common Features:**
All programs implement the same functionality:

1. **Interactive Input**: Read numbers until user types "done"
2. **Error Handling**: Invalid input is rejected with a message
3. **Calculations**: Sum, average, min, and max
4. **Output**: Formatted results showing all calculations
5. **Data Storage**: Store all entered numbers in a collection

## **Key Differences by Language:**

- **Memory Management**: Rust has ownership, C++ manual management, others use garbage collection
- **Error Handling**: Rust uses Result/Option, others use exceptions/try-catch
- **Type Safety**: Rust is strictest, Python most flexible
- **Verbosity**: Java and C++ are most verbose, Python most concise
- **Standard Library**: Each has different collection and I/O approaches
