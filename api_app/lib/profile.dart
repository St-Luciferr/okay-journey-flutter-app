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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: ListView(padding: const EdgeInsets.all(10), children: <Widget>[
        for (var user in widget.users)
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
                      user['picture']['large'],
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              formattedText(
                "Name: ",
                "${user['name']['title']}. ${user['name']['first']} ${user['name']['last']}",
              ),
              formattedText(
                "Username: ",
                user['login']['username'],
              ),
              formattedText(
                "Email: ",
                user['email'],
              ),
              formattedText(
                "Phone: ",
                user['phone'],
              ),
              formattedText(
                "Cell: ",
                user['cell'],
              ),
              formattedText(
                "Gender: ",
                user['gender'],
              ),
              formattedText(
                "DOB: ",
                user['dob']['date'].substring(0, 10),
              ),
              formattedText(
                "Age: ",
                user['dob']['age'].toString(),
              ),
              formattedText(
                "Country: ",
                user['location']['country'],
              ),
              formattedText(
                "State: ",
                user['location']['state'],
              ),
              formattedText(
                "City: ",
                user['location']['city'],
              ),
              formattedText(
                "Street: ",
                "${user['location']['street']['number']}, ${user['location']['street']['name']}",
              ),
              formattedText(
                "Timezone: ",
                user['location']['timezone']['description'],
              ),
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
