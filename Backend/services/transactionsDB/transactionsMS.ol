include "interfaces/transactionsInterface.iol"

include "console.iol"
include "database.iol"

execution { concurrent }

outputPort transactions_db_writerOutput {
	Location: "socket://localhost:8232"
	Protocol: sodep
	Interfaces: transactions_db_writerInterface
}

outputPort transactions_db_writerJSONOutput {
	Location: "socket://localhost:8132"
	Protocol: http { format = "json" }
	Interfaces: transactions_db_writerInterface
}

outputPort transactions_db_readerOutput {
	Location: "socket://localhost:8231"
	Protocol: sodep
	Interfaces: transactions_db_readerInterface
}

outputPort transactions_db_readerJSONOutput {
	Location: "socket://localhost:8131"
	Protocol: http { format = "json" }
	Interfaces: transactions_db_readerInterface
}

inputPort transactionsMSInput {
	Location: "socket://localhost:8230"
	Protocol: sodep
	Interfaces: transactionsMSInterface
	Aggregates: 
		transactions_db_readerOutput,
		transactions_db_writerOutput
}

inputPort transactionsMSInput {
	Location: "socket://localhost:8130"
	Protocol: http { .format = "json" }
	Interfaces: transactionsMSInterface
	Aggregates: 
		transactions_db_readerJSONOutput,
		transactions_db_writerJSONOutput
}

init 
{
	println@Console( "Transactions Microservice started" )()
}

main
{
	ciao( request )( response ) {
		println@Console("Ciao")()
	}
}