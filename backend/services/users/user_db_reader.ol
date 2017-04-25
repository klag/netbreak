include "user_db_readerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

/*
inputPort user_db_readerInput {
  Location: "socket://localhost:8201"
  Protocol: sodep
  Interfaces: user_db_readerInterface
}*/

inputPort user_db_readerJSONInput {
  Location: "socket://localhost:8101"
  Protocol: http { .format = "json" }
  Interfaces: user_db_readerInterface
}

init
{
	println@Console( "User Db Reader started" )();

  //connect to user database
  with( connectionInfo ) {
      .host = "apimusersdb.cpfnkeifjbmu.eu-west-2.rds.amazonaws.com"; 
      .driver = "mysql";
      .port = 3306;
      .database = "UsersDB";
      .username = "netbreakswe";
      .password = "netbreakswe"
    };
    connect@Database( connectionInfo )();
    println@Console("DB connected, connection is running on host:" + connectionInfo.host )()
}

main
{

  [retrieve_admin_info( request )( response ) {

    //query
    q = "SELECT * FROM admins WHERE IdAdmin=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Admin not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got admin "+ result.row[i].Name )();
        response.AdminData[i] << result.row[i]
      }
    };
    println@Console("Retrieved info about admin " + response.AdminData.Name + " " + response.AdminData.Surname)()
  }]

  [retrieve_client_info( request )( response ) {

    //query
    q = "SELECT IdClient,Name,Surname,Email,Password,Avatar FROM clients WHERE IdClient=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Client not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got client "+ result.row[i].Name )();
        response.ClientData[i] << result.row[i]
      }
    };
    println@Console("Retrieved info about client " + response.ClientData.Name + " " + response.ClientData.Surname)()
  }]

  [retrieve_client_type( request )( response ) {

    //query
    q = "SELECT ClientType FROM clients WHERE IdClient=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("ClientType not found")()
    }
    else {
      println@Console( "Got ClientType "+ result.row[0].ClientType )();
      response.ClientType = result.row[0].ClientType
    };
    println@Console("Retrieved client type " + response.ClientType)()
  }]

  [retrieve_moderation_info( request )( response ) {

    //query
    q = "SELECT * FROM moderationlog WHERE IdEntry=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Moderation entry not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got moderation entry "+ result.row[i].IdEntry )();
        response.EntryData[i] << result.row[i]
      }
    };
    println@Console("Retrieved entry " + response.EntryData.IdEntry)()
  }]

  [retrieve_modtype_info( request )( response ) {

    //query
    q = "SELECT * FROM moderationtypes WHERE IdModType=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Moderation type not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got moderation type "+ result.row[i].IdModType )();
        response.ModTypeData[i] << result.row[i]
      }
    };
    println@Console("Retrieved moderation type " + response.ModTypeData.IdModType)()
  }]

  [retrieve_clienttype_info( request )( response ) {

    //query
    q = "SELECT * FROM clienttypes WHERE IdClientType=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Client type not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got client type "+ result.row[i].IdClientType )();
        response.ClientTypeData[i] << result.row[i]
      }
    };
    println@Console("Retrieved client type " + response.ClientTypeData.Name)()
  }]
  
}