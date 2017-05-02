include "slaMSInterface.iol"

include "console.iol"
include "database.iol"

execution { concurrent }

/*
outputPort sla_db_writerOutput {
	Location: "socket://localhost:8212"
	Protocol: sodep
	Interfaces: sla_db_writerInterface
}*/

outputPort sla_db_writerJSONOutput {
	Location: "socket://localhost:8112"
	Protocol: http { format = "json" }
	Interfaces: sla_db_writerInterface
}

/*
outputPort sla_db_readerOutput {
	Location: "socket://localhost:8211"
	Protocol: sodep
	Interfaces: sla_db_readerInterface
}*/

outputPort sla_db_readerJSONOutput {
	Location: "socket://localhost:8111"
	Protocol: http { format = "json" }
	Interfaces: sla_db_readerInterface
}

/*
inputPort slaMSInput {
	Location: "socket://localhost:8210"
	Protocol: sodep
	Interfaces: slaMSInterface
	Aggregates: 
		sla_db_readerOutput,
		sla_db_writerOutput
}*/

inputPort slaMSInput {
	Location: "socket://localhost:8110"
	Protocol: http { .format = "json" }
	Interfaces: slaMSInterface
	Aggregates: 
		sla_db_readerJSONOutput,
		sla_db_writerJSONOutput
}

init 
{
	println@Console( "Sla Microservice started" )()
}

main
{
	ciao( request )( response ) {
		println@Console("Ciao")()
	}
}