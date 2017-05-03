include "microservices_dbInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

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