class Stage{
  String name_stage;
  String id_stage;
  String id_teacher;

  stage(Map map){
    this.name_stage=map['stage'];
    this.id_stage=map['id_stage'];
    this.id_teacher=map['id_teacher'];

  }


}