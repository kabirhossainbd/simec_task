import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_task/model/response.dart';

class DetailsScreen extends StatefulWidget {
  final Items items;
  const DetailsScreen({super.key, required this.items});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  

  

  @override
  Widget build(
  BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Details Screen'
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            if(widget.items.owner != null)...[
              Hero(
                tag: '-image${widget.items.hashCode}',
                child: CachedNetworkImage(
                  imageUrl:
                  widget.items.owner!.avatarUrl ?? '',
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 12,),
             Padding(padding: const EdgeInsets.all(16),
             child: Column( crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 GestureDetector(child: Text(widget.items.owner!.url ??"")),
                 const SizedBox(height: 8,),
                 Text(widget.items.owner!.eventsUrl ??""),
                 const SizedBox(height: 8,),
                 Text(widget.items.owner!.followersUrl ??""),
                 const SizedBox(height: 8,),
                 Text(widget.items.owner!.gistsUrl ??""),
               ],
             ),)
            ],

            if(widget.items.topics != null && widget.items.topics!.isNotEmpty)...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  children: widget.items.topics!.map((item){
                    return Text(item);
                  }).toList(),
                ),
              )
            ],

              Padding(
                padding: const EdgeInsets.fromLTRB(16,0,16,8),
                child: Text(
                  widget.items.description ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                )
              ),

            const SizedBox(height: 8,),

          ],
        ),
      ),
    );
  }
}
