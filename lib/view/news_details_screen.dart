import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImg,
      newsTile,
      newsDesc,
      newsDate,
      newsContent,
      source,
      author;
      
      
   const NewsDetailsScreen(
      {super.key,
      required this.newsImg,
      required this.newsTile,
      required this.newsDesc,
      required this.newsDate,
      required this.newsContent,
      required this.source,
      required this.author});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final formate = DateFormat('EEE, d/M/y');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: widget.newsImg,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return SpinKitFadingFour(
                    color: Colors.deepOrange[400],
                  );
                },
                errorWidget: (context, url, error) {
                 
                  return const Center(child: Column(
                    children: [
                      Icon(Icons.error, color: Colors.red,size: 60,),
                      Text("No Image Found",style: TextStyle(color: Colors.red),)
                    ],
                  ));
                },
              ),
            ),
          ),
          SizedBox(
            height: height * .1,
          ),
          Container(
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: ListView(
              children: [
                Text(
                  widget.newsTile,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(widget.source ,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text(formate.format(dateTime),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: height * .02),
                Text(widget.newsDesc, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                SizedBox(height: height * .01),
                Text(widget.newsContent, style: const TextStyle(fontSize: 15)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
