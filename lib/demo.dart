import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Demo extends StatelessWidget {
  late String scan_url = "";
  TextEditingController _controller = TextEditingController();

  void print_banner() {
    double version = 0.1;
    print("""                .                                           """);
    print("""              .o8                                           """);
    print("""oooo    ooo .o888oo  .oooo.o  .ooooo.   .oooo.   ooo. .oo.  """);
    print(""" `88.  .8'    888   d88(  "8 d88' `"Y8 `P  )88b  `888P"Y88b """);
    print("""  `88..8'     888   `"Y88b.  888        .oP"888   888   888 """);
    print("""   `888'      888 . o.  )88b 888   .o8 d8(  888   888   888 """);
    print("""    `8'       "888" 8""888P' `Y8bod8P' `Y888""8o o888o o888o""");
    print("");
    print("Author: ${version}");
    print("");
  }

  String check_apikey(String api_key) {
    if (api_key.length == 64) {
      return api_key;
    } else {
      print("Wrong API Key.");
      return "";
    }
  }

  String check_hash_length(String hashes) {
    if (hashes.length == 32) {
      return hashes;
    } else if (hashes.length == 48) {
      return hashes;
    } else if (hashes.length == 64) {
      return hashes;
    } else {
      print(
          "This hash input is missing or invalid. Note: MD5 is 32 digits long, SHA-1 is 48 digits long and SHA-256 is 64 digits long.");
      return "";
    }
  }

  String check_url(String url) {
    return url;
  }

  String check_ip(ipaddr) {
    return ipaddr;
  }

  void VT_URL(String urlScan) async {
    String api_key =
        '';
    var response;
    var url_scan = Uri.https('www.virustotal.com', 'vtapi/v2/url/scan');
    var url_scan_report =
        Uri.https('www.virustotal.com', '/vtapi/v2/url/report');
    Map result;
    if (urlScan.length != 0) {
      response = await http
          .post(url_scan, body: {"apikey": "$api_key", "url": "$urlScan"});
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        print(result);
        response = await http.post(url_scan_report,
            body: {"apikey": "$api_key", "resource": result["resource"]});
        if (response.statusCode == 200) {
          result = jsonDecode(response.body);
          print(result);
        } else {
          print('Istek Hatasi');
        }
      } else {
        print('Istek Hatası');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo Application",
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("VTscan Mobile"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Koddaki VT_URL fonksiyonu ile belirtilen url adresine tarama yapar.',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Enter URL',
                    hintText: 'URL Address'),
                controller: _controller,
                onChanged: (text) {
                  scan_url = text;
                },
              ),
            ),
            FlatButton(
              onPressed: () {
                VT_URL(scan_url);
                _controller.clear();
              },
              child: Text(
                'Scan',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
