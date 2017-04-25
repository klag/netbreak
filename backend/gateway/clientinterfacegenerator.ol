include "console.iol"
include "string_utils.iol"
include "metajolie.iol"
include "metaparser.iol"
include "file.iol"


include "interfaces/clientinterfacegeneratorinterface.iol"
execution { concurrent }


inputPort ClientInterfaceGenerator {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ClientInterfaceGeneratorInterface
}

/*procedura che determina se _T e' gia' presente in array _arr*/
define __isInArray {
  _trovato = false;
   /*e' un tipo primitivo?*/
  for (index = 0, index < #_arr && !(_trovato), index++ ) {
      if (_arr[index] == _T) {
        _trovato = true
      }
  }
}

init {
  /*lista di tutti i tipi primitivi in Jolie*/
  primitive[ 0 ] = "bool";
  primitive[ 1 ] = "int";
  primitive[ 2 ] = "long";
  primitive[ 3 ] = "double";
  primitive[ 4 ] = "string";
  primitive[ 5 ] = "raw";
  primitive[ 6 ] = "void"
}



main {
  [generateclientinterface( request )( response ) {
      metareq.name.name = "Client";
      metareq.name.domain = "mockdomain"; 
      metareq.filename = "couriers/Service"+request+"Courier.ol";

      getInputPortMetaData@MetaJolie( metareq )( meta );
      /*scorri tutte le interfacce*/
      for (i = 0, i < #meta.input[0].interfaces, i++) {
          /*scorri i tipi complessi dell'interfaccia i*/
          for ( k = 0, k < #meta.input[0].interfaces[i].types, k++ ) {
             /*controllo se questo tipo complesso gia' incontrato*/
             _T -> meta.input[0].interfaces[i].types[k].name.name;
             _arr -> complext;
             __isInArray;
             /*se tipo non incontrato salva in array*/
             if (!_trovato) {
                pos = #complext;
                complext[pos] = meta.input[0].interfaces[i].types[k].name.name;
                getType@Parser(meta.input[0].interfaces[i].types[k])(complextype);
                complext[pos].definition = complextype
             }
          };
          /*scorri le operation dell'interfaccia i*/
          for ( j = 0, j < #meta.input[0].interfaces[i].operations, j++ ) {
             ops = #operations;
             operations[ops].name = meta.input[0].interfaces[i].operations[j].operation_name; //nome operation j
             /*tipo della richiesta dell'operation j dell'interfaccia i e' tipo primitivo?*/
             _T -> meta.input[0].interfaces[i].operations[j].input.name;
             _arr -> primitive;
             __isInArray;
             /*se si*/
             if (_trovato) {
                /*tipo primitivo gia' incontrato?*/
                _arr -> primitivet;
                __isInArray;
                /*se tipo non incontrato salva in array primitivet dei tipi primitivi*/
                if (!_trovato) {
                   pos = #primitivet;
                   primitivet[pos] = _T; 
                   primitivet[pos].name = "t" + pos; /*nome esteso*/
                   primitivet[pos].definition = "type t"+pos+": "+primitivet[pos]+"{\n .key:string \n}"
                   /*salva il tipo esteso del primitivo di andata nella operation*/
                };
                operations[ops].request = primitivet[pos].name
              }
              /*altrimenti salva in operations il nome del tipo complesso del tipo di andata dell'operation j*/
              else {
                operations[ops].request = _T
              };
              /*salva in in operations il tipo di ritorno dell'operation j*/
             operations[ops].response = meta.input[0].interfaces[i].operations[j].output.name
          }
       };
      

       /*begin generazione interfaccia client del Servizio*/

       /*costruisci lista tipi complessi*/
       for (z = 0, z < #complext, z++) {
            clientinterf += complext[z].definition + "\n"

       };
       /*costruisci lista tipi primitivi estesi*/
       for (z = 0, z < #primitivet, z++) {
            clientinterf += primitivet[z].definition + "\n"

       };

       /*costruisci interfaccia*/
       clientinterf += "\n";
       clientinterf += "interface "+request.name+"Interface {\n";
       /*costruisci lista operation OneWay*/
       clientinterf += " OneWay:\n";
       for (z = 0, z < (#operations - 1), z++) {
            if (operations[z].response == void) {
                clientinterf += "   "+operations[z].name + "("+operations[z].request+ "),\n"
            }
       };
       if (operations[z].response == void) {
                clientinterf += "   "+operations[z].name + "("+operations[z].request+ ")\n"
       };
       /*costruisci lista operation RequestResponse*/
       clientinterf += " RequestResponse:\n";
       for (z = 0, z < (#operations - 1), z++) {
          if (operations[z].response != void) {
            clientinterf += "   "+operations[z].name + "("+operations[z].request+ ")("+operations[z].response+ "),\n"
          }
       };
       if (operations[z].response != void) {
            clientinterf += "   "+operations[z].name + "("+operations[z].request+ ")("+operations[z].response+ ")\n"
       };
       clientinterf += "}\n\n";
       /*genera Outputport verso Gateway*/
       clientinterf += "outputPort "+request.name+"CalcService{\n";
       clientinterf += "  Location:\"socket://localhost:2002/!/Service"+request+"\"\n";
       clientinterf += "  Protocol:sodep\n";
       clientinterf += "  Interfaces: "+request.name+"Interface\n";
       clientinterf += "}";
       /*end generazione interfaccia client del Servizio*/


       /*scrivi su file*/
       with (filereq) {
         .content = clientinterf;
         .filename = request.name+"Interface.iol"
      };
      writeFile@File(filereq)()
  }]
}
