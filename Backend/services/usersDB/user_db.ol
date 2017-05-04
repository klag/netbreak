include "user_dbInterface.iol"

include "database.iol"
include "console.iol"
include "time.iol"

execution { sequential }

inputPort user_dbInput {
  Location: "socket://localhost:8201"
  Protocol: sodep
  Interfaces: user_dbInterface
}

inputPort user_dbJSONInput {
  Location: "socket://localhost:8101"
  Protocol: http { 
  	//Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
		.response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
		.response.headers.("Access-Control-Allow-Origin") = "*";
		.response.headers.("Access-Control-Allow-Headers") = "Content-Type";
  	.format = "json"
  	}
  Interfaces: user_dbInterface
}

init
{
	println@Console( "User Db Microservice started" )();

  //connect to user database
  with( connectionInfo ) {
      .host = "apimusersinstance.ccsrygwsp8kn.eu-west-2.rds.amazonaws.com"; 
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
  [user_exists( request )( response ) {
    //cerca gli utenti con queste credenziali
    q = "SELECT * FROM clients WHERE Email=:email AND Password=:password";
    q.email = request.Email;
    q.password = request.Password;
    //se non lo trovi vuol dire che non esiste
    if ( #result.row == 0 ) {
      println@Console("Client not found")();
      response = false
    }
    //altrimenti esiste
    else {
      println@Console("Client exists with info " + request.Email + " " + request.Password)();
      response = true
      
    }
  }]
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved info about admin " + response.Name + " " + response.Surname)()
  }]

  [retrieve_client_info( request )( response ) {

    //query
    q = "SELECT IdClient,Name,Surname,Email,Password,Avatar,Credits FROM clients WHERE IdClient=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Client not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got client "+ result.row[i].Name )();
        response << result.row[i]
      }
    };
    println@Console("Retrieved info about client " + response.Name + " " + response.Surname)()
  }]

  [retrieve_client_fullname( request )( response ) {

    //query
    q = "SELECT Name,Surname FROM clients WHERE IdClient=:i";
    q.i = request.Id;
    query@Database( q )( result );

    if ( #result.row == 0 ) {
      println@Console("Client not found")()
    }
    else {
      for ( i=0, i<#result.row, i++ ) {
        println@Console( "Got client "+ result.row[i].Name )();
        response << result.row[i]
      }
    };
    println@Console("Retrieved info about client " + response.Name + " " + response.Surname)()
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved entry " + response.IdEntry)()
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved moderation type " + response.IdModType)()
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
        response << result.row[i]
      }
    };
    println@Console("Retrieved client type " + response.Name)()
  }]


  [basicclient_registration( request )( response ) {
    println@Console("basicclient_registration execution started")();
    getDateTime@Time( 0 )( date ); //data corrente
    //query
    q = "INSERT INTO clients (Name,Surname,Email,Password,Avatar,Registration,
         Credits,ClientType,AboutMe,Citizenship,LinkToSelf,PayPal) 
         VALUES (:nome, :cognome, :email, :password, :avataruri, :regdate, 100, 
         1, :aboutme, :cittadinanza, :linkweb, :paypal)";
      with( q ) {
          .nome = request.Name;
          .cognome = request.Surname;
          .email = request.Email;
          .password = request.Password;
          .avataruri = request.Avatar;
          .regdate = date.year + "-" + date.month + "-" + date.day;
          .aboutme = request.AboutMe;
          .cittadinanza = request.Citizenship;
          .linkweb = request.LinkToSelf;
          .paypal = request.PayPal
    };
    update@Database( q )( result );
    //update@Database( q )( result );
    println@Console("Registering new basic client " + request.Name + " " + request.Surname)()
  }]

  [developer_upgrade( request )( response ) {

    //query
    q = "UPDATE clients SET ClientType=2,AboutMe=:am,Citizenship=:c,LinkToSelf=:l,PayPal=:pp WHERE IdClient=:i";
    with( request ) {
      q.i = .IdClient;
      q.am = .AboutMe;
      q.c = .Citizenship;
      q.l = .LinkToSelf;
      q.pp = .PayPal
    };
    update@Database( q )( result );
    println@Console("Upgrading basic client with id " + request.IdClient +" to developer status")()
  }]

  [basicclient_downgrade( request )( response ) {

    //query
    q = "UPDATE clients SET ClientType=1,AboutMe='',Citizenship='',LinkToSelf='',PayPal='' WHERE IdClient=:i";
    with( request ) {
      q.i = .Id
    };
    update@Database( q )( result );
    println@Console("Downgrading developer with id " + request.Id +" to basic client status")()
  }]

  [client_moderation( request )( response ) {

    //query
    q = "INSERT INTO moderationlog (IdClient,IdAdmin,Timestamp,ModType,Report) 
      VALUES (:ic,:ia,:t,:mt,:r)";
    with( request ) {
      q.ic = .IdClient;
      q.ia = .IdAdmin;
      q.t = .Timestamp;
      q.mt = .ModType;
      q.r = .Report
    };
    update@Database( q )( result );
    println@Console("Creating new moderation entry")()
  }]

  [client_update( request )( response ) {

    //query
    q = "UPDATE clients 
      SET Name=:n,Surname=:s,Email=:e,Password=:p,Avatar=:a,Credits=:c,AboutMe=:am,Citizenship=:ct,LinkToSelf=:l,PayPal=:pp 
      WHERE IdClient=:i";
    with( request ) {
      q.i = .IdClient;
      q.n = .Name;
      q.s = .Surname;
      q.e = .Email;
      q.p = .Password;
      q.a = .Avatar;
      q.c = .Credits;
      q.am = .AboutMe;
      q.ct = .Citizenship;
      q.l = .LinkToSelf;
      q.pp = .PayPal
    };
    update@Database( q )( result );
    println@Console("Updating user profile with id " + request.IdClient)()
  }]

  [client_delete( request )( response ) {

    //query
    q = "DELETE FROM clients WHERE IdClient=:i";
    with( request ) {
      q.i = .Id
    };
    update@Database( q )( result );
    println@Console("Deleting client with id " + request.Id +" forever")()
  }]
}