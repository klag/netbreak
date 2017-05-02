include "interfaces/transactions_db_readerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }


inputPort transactions_db_readerInput {
  Location: "socket://localhost:8231"
  Protocol: sodep
  Interfaces: transactions_db_readerInterface
}

inputPort transactions_db_readerJSONInput {
  Location: "socket://localhost:8131"
  Protocol: http { 
    //Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
    .response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
    .response.headers.("Access-Control-Allow-Origin") = "*";
    .response.headers.("Access-Control-Allow-Headers") = "Content-Type";
    .format = "json"
    }
  Interfaces: transactions_db_readerInterface
}

init
{
	println@Console( "Transactions Db Reader started" )();

  //connect to transactions database
  with( connectionInfo ) {
      .host = "apimtransactionsinstance.ccsrygwsp8kn.eu-west-2.rds.amazonaws.com"; 
      .driver = "mysql";
      .port = 3306;
      .database = "TransactionsDB";
      .username = "netbreakswe";
      .password = "netbreakswe"
    };
    connect@Database( connectionInfo )();
    println@Console("DB connected, connection is running on host:" + connectionInfo.host )()
}

main
{
  
  [retrieve_apikey_info( request )( response ) {

    //query
    q = "SELECT IdMS,IdClient,Remaining FROM apikeys WHERE IdAPIKey=:iak";
    q.iak = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("APIKey not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got APIKey with id "+ request.Id )();
        response.APIKeyData[i] << result.row[i]
      }
    };
    println@Console("Retrieved all info about the specific APIKey")()
  }]

  [retrieve_purchases_list( request )( response ) {

    //query
    q = "SELECT IdPurchase,Timestamp,Price,Amount FROM purchases WHERE IdClient=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Purchase not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got purchase number " + i )();
        response.PurchasesListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved purchases of the client with id " + request.Id)()
  }]

}