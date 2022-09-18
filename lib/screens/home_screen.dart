import 'package:flash_card/constants.dart';
import 'package:flash_card/screens/f_cards.dart';
import 'package:flash_card/screens/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/custom_widget/mini_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: kAppBarTStyle),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white.withOpacity(
              0.95), //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: const Color(0xFF1A99EE).withOpacity(0.8)),
                child: const Text(
                  'Flashcards',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              ListTile(
                title: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.home,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                          text: " Home",
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.quiz_rounded,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                          text: " Quiz",
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return QuizPage();
                    }),
                  );
                },
              ),
              ListTile(
                title: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.settings,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                          text: " Settings",
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20.0,
                width: 180.0,
                child: Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 1.50,
                  color: Color(0xFF9C99B2),
                ),
              ),
              ListTile(
                title: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          size: 25.0,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                          text: " Favorites",
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.bookmark,
                          size: 25.0,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                          text: " Bookmarks",
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(secondary: Color(0xFF1A99EE)),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const Fcards();
              }),
            );
          },
          child: const Icon(
            Icons.add,
            size: 30.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MiniCard(
              title: 'Card 1',
              colour: const Color(0xFFE75466),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Fcards();
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: MiniCard(
              title: 'Card 2',
              colour: const Color(0xFF197894),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Fcards();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
