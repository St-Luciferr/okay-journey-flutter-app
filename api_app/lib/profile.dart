import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final List<dynamic> users;
  const UserProfile({
    super.key,
    required this.users,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> _foundData = [];
  @override
  initState() {
    //creating list for all the user data to show to user
    _allData = [
      {
        "label": "Name: ",
        "text":
            "${widget.users[0]['name']['title']}. ${widget.users[0]['name']['first']} ${widget.users[0]['name']['last']}",
      },
      {
        "label": "Username: ",
        "text": "${widget.users[0]['login']['username']}",
      },
      {
        "label": "Email: ",
        "text": "${widget.users[0]['email']}",
      },
      {
        "label": "Phone: ",
        "text": "${widget.users[0]['phone']}",
      },
      {
        "label": "Cell: ",
        "text": "${widget.users[0]['Cell']}",
      },
      {
        "label": "Gender: ",
        "text": "${widget.users[0]['Gendor']}",
      },
      {
        "label": "DOB: ",
        "text": "${widget.users[0]['dob']['date'].substring(0, 10)}",
      },
      {
        "label": "Age: ",
        "text": "${widget.users[0]['dob']['age']}",
      },
      {
        "label": "Country: ",
        "text": "${widget.users[0]['location']['country']}",
      },
      {
        "label": "State: ",
        "text": "${widget.users[0]['location']['state']}",
      },
      {
        "label": "City: ",
        "text": "${widget.users[0]['location']['city']}",
      },
      {
        "label": "Street: ",
        "text":
            "${widget.users[0]['location']['street']['number']}, ${widget.users[0]['location']['street']['name']}",
      },
      {
        "label": "Timezone: ",
        "text": "${widget.users[0]['location']['timezone']['description']}",
      },
    ];
    //list to show only the searched data
    _foundData = _allData;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all user data
      results = _allData;
    } else {
      //contains only those field which start with entered letters
      results = _allData
          .where(
            (data) => data["label"]
                .toLowerCase()
                .startsWith(enteredKeyword.toLowerCase(), 0),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundData = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: ListView(padding: const EdgeInsets.all(10), children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(54),
                  border: Border.all(
                    width: 5,
                    color: const Color.fromARGB(255, 13, 174, 174),
                  ),
                ),
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    widget.users[0]['picture']['large'],
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 13, 174, 174),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 13, 174, 174),
                ),
                hintText: 'Enter which field to search',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 13, 174, 174),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //if search returns null list
            if (_foundData.isEmpty)
              const Text(
                "Sorry can't find the field",
                style: TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 164, 159, 158)),
              ),
            //if search returns non-empty list
            for (dynamic item in _foundData)
              formattedText(item['label'], item['text']),
          ],
        )
      ]),
    );
  }
}

//Creates formatted text with bold labels
Widget formattedText(String label, String text) {
  return RichText(
    text: TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ]),
  );
}
