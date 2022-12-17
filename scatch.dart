void main() {
  perform();
}

void perform()async {
  task1();
  String task2data = await task2();
  task3(task2data);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complite');
}

Future<String> task2() async{
  Duration threeSeconds = Duration(seconds: 3);
  String result='g';
 await Future.delayed(threeSeconds, () {
    print('Task 2 complite');
     result = 'task 2 data';
  });

  return result;
}

void task3(String task2data) {
//  String result='task 3 data';
  print('task3complite with $task2data');
}
