import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:newsapp/model/categories_news_model.dart';
import 'package:newsapp/model/news_headlines_api_model.dart';
import 'package:newsapp/view/categories.dart';
import 'package:newsapp/view/news_details_screen.dart';
import 'package:newsapp/view_model/news_view_model.dart';

import '../model/categories_news_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum filterList {
  aljazeera,
  bbcNews,
  cnnNews,
  foxNews,
  googleNews,
  aryNews,
  independent,
  nbcNews
}

class _HomeState extends State<Home> {
  NewsViewModel newsViewModel = NewsViewModel();
  filterList? selectedFilter;
  final formate = DateFormat('EEE, d/M/y');
  String name = "bbc-news";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                //navigate to the category screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()));
              },
              icon: Icon(
                Icons.apps_sharp,
                size: 30,
                color: Colors.blueGrey[900],
              )),
          title: Text(
            "BaKhabbar News",
            style: GoogleFonts.roboto(
                letterSpacing: .4,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.deepOrange[600]),
          ),
          actions: [
            PopupMenuButton<filterList>(
                initialValue: selectedFilter,
                icon: Icon(Icons.more_vert_rounded,
                    size: 30, color: Colors.blueGrey[900]),
                onSelected: (filterList item) {
                  if (filterList.bbcNews.name == item.name) {
                    name = "bbc-news";
                  }
                  if (filterList.cnnNews.name == item.name) {
                    name = "cnn";
                  }
                  if (filterList.aryNews.name == item.name) {
                    name = "ary-news";
                  }
                  if (filterList.aljazeera.name == item.name) {
                    name = "al-jazeera-english";
                  }
                  setState(() {});
                },
                itemBuilder: ((context) => <PopupMenuEntry<filterList>>[
                      const PopupMenuItem<filterList>(
                          value: filterList.bbcNews, child: Text("BBC News")),
                      const PopupMenuItem(
                          value: filterList.cnnNews, child: Text("CNN News")),
                      const PopupMenuItem(
                          value: filterList.aryNews, child: Text("Ary News")),
                      const PopupMenuItem(
                          value: filterList.aljazeera,
                          child: Text("Al Jazeera News")),
                    ]))
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.more_vert_rounded,
            //       size: 30,
            //       color: Colors.blueGrey[900],
            //     ))
          ],
          // centerTitle: true,
          // backgroundColor: Colors.transparent,
          // elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 7,
              child: FutureBuilder<NewsHeadlineApiModel>(
                  future: newsViewModel.fetchNewsHeadlineApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: SpinKitFadingFour(
                        color: Colors.deepOrange[400],
                      ));
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (snapshot.data!.articles != null
                              ? snapshot.data!.articles!.length
                              : 0),
                          // itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt!
                                .toString());
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetailsScreen(
                                              newsImg: snapshot.data!
                                                  .articles![index].urlToImage!
                                                  .toString(),
                                              newsTile: snapshot
                                                  .data!.articles![index].title!
                                                  .toString(),
                                              newsDesc: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt!
                                                  .toString(),
                                              newsContent: snapshot.data!
                                                  .articles![index].content!
                                                  .toString(),
                                              source: snapshot
                                                  .data!
                                                  .articles![index]
                                                  .source!
                                                  .name!
                                                  .toString(),
                                              author: snapshot.data!
                                                  .articles![index].author!
                                                  .toString(),
                                            )));
                              },
                              child: Column(
                                children: [
                                  Stack(
                                      // alignment: Alignment.center,
                                      children: [
                                        Container(
                                            height: height * 0.55,
                                            width: width * 0.97,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * .02),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .urlToImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) {
                                                  return Center(
                                                      child: SpinKitFadingFour(
                                                    color:
                                                        Colors.deepOrange[400],
                                                  ));
                                                },
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                        Positioned(
                                          bottom: height * 0.02,
                                          left: width * 0.08,
                                          right: width * 0.08,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            elevation: 10,
                                            child: Container(
                                              height: height * 0.22,
                                              alignment: Alignment.bottomCenter,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.7,
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .title!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                          letterSpacing: .4,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors
                                                              .deepOrange[600]),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .source!
                                                              .name!,
                                                        ),
                                                        Text(
                                                          formate
                                                              .format(dateTime),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),

                                  // this is code the
                                ],
                              ),
                            );
                          });
                      // If there is internet connection issue. To show the message
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return const Center(
                        child: Text(
                            "Error: Make sure you are connected to internet"),
                      );
                    } else {
                      return const Center(
                        child: Text("No data available"),
                      );
                    }
                  }),
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchNewsCategoryApi("general"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: SpinKitFadingFour(
                        color: Colors.deepOrange[400],
                        size: 50,
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      //filter the articals that have images. non image articals are not displayed
                      List articlesWithImage = snapshot.data!.articles!
                          .where((element) =>
                              element.urlToImage != null &&
                              element.urlToImage!.isNotEmpty)
                          .toList();
                      return ListView.builder(
                          itemCount: articlesWithImage.length,
                          itemBuilder: (context, index) {
                            if (kDebugMode) {
                              print(
                                  "Data: ${snapshot.data!.articles![index].description}");
                            }
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 0.02),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetailsScreen(
                                                  newsImg:
                                                      articlesWithImage[index]
                                                          .urlToImage
                                                          .toString(),
                                                  newsTile:
                                                      articlesWithImage[index]
                                                          .title
                                                          .toString(),
                                                  newsDesc:
                                                      articlesWithImage[index]
                                                          .description
                                                          .toString(),
                                                  newsDate:
                                                      articlesWithImage[index]
                                                          .publishedAt
                                                          .toString(),
                                                  newsContent:
                                                      articlesWithImage[index]
                                                          .content
                                                          .toString(),
                                                  source:
                                                      articlesWithImage[index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                  author:
                                                      articlesWithImage[index]
                                                          .author
                                                          .toString(),
                                                ))),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: articlesWithImage[index]
                                                .urlToImage
                                                .toString(),
                                            height: height * .15,
                                            width: width * .3,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Center(
                                                  child: SpinKitFadingFour(
                                                color: Colors.deepOrange[400],
                                              ));
                                            },
                                            errorWidget: (context, url, error) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * 0.1,
                                                
                                                child: Text(
                                                  articlesWithImage[index]
                                                      .title
                                                      .toString(),
                                                ),
                                              ),
                                              Text(
                                                articlesWithImage[index]
                                                    .author
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}
