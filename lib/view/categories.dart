import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/view/news_details_screen.dart';
import 'package:newsapp/view_model/news_view_model.dart';

import '../model/categories_news_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final formate = DateFormat('EEE, d/M/y');
  String categoryName = "general";
  //create a categories list
  List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.characters.first.toUpperCase() +
            categoryName.substring(1)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = categories[index];
                      // if (kDebugMode) {
                      //   print("Category Name: $categoryName");
                      // }
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == categories[index]
                              ? Colors.blueGrey[900]
                              : Colors.deepOrange[400],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                              child: Text(
                            categories[index].characters.first.toUpperCase() +
                                categories[index].substring(1),
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 16),
                          )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchNewsCategoryApi(categoryName),
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
                      List<Articles> articlesWithImage = snapshot.data!.articles!
                          .where((element) => element.urlToImage !=null &&
                              element.urlToImage!.isNotEmpty)
                          .toList();
                          
                      return ListView.builder(
                          itemCount: articlesWithImage.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(articlesWithImage[index].publishedAt!
                                .toString());
                            // if (kDebugMode) {
                            //   print(
                            //       "Data: ${snapshot.data!.articles![index].description}");
                            // }
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 0.02),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NewsDetailsScreen(
                                                newsImg: articlesWithImage[index].urlToImage
                                                    .toString(),
                                                newsTile: articlesWithImage[index].title
                                                    .toString(),
                                                newsDesc: articlesWithImage[index]
                                                    .description
                                                    .toString(),
                                                newsDate: articlesWithImage[index]
                                                    .publishedAt
                                                    .toString(),
                                                newsContent: articlesWithImage[index].content
                                                    .toString(),
                                                source: articlesWithImage[index].source!.name.toString(),
                                                author: articlesWithImage[index].author.toString(),
                                               
                                                ))),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: articlesWithImage[index].urlToImage
                                                .toString(),
                                            height: height * .18,
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
                                            child: Container(
                                          height: height * 0.18,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                articlesWithImage[index]
                                                    .title
                                                    .toString(),
                                              ),
                                              
                                             Expanded(
                                               child: Row(
                                                children: [
                                                  Text(articlesWithImage[index].source!.name.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500
                                                    
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  
                                                  Text(
                                                    formate.format(dateTime),
                                                     style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500
                                                    
                                                    ),
                                                  )
                                                ],
                                               ),
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
        ),
      ),
    );
  }
}
