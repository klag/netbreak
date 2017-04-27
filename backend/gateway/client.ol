include "interfaces/clientinterfacegeneratorinterface.iol"
include "console.iol"
include "file.iol"


outputPort ClientInterfaceGenerator {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ClientInterfaceGeneratorInterface
}



main {
  install( NumberException=>
    println@Console( main.NumberException.exceptionMessage )()
  );


    r = "couriers/Service1Courier.ol";
    getServiceMetaFromCourier@ClientInterfaceGenerator(r)(rr);
     install( ParserException=>
      println@Console( "main.ParserException.exceptionMessage" )()
    );
    println@Console(rr)()
    /*generateclientinterface@ClientInterfaceGenerator(rr)(rrr);
    with (filereq) {
         .content = rrr;
         .filename = "Interface.iol"
     };
    writeFile@File(filereq)()*/

}
