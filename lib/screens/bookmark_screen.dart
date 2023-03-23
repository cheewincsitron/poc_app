import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:poc_app/widgets/app_scroll_behavior.dart';
import 'package:sizer/sizer.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  late PageController _pageController;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU"
  ];
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BookMark"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteConstants.reading);
                },
                child: Text("Reading"),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    hintText: "username",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.green,
                    ),
                    prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused)) {
                        return Colors.green;
                      }
                      if (states.contains(MaterialState.error)) {
                        return Colors.red;
                      }
                      return Colors.grey;
                    }),
                    suffixIcon: const Icon(
                      Icons.close_rounded,
                      color: Colors.green,
                    ),
                  ),
                  onSaved: (newValue) {
                    print("onSaved");
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.startsWith("a")) {
                      return "length";
                    }

                    return null;
                  },
                ),
              ),
              Container(
                color: Colors.blue,
                height: 200,
                child: PageView.builder(
                    scrollBehavior: AppScrollBehavior(),
                    itemCount: images.length,
                    pageSnapping: true,
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        activePage = page;
                      });
                    },
                    itemBuilder: (context, pagePosition) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          // height: 200,
                          color: Colors.red,
                          // margin: EdgeInsets.all(10),
                          child: Image.network(images[pagePosition],
                              fit: BoxFit.cover),
                        ),
                      );
                    }),
              ),
              Container(
                color: Colors.grey,
                height: 500,
              ),
              Container(
                color: Colors.green,
                height: 500,
              ),
              Container(
                color: Colors.grey,
                height: 500,
              ),
              Container(
                color: Colors.green,
                height: 500,
              ),
              Container(
                color: Colors.grey,
                height: 500,
              ),
              Container(
                color: Colors.green,
                height: 500,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
