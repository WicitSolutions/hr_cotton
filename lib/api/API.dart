import 'dart:convert';

import 'package:http/http.dart';

class API {
  late String username, password;
  late bool isAuthorized;
  late List<List<dynamic>> filters;
  late List<dynamic> inventories = [];

  Future<void> getUser(String username, String password) async {
    await read(Uri.parse(
            'https://hrcottonbooks.com/mobile/api/login.php?username=$username&password=$password'))
        .then((contents) {
      isAuthorized = (contents == "loggedin" ? true : false);
    });
  }

  String createUrlParameters(String name, List<int> data) {
    String url = "";
    url += "$name=";
    if(data.isNotEmpty) {
      url += "'";
      for (int i = 0; i <= data.length-1; i++) {
        url += data[i].toString();
        if(i < data.length-1) {
          url += ",";
        }
        /*if (i <= data.length-1) {
          url += "${data[i].toString()},";
        } else {
          url += data[i].toString();
        }*/
      }
      url += "'";
    } else {
      url += "null";
    }

    return url;
  }

  Future<void> getFilters() async {
    Response response = await get(Uri.parse(
        "https://hrcottonbooks.com/mobile/api/getinventoriesfilters.php"));
    Map data = jsonDecode(response.body);

    List<dynamic> warehouses = data["Data"][0]['warehouses'];
    List<dynamic> foodServices = data["Data"][0]['foodservices'];
    List<dynamic> healthcare = data["Data"][0]['healthcare'];
    List<dynamic> hospitality = data["Data"][0]['hospitality'];
    List<dynamic> automotive = data["Data"][0]['automative'];
    List<dynamic> ymca = data["Data"][0]['ymca'];
    List<dynamic> promotionalTowel = data["Data"][0]['promotionaltowel'];
    List<dynamic> vendors = data["Data"][0]['vendors'];
    List<dynamic> itemCodes = data["Data"][0]['itemcodes'];

    filters = [
      warehouses,
      foodServices,
      healthcare,
      hospitality,
      automotive,
      ymca,
      promotionalTowel,
      vendors,
      itemCodes
    ];
  }

  Future<void> getInventories(List<dynamic> args) async {
    List<int> whIds, fsIds, hcIds, hiIds, aIds, ymcaIds, ptIds, vIds, icIds;
    String url = "https://hrcottonbooks.com/mobile/api/inventories.php?";

    if (args.isNotEmpty) {
      whIds = args[0] ?? [];
      fsIds = args[1] ?? [];
      hcIds = args[2] ?? [];
      hiIds = args[3] ?? [];
      aIds = args[4] ?? [];
      ymcaIds = args[5] ?? [];
      ptIds = args[6] ?? [];
      vIds = args[7] ?? [];
      icIds = args[8] ?? [];

      // whIds in url
      url += createUrlParameters("WhIds", whIds);
      /*if(whIds.isNotEmpty) {
        for (int i = 0; i <= whIds.length; i++) {
          if (i <= whIds.length) {
            url += "${whIds[i].toString()},";
          } else {
            url += whIds[i].toString();
          }
        }
      } else {
        url += "null";
      }*/

      url += createUrlParameters("&FsIds", fsIds);
      url += createUrlParameters("&HcIds", hcIds);
      url += "&HIds=null";
      url += createUrlParameters("&HiIds", hiIds);
      url += createUrlParameters("&AIds", aIds);
      url += createUrlParameters("&YmcaIds", ymcaIds);
      url += createUrlParameters("&PtlIds", ptIds);
      url += createUrlParameters("&VIds", vIds);
      url += createUrlParameters("&IIds", icIds);

      url += "&PtIds=null&CIds=null&description=null&isstockonly=0&isstockonlyallitems=0&allitemsonwater=0";

    } else {
      url += createUrlParameters("WhIds", []);
      url += createUrlParameters("&FsIds", []);
      url += createUrlParameters("&HcIds", []);
      url += "&HIds=null";
      url += createUrlParameters("&HiIds", []);
      url += createUrlParameters("&AIds", []);
      url += createUrlParameters("&YmcaIds", []);
      url += createUrlParameters("&PtlIds", []);
      url += createUrlParameters("&VIds", []);
      url += createUrlParameters("&IIds", []);
      url += "&PtIds=null&CIds=null&description=null&isstockonly=0&isstockonlyallitems=0&allitemsonwater=0";
    }

    Response response = await get(Uri.parse(url));
    inventories = await jsonDecode(response.body);
  }
}
