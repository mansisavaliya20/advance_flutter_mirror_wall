import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall_m/provider/connect_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? inAppWebViewController;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  int selectpage = 1;
  List bookmark = [];
  List urlbookmark = [];
  String url = "https://www.google.com/";
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ConnectProvider>(context, listen: false).chechInternet();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        // popup menu button
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.bookmark),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("All Bookmarks")
                  ],
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(Icons.image_search_rounded),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Search Engine")
                  ],
                ),
              ),
            ],
            elevation: 2,
            onSelected: (selectpage) {
              setState(() {
                selectpage = selectpage;
              });
              if (selectpage == 1) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 750,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Dismiss",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              child: (bookmark.isNotEmpty)
                                  ? ListView.builder(
                                      itemCount: bookmark.length,
                                      itemBuilder: (context, i) => ListTile(
                                        onTap: () {
                                          setState(() {
                                            inAppWebViewController?.loadUrl(
                                              urlRequest:
                                                  URLRequest(url: bookmark[i]),
                                            );
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        title: Text("${urlbookmark[i]}"),
                                        subtitle: Text("${bookmark[i]}"),
                                        trailing: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              bookmark.remove(bookmark[i]);
                                              urlbookmark
                                                  .remove(urlbookmark[i]);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text("No any bookmark yet..."),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (selectpage == 2) {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Search Engine"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            title: Text("Google"),
                            value: "https://www.google.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                search.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Yahoo"),
                            value: "https://in.search.yahoo.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                search.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Bing"),
                            value: "https://www.bing.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                search.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Duck Duck Go"),
                            value: "https://duckduckgo.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                search.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
            },
          ),
        ],

        centerTitle: true,
      ),
      body: (Provider.of<ConnectProvider>(context).connectModel.connectStatus ==
              "Waiting")
          ? Center(
              child: Text("Not Connection"),
            )
          : Column(
              children: [
                Expanded(
                  flex: 9,
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: Uri.parse("https://www.google.com/"),
                    ),
                    onLoadStart: (controller, uri) {
                      setState(() {
                        inAppWebViewController = controller;
                      });
                    },
                    onLoadStop: (controller, uri) {},
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "Search Web address",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                          ),
                          onPressed: () {
                            String newLink = search.text;
                            var s;
                            inAppWebViewController?.loadUrl(
                                urlRequest: URLRequest(
                                    url: Uri.parse("${url}search?q=${s}")));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await inAppWebViewController?.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse(url),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        urlbookmark.add(
                          await inAppWebViewController?.getTitle(),
                        );
                        bookmark.add(
                          await inAppWebViewController?.getUrl(),
                        );
                      },
                      icon: Icon(
                        Icons.bookmark_add,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await inAppWebViewController!.canGoBack()) {
                          await inAppWebViewController?.goBack();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.refresh,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await inAppWebViewController!.canGoForward()) {
                          await inAppWebViewController?.goForward();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                    ),
                  ],
                ))
              ],
            ),
    );
  }
}
