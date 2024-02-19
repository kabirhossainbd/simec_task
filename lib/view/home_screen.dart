

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/controller.dart';
import 'package:test_task/utils/helper.dart';
import 'package:test_task/view/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode= FocusNode();

  @override
  void initState() {
   //Get.find<HomeController>().getApiCall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
            
                 // for search data
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200)
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      hintText: "Write something..."
                    ),
                    // onChanged: home.searchItem,
                    onSubmitted: home.getSearchApiCall,
                  ),
                ),
            
                const SizedBox(height: 16,),
            

                /// for show list data
                if(home.isItemEmpty)...[
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                ]else if(home.searchItemsList.isNotEmpty)...[
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: home.searchItemsList.length,
                        itemBuilder: (_, index){
                          return GestureDetector(
                            onTap:(){
                             Get.to(DetailsScreen(items: home.searchItemsList[index],));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Row(
                                children: [
                                  if(home.searchItemsList[index].owner != null)...[
                                    Hero(
                                      tag: '-image${home.searchItemsList[index].hashCode}',
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: home.searchItemsList[index].owner!.avatarUrl ?? "",
                                          height: 48,
                                          width: 48,
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(width: 6,),
                                  Expanded(
                                    child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                                      children: [
                                        Text(home.searchItemsList[index].owner!.id.toString()),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: (){
                                              customUrl(home.searchItemsList[index].owner!.url ?? "");
                                            },
                                            child: Text(home.searchItemsList[index].owner!.url ?? '', style: const TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ]else if(home.searchItemsList.isEmpty)...[
                   const Expanded(
                    child: Center(child: Text('No Data Found', style: TextStyle(color: Colors.grey, fontSize: 16), textAlign: TextAlign.center,)),
                  )
                ],
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
