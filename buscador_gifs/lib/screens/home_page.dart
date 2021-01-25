import 'package:buscador_gifs/app_config.dart';
import 'package:buscador_gifs/screens/gif_page.dart';
import 'package:buscador_gifs/services/giphy_api.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  final String title;
  final AppConfig appConfig;
  final GiphyApi giphyApi;

  HomePage({
    Key key,
    this.title,
    @required this.appConfig,
    @required this.giphyApi,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _termForSearch = "";
  int _offset = 0;

  @override
  Widget build(BuildContext context) {
    AppConfig appConfig = AppConfig.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.network(appConfig.appIconUrl),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquisar Aqui!",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              onSubmitted: _onSubmittedSeachInput,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                    break;
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Container(
                          child: Text("Error ${snapshot.error}"),
                        ),
                      );
                    } else
                      return _createGifsTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _createGifsTable(context, snapshot) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _getItemCount(snapshot.data["data"]),
        itemBuilder: (context, index) =>
            _gridItemBuilder(context, index, snapshot));
  }

  _gridItemBuilder(BuildContext context, int index, snapshot) {
    if (_termForSearch.isEmpty || index < snapshot.data["data"].length) {
      return GestureDetector(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: snapshot.data["data"][index]["images"]["fixed_height"]
                ["url"],
            height: 300.0,
            fit: BoxFit.cover,
          ),
          onTap: () => _navigateToGifPage(snapshot.data["data"][index]),
          onLongPress: () => Share.share(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"]));
    } else {
      return Container(
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 50.0,
              ),
              Text(
                "Carregar Mais...",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )
            ],
          ),
          onTap: _onTapLoadMoreGifs,
        ),
      );
    }
  }

  _navigateToGifPage(Map gifData) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GifPage(gifData)));
  }

  _onSubmittedSeachInput(String value) {
    setState(() {
      _termForSearch = value;
      _offset = 0;
    });
  }

  _onTapLoadMoreGifs() {
    setState(() {
      _offset += 19;
    });
  }

  int _getItemCount(List data) {
    return _termForSearch.isEmpty ? data.length : data.length + 1;
  }

  Future<Map> _getGifs() {
    return _termForSearch.isEmpty
        ? widget.giphyApi.trends()
        : widget.giphyApi.search(_termForSearch, _offset);
  }
}
