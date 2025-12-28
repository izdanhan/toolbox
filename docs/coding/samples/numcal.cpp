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