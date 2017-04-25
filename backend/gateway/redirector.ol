include "Runtime.iol"
include "interfaces/redirectorinterface.iol"
include "interfaces/microservices.iol"
include "interfaces/couriergeneratorinterface.iol"

execution { concurrent }

/*porta per comunicare con microservices_db_reader.ol*/
outputPort MSReader {
  Location: "socket://localhost:8121"
  Protocol: http
  Interfaces: microservices_db_readerInterface
}

/*porta per comunicare con generatore di Courier*/
outputPort CourierGenerator {
   Interfaces: CourierGeneratorInterface
}

embedded {
  Jolie: "couriergenerator.ol" in CourierGenerator
}


inputPort Redirector {
  Location: "socket://localhost:2002"
  Protocol: sodep
  Interfaces: RedirectorInterface
}

define __newcourierredirection {
  //embeddo dinamicamente servizio

  with( emb ) {
      .filepath = "couriers/Service"+__serviceid+"Courier.ol";
      .type = "Jolie" //possibilmente da fare ancora piu' dinamico includendo il resto dei tipi possibili
   };
  loadEmbeddedService@Runtime( emb )(handle);
  //associo il servizio embeddato a una outputport creata al volo univoca
  with (opnew) {
    .location = handle;
    .name = "Service"+__serviceid+"Courier"
  };
  setOutputPort@Runtime( opnew )();
  //imposto redirezione dinamica sulla porta associata al servizio col courier
  with( redirection ){
    .outputPortName = "Service"+__serviceid+"Courier";
    .resourceName = "Service"+__serviceid;
    .inputPortName = "Redirector"
  };
  setRedirection@Runtime ( redirection )()
}

init {
  /*ricavo info di binding di tutti i microservizi*/
  retrieve_all_ms_info@MSReader( void )( mss );
  /*genero 'couriers' per ogni microservizio*/
  for (i = 0, i < #mss.services, i++) {
      generatecourier@CourierGenerator(mss.services[i])();
      __serviceid = mss.services[i]; 
      __newcourierredirection   
  }     
}

main
{
  [setnewredirection( request )(response) {
       response = "mock"
       //qui richiamo __newcourierredirection
  }]
}