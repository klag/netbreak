include "console.iol"
include "file.iol"
include "database.iol"
include "string_utils.iol"
include "protocols/http.iol"
include "time.iol"
include "interfaces/filehandlerinterface.iol"

execution { concurrent }

outputPort Self {
	Protocol: http 
	Location: "socket://localhost:8004/"
	Interfaces: FileHandlerInterface
}

inputPort FileHandler {
	Protocol: http {
		.format = "json";
		.keepAlive = true; // Keep connections open
		.debug = DebugHttp; 
		.debug.showContent = DebugHttpContent;
		.contentType -> mime;
		.statusCode -> statusCode;
		.response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
		.response.headers.("Access-Control-Allow-Origin") = "*";
		.response.headers.("Access-Control-Allow-Headers") = "Content-Type"
	}
	Location: "socket://localhost:8004/"
	Interfaces: FileHandlerInterface
}

/*1. Procedura private per aggiungere metadati di un file al db. Non ha senso esporla all'esterno*/
define __saveFileMetadata {
  q = "Insert into files(Filename, Size) VALUES (:filename, :size)";
  q.filename = _filename;
  q.size = _size;
  update@Database( q )( result )
}

init
{
  println@Console( "Filehandler started" )();
  //connect to microservices database
  with( connectionInfo ) {
      .host = "apimfilesinstance.ccsrygwsp8kn.eu-west-2.rds.amazonaws.com"; 
      .driver = "mysql";
      .port = 3306;
      .database = "filesDB";
      .username = "netbreakswe";
      .password = "netbreakswe"
    };
    connect@Database( connectionInfo )();
    println@Console("DB connected, connection is running on host:" + connectionInfo.host )()
}



main
{
	/*controlla se il filename scelto esiste nel db*/
	[ filenameExists( request )( response ) {
		q = "select * from files where Filename = :filename";
	    q.filename = request.filename;
	    query@Database( q )( result );
	    response = true;
	    if (#result.rows == 0) {
	    	response = false
	    }
	}]
	/*riceve un file e lo salva localmente con filename univoco e ritorna l'uri del file al chiamante*/
	[ setFile( request )( response ) {
		/*genera stringa random con possibilita' quasi nulla di averne di identiche*/
		getRandomUUID@StringUtils()( random );
		getDateTime@Time(0)( time );
		getSize@File( request.file )( size );
		with (file) {
			.filename = random+time.day+time.hour+time.year+time.month+time.second+".jpg"; //unique filename
			.format = "binary";
			.content -> request.file
		};
		/*controllo se filename gia' esistente*/
		filenameExists@Self(file.filename)(exists);
		println@Console("filename: "+file.filename+ " esiste gia' queste filename? "+exists)();
		if (!exists) {
			/*se no salvalo nel db e localmente e fornisci l'uri al chiamante*/
			_filename = file.filename;
			_size = size/100;
			__saveFileMetadata;
		    writeFile@File( file )();
			response = file.filename
		}
	}]
}
