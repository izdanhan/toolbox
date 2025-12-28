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