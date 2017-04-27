include "runtime.iol"
include "console.iol"
include "interfaces/redirectorinterface.iol"
include "interfaces/microservices.iol"
include "interfaces/serviceinteractionhandlerinterface.iol"

execution { concurrent }

/*porta per comunicare con microservices_db_reader.ol*/
outputPort MSrv {
  Location: "socket://localhost:8121"
  Protocol: http
  Interfaces: MSInterface
}

/*porta per comunicare con gestore delle interazioni dei microservizi*/
outputPort ServiceInteractionHandler {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ServiceInteractionHandlerInterface
}


inputPort Gateway {
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
    .inputPortName = "Gateway"
  };
  setRedirection@Runtime ( redirection )()
}

init {
  /*ricavo info di binding di tutti i microservizi*/
  retrieve_all_ms_info@MSrv( void )( mss );
  /*genero 'couriers' per ogni microservizio*/
  for (i = 0, i < #mss.services, i++) {
      generateCourier@ServiceInteractionHandler(mss.services[i])(courier_s);
      __serviceid << mss.services[i]; 
      with (filereq) {
         .content = courier_s;
         .filename = "couriers/Service"+__serviceid +"Courier.ol"
      };
      writeFile@File(filereq)();
      __newcourierredirection   
  }     
}

main
{
  [setnewredirection( request )(response) {
      generateCourier@ServiceInteractionHandler(request)(courier_s);
      __serviceid = request; 
      with (filereq) {
         .content = courier_s;
         .filename = "couriers/Service"+__serviceid +"Courier.ol"
      };
      writeFile@File(filereq)();
      __newcourierredirection   
  }]
}