import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:movies_app/pages/detail_page.dart';

class MyMovieList extends StatefulWidget {
  // final String movieType;

  const MyMovieList({super.key});

  @override
  State<MyMovieList> createState() => _MyMovieListState();
}

class _MyMovieListState extends State<MyMovieList> with AutomaticKeepAliveClientMixin{
  int page = 1;
  int pageSize = 10;
  List<Map<String, String>> movieList = [];
  int total = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  id: index,
                  title: movieList[index]['title'].toString(),
                ),
              ),
            );
          },
          child: Column(
            children: [
              const Divider(
                color: Color.fromARGB(255, 136, 138, 150),
                indent: 4,
                endIndent: 4,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const SizedBox(width: 100, height: 130),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movieList[index]['title'].toString(),
                          softWrap: true),
                      Text(movieList[index]['link'].toString(), softWrap: true),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getMovieList() async {
    // 发送 GET 请求
    final response =
        await http.get(Uri.parse('https://movie.douban.com/chart'));

    // 检查请求是否成功
    if (response.statusCode == 200) {
      // 解析 HTML 文档
      var document = parser.parse(response.body);

      // 查找电影数据
      List<dom.Element> movieElements = document.querySelectorAll('.pl2 a');

      setState(() {
        // 转换 movieElements 为一个包含标题和链接的列表
        movieList = movieElements.map((movieElement) {
          String title = movieElement.text.replaceAll('\n', '').trim();
          title = title.replaceAll("  ", ' ');
          title = title.replaceAll("  ", ' ');
          title = title.replaceAll("  ", ' ');
          title = title.replaceAll("  ", ' ');
          title = title.replaceAll("  ", ' ');
          String link = movieElement.attributes['href'] ?? '';
          return {
            'title': title,
            'link': link,
          };
        }).toList();
      });
    } else {
      print('请求失败，状态码: ${response.statusCode}');
    }
  }
}
