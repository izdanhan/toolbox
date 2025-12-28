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