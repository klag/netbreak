include "interfaces/microservices_db_writerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

inputPort microservices_db_writerInput {
  Location: "socket://localhost:8221"
  Protocol: sodep
  Interfaces: microservices_db_writerInterface
}

inputPort microservices_db_writerJSONInput {
  Location: "socket://localhost:8121"
  Protocol: http { 
    //Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
    .response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
    .response.headers.("Access-Control-Allow-Origin") = "*";
    .response.headers.("Access-Control-Allow-Headers") = "Content-Type";
    .format = "json"
    }
  Interfaces: microservices_db_writerInterface
}

init
{
  println@Console( "Microservices Db Writer started" )();

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

  [microservice_registration( request )( response ) {

    //query
    q = "INSERT INTO microservices (Name,Description,Version,LastUpdate,IdDeveloper,Logo,DocPDF,DocExternal,Profit,
      IsActive,SLAGuaranteed,Policy) VALUES (:n,:d,:v,:lu,:idv,:lg,:dp,:de,:pf,:isa,:sg,:py)";
    with( request ) {
      q.n = .Name;
      q.d = .Description;
      q.v = .Version;
      q.lu = .LastUpdate;
      q.idv = .IdDeveloper;
      q.lg = .Logo;
      q.dp = .DocPDF;
      q.de = .DocExternal;
      q.pf = .Profit;
      q.isa = .IsActive;
      q.sg = .SLAGuaranteed;
      q.py = .Policy
    };
    update@Database( q )( result );
    println@Console( "Registering new microservice with name " + request.Name + " by developer " + request.IdDeveloper )()
  }]

  [microservice_update( request )( response ) {

    //query
    q = "UPDATE microservices SET Name=:n,Description=:d,Version=:v,LastUpdate=:lu,Logo=:lg,DocPDF=:dp,
      DocExternal=:de,Profit=:pf,SLAGuaranteed=:sg WHERE IdMS=:i";
    with( request ) {
      q.i = .IdMS;
      q.n = .Name;
      q.d = .Description;
      q.v = .Version;
      q.lu = .LastUpdate;
      q.lg = .Logo;
      q.dp = .DocPDF;
      q.de = .DocExternal;
      q.pf = .Profit;
      q.sg = .SLAGuaranteed
    };
    update@Database( q )( result );
    println@Console("Updating microservice with id " + request.IdMS)()
  }]

  [interface_registration( request )( response ) {

    //query
    q = "INSERT INTO interfaces (IdMS,Interf,Loc,Protoc) VALUES (:ims,:ii,:l,:p)";
    with( request ) {
      q.ims = .IdMS;
      q.ii = .Interf;
      q.l = .Loc;
      q.p = .Protoc
    };
    update@Database( q )( result );
    println@Console( "Registering new interface of microservice " + request.IdMS )()
  }]

  [interface_update( request )( response ) {

    //query
    q = "UPDATE interfaces SET Interf=:i,Loc=:l,Protoc=:p WHERE IdInterface=:ii";
    with( request ) {
      q.ii = .IdInterface;
      q.i = .Interf;
      q.l = .Loc;
      q.p = .Protoc
    };
    update@Database( q )( result );
    println@Console( "Updating interface " + request.IdInterface )()
  }]

  [add_category_to_ms( request )( response ) {

    //query
    q = "INSERT INTO jnmscat (IdMS,IdCategory) VALUES (:ims,:c)";
    with( request ) {
      q.ims = .IdMS;
      q.c = .IdCategory
    };
    update@Database( q )( result );
    println@Console( "Adding a new category to microservice " + request.IdMS )()
  }]

  [remove_category_from_ms( request )( response ) {

    //query
    q = "DELETE FROM jnmscat WHERE IdMS=:ims AND IdCategory=:c";
    with( request ) {
      q.ims = .IdMS;
      q.c = .IdCategory
    };
    update@Database( q )( result );
    println@Console( "Removing category from microservice " + request.IdMS )()
  }]
}