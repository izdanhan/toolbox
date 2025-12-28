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