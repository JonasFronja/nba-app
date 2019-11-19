import 'dart:convert';

Teams teamsFromJson(String str) => Teams.fromJson(json.decode(str));

String teamsToJson(Teams data) => json.encode(data.toJson());

class TeamsList{
  List<Teams> teams;

  TeamsList({this.teams});

  TeamsList.fromJson(Map<String, dynamic> json) {
    json = json['league'];
    print(json);
    if (json['standard'] != null) {
      teams = new List<Teams>();
      json['standard'].forEach((v) {
        if(v['isNBAFranchise']){
          if(v['tricode'] == 'NOP')v['tricode'] = 'NO';
          if(v['tricode'] == 'UTA')v['tricode'] = 'UTAH';
          teams.add(new Teams.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teams != null) {
      data['standard'] = this.teams.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
    bool isNbaFranchise;
    bool isAllStar;
    String city;
    String altCityName;
    String fullName;
    String tricode;
    String teamId;
    String nickname;
    String urlName;
    String teamShortName;
    String confName;
    String divName;

    Teams({
        this.isNbaFranchise,
        this.isAllStar,
        this.city,
        this.altCityName,
        this.fullName,
        this.tricode,
        this.teamId,
        this.nickname,
        this.urlName,
        this.teamShortName,
        this.confName,
        this.divName,
    });

    factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        isNbaFranchise: json["isNBAFranchise"],
        isAllStar: json["isAllStar"],
        city: json["city"],
        altCityName: json["altCityName"],
        fullName: json["fullName"],
        tricode: json["tricode"],
        teamId: json["teamId"],
        nickname: json["nickname"],
        urlName: json["urlName"],
        teamShortName: json["teamShortName"],
        confName: json["confName"],
        divName: json["divName"],
    );

    Map<String, dynamic> toJson() => {
        "isNBAFranchise": isNbaFranchise,
        "isAllStar": isAllStar,
        "city": city,
        "altCityName": altCityName,
        "fullName": fullName,
        "tricode": tricode,
        "teamId": teamId,
        "nickname": nickname,
        "urlName": urlName,
        "teamShortName": teamShortName,
        "confName": confName,
        "divName": divName,
    };
}
