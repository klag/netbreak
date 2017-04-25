include "sla_db_writerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

inputPort sla_db_writerInput {
  Location: "socket://localhost:8212"
  Protocol: sodep
  Interfaces: sla_db_writerInterface
}

inputPort sla_db_writerJSONInput {
  Location: "socket://localhost:8112"
  Protocol: http { .format = "json" }
  Interfaces: sla_db_writerInterface
}

init
{
  println@Console( "Sla Db Reader started" )();

  //connect to sla database
  with( connectionInfo ) {
      .host = "apimsladb.cpfnkeifjbmu.eu-west-2.rds.amazonaws.com"; 
      .driver = "mysql";
      .port = 3306;
      .database = "SLADB";
      .username = "netbreakswe";
      .password = "netbreakswe"
    };
    connect@Database( connectionInfo )();
    println@Console("DB connected, connection is running on host:" + connectionInfo.host )()
}

main
{

  [slasurvey_insert( request )( response ) {

    //query
    q = "INSERT INTO slasurveys (IdAPIKey,IdMS,Timestamp,ResponseTime,IsCompliant) 
      VALUES (:iak,:ims,:ts,:rt,:ic)";
    with( request ) {
      q.iak = .IdAPIKey;
      q.ims = .IdMS;
      q.ts = .Timestamp;
      q.rt = .ResponseTime;
      q.ic = .IsCompliant
    };
    update@Database( q )( result );
    println@Console("Inserting new sla survey about microservice " + request.IdMS )()
  }]

}