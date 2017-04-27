include "interfaces/microservices.iol"
include "interfaces/serviceinteractionhandlerinterface.iol"
include "database.iol"
include "console.iol"

execution { concurrent }

/*---------*/
/*porta per comunicare con gestore delle interazioni dei microservizi*/
outputPort ServiceInteractionHandler {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ServiceInteractionHandlerInterface
}
/*-----------*/

inputPort MSrv {
  Location: "socket://localhost:8121"
  Protocol: http 
  Interfaces: MSInterface
}


/*PROCEDURE (in Jolie sono come i metodi privati, solo il servizio stesso vi accede)*/
/*1. Procedura per trovare un id seguente al max id di un servizio*/
define __findNextMaxIdMS {
  q = "SELECT MAX(IdMS) FROM microservices;";
  query@Database(q)(maxid);
  msid = maxid.IdMs + 1
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
    /*genero un courier temporaneo*/
    courierreq.subservices->request.subservices;
    __findNextMaxIdMS;
    courierreq = msid;
    courierreq.subservices->request.subservices; //ricavo richiesta per generatore courier
    generateCourier@ServiceInteractionHandler(courierreq)(rr);
    /*uso il generatore di interfacce per estrarre i metadati*/
    interfreq = 1;
    interfreq.name -> request.name;
    generateClientInterface@ServiceInteractionHandler(interfreq)(rr)
    //a questo punto so che le interfacce sono a posto
    //richiamo il gateway affinche' faccia il binding di questo nuovo servizio a se stesso
    //genero la documentazione in automatico usando quello che ho fatto nel punto a.
  }]

  /*author: Dan Ser*/
  /*PRE = (posso assumere che non ci sono inconsistenze a livello di database)*/
  [retrieve_all_ms_info( request )( response ) {
    q = "select microservices.idMS, interfaces.Interf, interfaces.Loc, 
      interfaces.Protoc from interfaces, microservices where interfaces.idMS = microservices.idMS
      ORDER BY microservices.idMS ASC;";
    query@Database(q)(result);

    service_index = -1; currId = -1;
    for ( i=0, i<#result.row, i++ ) {
        //diverso id vuol dire che ho altro servizio
        if (currId != result.row[i].idMS) {
          currId = result.row[i].idMS;
          service_index++; 
          response.services[service_index] << currId
        };
        /*controllo se la location di questa riga e' uguale a quella di subservizi precedenti*/
        j = 0; trovato = false;
        while (j < #response.services[service_index].subservices && !trovato) {
            if (response.services[service_index].subservices[j].location == result.row[i].Loc) {
              trovato = true
            } else {
              j++
            }
        };        
        if (!trovato) {
        /*se location mai trovata nei subservice precedente ho un nuovo subservice*/
          subservice_index = #response.services[service_index].subservices;
          interf_index = #response.services[service_index].subservices[subservice_index].interfaces;
          response.services[service_index].subservices[subservice_index].location << result.row[i].Loc;
          response.services[service_index].subservices[subservice_index].protocol << result.row[i].Protoc;
          response.services[service_index].subservices[subservice_index].interfaces[interf_index] << result.row[i].Interf
        } 
        /*se la location trovata nei subservice precedenti aggiungi interfaccia a quel subservice dove trovata*/
        else {
          interf_index = #response.services[service_index].subservices[j].interfaces;
          response.services[service_index].subservices[j].interfaces[interf_index] << result.row[i].Interf
        }
    }
  }]
  /*POST = (ritorna le info per fare il binding a livello di gateway)*/





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