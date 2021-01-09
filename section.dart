class Section {
  String stage;
  String id_stage;
  String  id_teacher;
  Section( Map map){
    this.stage=map['stage'];
    this.id_stage=map['id_stage'];
    this.id_teacher=map['id_teacher'];

  }
}