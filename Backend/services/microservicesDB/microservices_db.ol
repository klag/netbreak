include "microservices_dbInterface.iol"
include "serviceinteractionhandlerinterface.iol"


include "database.iol"
include "console.iol"

execution { sequential }

/*---------*/
/*porta per comunicare con gestore delle interazioni dei microservizi*/
outputPort ServiceInteractionHandler {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ServiceInteractionHandlerInterface
}
/*-----------*/

inputPort microservices_dbInput {
  Location: "socket://localhost:8221"
  Protocol: sodep
  Interfaces: microservices_dbInterface
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
  Interfaces: microservices_dbInterface
}

init
{
	println@Console( "Microservices Db Microservice started" )();

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
  //per gateway do not touch
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved all info about microservice " + response.Name)()
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved interface gateway info (interface)(location:" + response.Loc + ")(protocol" 
      + response.Protoc + ")" )()
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved microservice " + response.IdMS + " from interface " + request.Id)()
  }]

  [retrieve_msidlist_from_category( request )( response ) {

    //query
    q = "SELECT IdMS FROM jnmscat WHERE IdCategory=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Microservice not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got microservice "+ result.row[i].IdMS )();
        response.MSIdByCatListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved microservices from category " + request.Id)()
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
        response << result.row[i]
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
    q = "SELECT IdMS,Name,IdDeveloper,Logo FROM microservices ORDER BY LastUpdate DESC LIMIT :l";
    q.l = request.Number;
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

  [retrieve_last_registered_ms_byid( request )( response ) {

    //query
    q = "SELECT Name,IdDeveloper,Logo FROM microservices WHERE IdMS=:i ORDER BY LastUpdate DESC LIMIT :l";
    q.l = request.Number;
    q.i = request.IdMS;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Last microservices list by msid not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got microservice number " + i )();
        response.MSRegByIdListData[i] << result.row[i]
      }
    };
    println@Console("Retrieved last registered microservices by msid")()
  }]

  /*metodo da completare con gestione errori ecc... faccenda complessa piu' del previsto*/
  [microservice_registration( request )( response ) {
    /*genero un courier temporaneo*/
    courierreq.subservices->request.subservices;
    courierreq = 6;
    courierreq.subservices->request.subservices; //ricavo richiesta per generatore courier
    generateCourier@ServiceInteractionHandler(courierreq)(rr);
    /*uso il generatore di interfacce per estrarre i metadati*/
    interfreq = 1;
    interfreq.name -> request.name;
    generateClientInterface@ServiceInteractionHandler(interfreq)(rr);
    //a questo punto so che le interfacce sono a posto
    //richiamo il gateway affinche' faccia il binding di questo nuovo servizio a se stesso
    //genero la documentazione in automatico usando quello che ho fatto nel punto a.
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