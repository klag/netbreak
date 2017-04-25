include "interfaces/microservices.iol"
include "interfaces/clientinterfacegeneratorinterface.iol"
include "interfaces/couriergeneratorinterface.iol"
include "database.iol"
include "console.iol"

execution { sequential }

/*---------*/
outputPort CourierGenerator {
   Interfaces: CourierGeneratorInterface
}

embedded {
  Jolie: "../../gateway/couriergenerator.ol" in CourierGenerator
}

outputPort ClientInterfaceGenerator {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ClientInterfaceGeneratorInterface
}
/*-----------*/


inputPort microservices_db_readerJSONInput {
  Location: "socket://localhost:8121"
  Protocol: http 
  Interfaces: microservices_db_readerInterface
}

/*procedura per trovare un id seguente al max id di un servizio*/
define __findNextMaxIdMS {
  q = "SELECT MAX(IdMS) FROM microservices;";
  query@Database(q)(maxid);
  msid = maxid.row[0].IdMs + 1
}

init
{
	println@Console( "microservices Db Reader started" )();

  //connect to microservices database
  with( connectionInfo ) {
      .host = "apimmicroservicesdb.cpfnkeifjbmu.eu-west-2.rds.amazonaws.com"; 
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
  [insert_service( request )( response ) {
    __findNextMaxIdMS;
    generatecourier@CourierGenerator(request)()
    //generateclientinterface@ClientInterfaceGenerator(request)(rr)
  }]
  [retrieve_all_ms_info( request )( response ) {
    q = "select microservices.idMS, interfaces.Interf, interfaces.Loc, 
      interfaces.Protoc from interfaces, microservices where interfaces.idMS = microservices.idMS
      ORDER BY microservices.idMS ASC;";
    query@Database(q)(result);
    serv = -1; subserv = -1; ninterf = 0; currloc = ""; currid = -1;
    for ( i=0, i<#result.row, i++ ) {
        //diverso id vuol dire che ho altro servizio
        if (currid != result.row[i].idMS) {
          serv++; subserv = -1; currloc = ""; currid = result.row[i].idMS;
          response.services[serv] << result.row[i].idMS
        };
        //se cambia location ma stesso servizio e' composto da altro subservice:
        if (currloc != result.row[i].Loc) {
          subserv++; ninterf = 0; currloc = result.row[i].Loc;
          response.services[serv].subservices[subserv].location << result.row[i].Loc;
          response.services[serv].subservices[subserv].protocol << result.row[i].Protoc;
          response.services[serv].subservices[subserv].interfaces[ninterf] << result.row[i].Interf
        } 
        //se la location non cambia e stesso servizio e' stesso subservice composto da piu' interfacce
        else {
          ninterf++; 
          response.services[serv].subservices[subserv].interfaces[ninterf] << result.row[i].Interf
        }
    }
  }]
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
    q = "SELECT IdInterface FROM jnmsintf WHERE IdMS=:i";
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
    println@Console("Retrieved interfaces of the microservice with id" + request.Id)()
  }]

  [retrieve_ms_from_interface( request )( response ) {

    //query
    q = "SELECT IdMS FROM jnmsintf WHERE IdInterface=:i";
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

}