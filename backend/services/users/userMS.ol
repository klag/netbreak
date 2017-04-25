include "userMSInterface.iol"

include "console.iol"
include "database.iol"

execution { concurrent }

/*
outputPort user_db_writerOutput {
	Location: "socket://localhost:8202"
	Protocol: sodep
	Interfaces: user_db_writerInterface
}*/

outputPort user_db_writerJSONOutput {
	Location: "socket://localhost:8102"
	Protocol: http { format = "json" }
	Interfaces: user_db_writerInterface
}

/*
outputPort user_db_readerOutput {
	Location: "socket://localhost:8201"
	Protocol: sodep
	Interfaces: user_db_readerInterface
}*/

outputPort user_db_readerJSONOutput {
	Location: "socket://localhost:8101"
	Protocol: http { format = "json" }
	Interfaces: user_db_readerInterface
}

/*
inputPort userMSInput {
	Location: "socket://localhost:8200"
	Protocol: sodep
	Interfaces: userMSInterface
	Aggregates: 
		user_db_readerOutput,
		user_db_writerOutput
}*/

inputPort userMSInput {
	Location: "socket://localhost:8100"
	Protocol: http { .format = "json" }
	Interfaces: userMSInterface
	Aggregates: 
		user_db_readerJSONOutput,
		user_db_writerJSONOutput
}

init 
{
	println@Console( "User Microservice started" )()
}

main
{
	ciao( request )( response ) {
		println@Console("Ciao")()
	}
}