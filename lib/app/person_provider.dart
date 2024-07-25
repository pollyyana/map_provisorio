import 'package:flutter/foundation.dart';
import 'package:app_teste/app/model/person.dart'; 

class PersonProvider with ChangeNotifier {
  List<Person> people = [
    Person(
      name: 'Pollyana',
      role: 'Desenvolvedora',
      description: 'Entusiasta tecnologia',
      imagePath: 'assets/person2.png',
    ),
    Person(
      name: 'Lais',
      role: 'CTO',
      description: 'nao sei',
      imagePath: 'assets/person1.jpg',
    ),
    Person(
      name: 'Leo',
      role: 'UX Designer',
      description: 'Expert UX ',
      imagePath: 'assets/person2.png',
    ),
  ];

  void updatePerson(int index, Person updatedPerson) {
    people[index] = updatedPerson;
    notifyListeners();
  }
}
