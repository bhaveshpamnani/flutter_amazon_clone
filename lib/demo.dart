import 'dart:io';

void main() {
  // Read the input as a string first to preserve leading zeros
  // String input = stdin.readLineSync()!;
  //
  // int a = int.parse(input);
  //
  // int length = input.length; // Use the original length to account for leading zeros
  // int digit;
  // String reverse = "";
  //
  // while (length > 0) {
  //   digit = a % 10;
  //   reverse += digit.toString();
  //   a = a ~/ 10;
  //   length -= 1;
  // }
  //
  // print(reverse);
  // List<int> num =[];
  // for(int i = 0;i<=5;i++){
  //   print("Enter Number : ");
  //   num.add(int.parse(stdin.readLineSync()!));
  // }
  // print(num);
    List<int> numbers = [10, 20, 30, 40, 50];

    int index = 3;

    if (index >= 0 && index < numbers.length) {
      for (int i = index; i < numbers.length - 1; i++) {
        numbers[i] = numbers[i + 1];
      }
      numbers.length--;

      print("List after removing element at index $index: $numbers");
    } else {
      print("Index $index is out of bounds.");
    }
}