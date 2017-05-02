include "interfaces/sla_db_readerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

inputPort sla_db_readerInput {
  Location: "socket://localhost:8211"
  Protocol: sodep
  Interfaces: sla_db_readerInterface
}

inputPort sla_db_readerJSONInput {
  Location: "socket://localhost:8111"
  Protocol: http { 
    //Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
    .response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
    .response.headers.("Access-Control-Allow-Origin") = "*";
    .response.headers.("Access-Control-Allow-Headers") = "Content-Type";
    .format = "json"
    }
  Interfaces: sla_db_readerInterface
}

init
{
	println@Console( "Sla Db Reader started" )();

  //connect to sla database
  with( connectionInfo ) {
      .host = "apimslainstance.ccsrygwsp8kn.eu-west-2.rds.amazonaws.com"; 
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
  [retrieve_apikey_slasurvey_list( request )( response ) {

    //query
    q = "SELECT Timestamp,IdMS,ResponseTime,IsCompliant FROM slasurveys WHERE IdAPIKey=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Sla surveys not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got sla survey number "+ i )();
        response.SlaSurveyListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved sla survey complete list about the specific API key " + request.Id)()
  }]

  [retrieve_ms_slasurvey_list( request )( response ) {

    //query
    q = "SELECT Timestamp,ResponseTime,IsCompliant FROM slasurveys WHERE IdMS=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Sla surveys not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got sla survey number "+ i )();
        response.SlaSurveyListMSData[i] << result.row[i]
      }
    };
    println@Console("Retrieved sla survey complete list about the specific microservice " + request.Id)()
  }]

  [retrieve_slasurvey_info( request )( response ) {

    //query
    q = "SELECT IdSLASurvey,IdMS,Timestamp,ResponseTime,IsCompliant FROM slasurveys WHERE IdSLASurvey=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Sla survey not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got sla survey "+ result.row[i].IdSLASurvey )();
        response.SlaSurveyData[i] << result.row[i]
      }
    };
    println@Console("Retrieved info about sla survey " + response.SlaSurveyData.IdSLASurvey)()
  }]

  [retrieve_slasurvey_iscompliant( request )( response ) {

    //query
    q = "SELECT IsCompliant FROM slasurveys WHERE IdSLASurvey=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Sla survey not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got IsCompliant with result "+ result.row[i].IsCompliant )();
        response.IsCompliantData[i] << result.row[i]
      }
    };
    println@Console("Retrieved IsCompliant with result " + response.IsCompliantData.IsCompliant + " from sla survey " + request.Id)()
  }]

}