include "interfaces/microservices.iol"
include "console.iol"

outputPort MS {
  Location: "socket://localhost:8121"
  Protocol: http 
  Interfaces: microservices_db_readerInterface
}

main {
		ser[0] = 1;
	  ser[0].subservices[0].location = "socket://localhost:8000";
	  ser[0].subservices[0].protocol = "http";
	  ser[0].subservices[0].interfaces[0] = "type op: void {
	.a: int
	.b: int
}

interface DivInterface {
  RequestResponse:
    div( op )( double ),
    divanddouble(op)( double ) 
}";
	  ser[0].subservices[0].interfaces[1] = "type op: void {
	.a: int
	.b: int
	.c: string
}

interface SubInterface {
  RequestResponse:
    sub( op )( double ),
    subanddouble(op)( double )
";
	  ser[0].subservices[0].interfaces[2] = "type op: void {
	.a: int
	.b: int
}

interface SumInterface {
  RequestResponse:
    sum( op )( double ),
    sumanddouble(op)( double )
}";



ser[0].name = "Honolulo";
ser[0].description = "Honolulo";
ser[0].version = 2;
ser[0].idDeveloper = "Honolulo";
ser[0].logo = "Honolulo";
ser[0].docpdf = "Honolulo";
ser[0].docexternal = "Honolulo";
ser[0].profit = 1;
ser[0].isActive = "Honolulo";
ser[0].slaguaranteed = 2;
ser[0].policy = 2;




	insert_service@MS(ser[0])()
	

}