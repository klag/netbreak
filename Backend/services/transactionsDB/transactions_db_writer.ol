include "interfaces/transactions_db_writerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

inputPort transactions_db_writerInput {
  Location: "socket://localhost:8231"
  Protocol: sodep
  Interfaces: transactions_db_writerInterface
}

inputPort transactions_db_writerJSONInput {
  Location: "socket://localhost:8131"
  Protocol: http { 
    //Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
    .response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
    .response.headers.("Access-Control-Allow-Origin") = "*";
    .response.headers.("Access-Control-Allow-Headers") = "Content-Type";
    .format = "json"
    }
  Interfaces: transactions_db_writerInterface
}

init
{
  println@Console( "Transactions Db Writer started" )();

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

  [apikey_registration( request )( response ) {

    //query
    q = "INSERT INTO apikeys (IdMS,IdClient,Remaining) VALUES (:ims,:ic,:r)";
    with( request ) {
      q.ims = .IdMS;
      q.ic = .IdClient;
      q.r = .Remaining
    };
    update@Database( q )( result );
    println@Console( "Registering new apikey for microservice " + request.IdMS + " by client " + request.IdClient )()
  }]

  [purchase_registration( request )( response ) {

    //query
    q = "INSERT INTO purchases (IdAPIKey,IdClient,Timestamp,Price,Amount) VALUES (:iak,:ic,:t,:p,:a)";
    with( request ) {
      q.iak = .IdAPIKey;
      q.ic = .IdClient;
      q.t = .Timestamp;
      q.p = .Price;
      q.a = .Amount
    };
    update@Database( q )( result );
    println@Console( "Registering new purchase with apikey " + request.IdAPIKey + " by client " + request.IdClient )()
  }]

  [apikey_remaining_update( request )( response ) {

    //query
    q = "UPDATE apikeys SET Remaining=Remaining+:n WHERE IdAPIKey=:i";
    with( request ) {
      q.i = .IdAPIKey;
      q.n = .Number
    };
    update@Database( q )( result );
    println@Console( "Updating remaining of APIKey " + request.IdAPIKey )()
  }]
}