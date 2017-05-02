include "microservices_db_readerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }


inputPort microservices_db_readerInput {
  Location: "socket://localhost:8221"
  Protocol: sodep
  Interfaces: microservices_db_readerInterface
}

inputPort microservices_db_readerJSONInput {
  Location: "socket://localhost:8121"
  Protocol: http { 
    //Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
    .response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
    .response.headers.("Access-Control-Allow-Origin") = "*";
    .response.headers.("Access-Control-Allow-Headers") = "Content-Type";
      .format = "json"
      }
  Interfaces: microservices_db_readerInterface
}

init
{
	println@Console( "Microservices Db Reader started" )();

  //connect to microservices database
  with( connectionInfo ) {
      .host = "apimmicroservicesinstance.ccsrygwsp8kn.eu-west-2.rds.amazonaws.com"; 
      .driver = "mysql";
      .port = 3306;
      .database = "MicroservicesDB";
      .username = "netbreakswe";
      .password = "netbreakswe"
    };
    connect@Database( connectionInfo )();
    println@Console("DB connected, connection is running on host:" + connectionInfo.host )()
}

main
{
  
  [retrieve_ms_info( request )( response ) {

    //query
    q = "SELECT * FROM microservices WHERE IdMS=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Microservice not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got microservice with id "+ request.Id )();
        response.MSData[i] << result.row[i]
      }
    };
    println@Console("Retrieved all info about microservice " + response.MSData.Name)()
  }]

  [retrieve_intf_info( request )( response ) {

    //query
    q = "SELECT Interf,Loc,Protoc FROM interfaces WHERE IdInterface=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Interface not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got interface with id " + request.Id )();
        response.IntfData[i] << result.row[i]
      }
    };
    println@Console("Retrieved interface gateway info (interface)(location:" + response.IntfData.Loc + ")(protocol" 
      + response.IntfData.Protoc + ")" )()
  }]

  [retrieve_interfaces_of_ms( request )( response ) {

    //query
    q = "SELECT IdInterface FROM interfaces WHERE IdMS=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Microservice not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got interface number " + i )();
        response.IntfIdListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved interfaces of the microservice with id " + request.Id)()
  }]

  [retrieve_ms_from_interface( request )( response ) {

    //query
    q = "SELECT IdMS FROM interfaces WHERE IdInterface=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Microservice not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got microservice "+ result.row[i].IdMS )();
        response.MSIdData[i] << result.row[i]
      }
    };
    println@Console("Retrieved microservice " + response.MSIdData.IdMS + " from interface " + request.Id)()
  }]

  [retrieve_category_info( request )( response ) {

    //query
    q = "SELECT Name,Image FROM categories WHERE IdCategory=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Category not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got category with id "+ request.Id )();
        response.CategoryData[i] << result.row[i]
      }
    };
    println@Console("Retrieved category " + response.CategoryData.Name)()
  }]

  [retrieve_categories_of_ms( request )( response ) {

    //query
    q = "SELECT IdCategory FROM jnmscat WHERE IdMS=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Microservice not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got category number " + i )();
        response.CategoryIdListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved categories of the microservice with id" + request.Id)()
  }]

  [retrieve_last_registered_ms( request )( response ) {

    //query
    q = "SELECT Name,Logo FROM microservices ORDER BY LastUpdate DESC LIMIT :l";
    q.l = request.number;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Last microservices list not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got microservice number " + i )();
        response.MSRegListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved last registered microservices")()
  }]
}