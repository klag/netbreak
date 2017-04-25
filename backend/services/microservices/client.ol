include "interfaces/microservices.iol"
include "console.iol"

outputPort MSReader {
  Location: "socket://localhost:8121"
  Protocol: http
  Interfaces: microservices_db_readerInterface
}


main {

	i[0] = "DivInterface";
	i[1] = "SumInterface";
	i[2] = "SubInterface";
	with (sub) {
		.location ="socket://localhost:8000";
		.protocol = "http";
		.interfaces -> i 
	};
	r = 1;
	with (r) {
		.subservices ->sub
	};

	insert_service@MSReader(r)()
	

}