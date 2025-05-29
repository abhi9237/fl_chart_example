class Datum {
  int? id;
  int? pain;
  int? activity;
  int? energy;
  int? mood;
  int? sleep;
  int? muscleTension;
  DateTime? datetime;
  int? userId;

  Datum({
    this.id,
    this.pain,
    this.activity,
    this.energy,
    this.mood,
    this.sleep,
    this.datetime,
    this.muscleTension,
    this.userId,
  });

  Datum copyWith({
    int? id,
    int? pain,
    int? activity,
    int? energy,
    int? mood,
    int? sleep,
    int? muscleTension,
    DateTime? datetime,
    int? userId,
  }) =>
      Datum(
        id: id ?? this.id,
        pain: pain ?? this.pain,
        activity: activity ?? this.activity,
        energy: energy ?? this.energy,
        mood: mood ?? this.mood,
        sleep: sleep ?? this.sleep,
        muscleTension: muscleTension ?? this.muscleTension,
        datetime: datetime ?? this.datetime,
        userId: userId ?? this.userId,
      );

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    pain: json["pain"],
    activity: json["activity"],
    energy: json["energy"],
    mood: json["mood"],
    sleep: json["sleep"],
    muscleTension: json["muscle_tension"],
    datetime:
    json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
    userId: json["user_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pain": pain,
    "activity": activity,
    "energy": energy,
    "mood": mood,
    "sleep": sleep,
    "muscle_tension": muscleTension,
    "datetime": datetime?.toIso8601String(),
    "user_id": userId,
  };
}