include "user_db_writerInterface.iol"

include "database.iol"
include "console.iol"

execution { sequential }

/*
inputPort user_db_writerInput {
  Location: "socket://localhost:8202"
  Protocol: sodep
  Interfaces: user_db_writerInterface
}*/

inputPort user_db_writerJSONInput {
  Location: "socket://localhost:8102"
  Protocol: http { .format = "json" }
  Interfaces: user_db_writerInterface
}

init
{
	println@Console( "User Db Writer started" )();

  // connect to user database
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
  [basicclient_registration( request )( response ) {

    //query
    q = "INSERT INTO clients (Name,Surname,Email,Password,Avatar,Registration,ClientType,AboutMe,Citizenship,LinkToSelf,PayPal) 
      VALUES (:n,:s,:e,:p,:a,:r,1,'','','','')";
    with( request ) {
      q.n = .Name;
      q.s = .Surname;
      q.e = .Email;
      q.p = .Password;
      q.a = .Avatar;
      q.r = .Registration
    };
    update@Database( q )( result );
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
      q.i = .IdClient
    };
    update@Database( q )( result );
    println@Console("Downgrading developer with id " + request.IdClient +" to basic client status")()
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
      SET Name=:n,Surname=:s,Email=:e,Password=:p,Avatar=:a,AboutMe=:am,Citizenship=:c,LinkToSelf=:l,PayPal=:pp 
      WHERE IdClient=:i";
    with( request ) {
      q.i = .IdClient;
      q.n = .Name;
      q.s = .Surname;
      q.e = .Email;
      q.p = .Password;
      q.a = .Avatar;
      q.am = .AboutMe;
      q.c = .Citizenship;
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