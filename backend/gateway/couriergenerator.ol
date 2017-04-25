include "file.iol"
include "string_utils.iol"
include "console.iol"
include "interfaces/couriergeneratorinterface.iol"

execution { concurrent }

inputPort CourierGenerator {
   Location: "local"
   Interfaces: CourierGeneratorInterface
}

main {
   [generatecourier( request )( response ) {
      /*begin service interfaces include:*/
      decorator = "";
      for (i = 0, i < #request.subservices, i++) {
         for ( j = 0, j < #request.subservices[i].interfaces, j++ ) {
            /*begin find interface name with regex*/
            findinterfname = request.subservices[i].interfaces[j];
            findinterfname.regex = "(?:interface |vs\\. )(\\w+)"; //parola dopo 'interface'
            find@StringUtils(findinterfname)(interfname);
            request.subservices[i].interfaces[j].name = interfname.group[1];
            /*end find interface name with regex*/
            decorator += request.subservices[i].interfaces[j] + "\n\n"
         }
      };
      /*end service interfaces include:*/

      /*-------begin static content-------*/
      decorator += "\n\nexecution { concurrent }\n\n";
      decorator += "type AuthenticationData: any {\n";
      decorator += " .key:string\n";
      decorator += "}\n\n";
      decorator += "interface extender AuthInterfaceExtender {\n";
      decorator += " RequestResponse:\n";
      decorator += "    *( AuthenticationData )( void )\n";
      decorator += " OneWay:\n";
      decorator += "    *( AuthenticationData )\n";
      decorator += "}\n\n";
      decorator += "interface AggregatorInterface {\n";
      decorator += " RequestResponse:\n";
      decorator += "    mock(string)(string)\n";
      decorator += "}\n";
      /*-------end static content-------*/

      /*begin outputports generator */
      for (i = 0, i < #request.subservices, i++) {
            decorator += "outputPort SubService"+i+" {\n";
            decorator += " Interfaces: ";
            for ( j = 0, j < #request.subservices[i].interfaces - 1, j++ ) {
               decorator += request.subservices[i].interfaces[j].name + ", "
            };
            decorator += request.subservices[i].interfaces[j].name;
            decorator += "\n Location: \""+ request.subservices[i].location+ "\"\n";
            decorator += " Protocol: "+request.subservices[i].protocol+"\n";
            decorator += "}\n\n"
      };
      /*end outputports generator */

      /*-------begin static content-------*/
      decorator += "inputPort Client {\n";
      decorator += " Location: \"local\"\n";
      decorator += " Interfaces: AggregatorInterface\n";
      decorator += " Aggregates: ";
      /*-------end static content-------*/

      for (i = 0, i < #request.subservices - 1, i++) {
            if (#request.subservices)
            decorator += "SubService"+i+" with AuthInterfaceExtender, "
      };

      /*-------begin static content-------*/
      decorator += "SubService"+i+" with AuthInterfaceExtender ";
      decorator += "\n}\n\n";
      decorator += " courier Client {\n";
      /*-------end static content*/

      /*begin courier generator RequestResponse*/
      for (i = 0, i < #request.subservices, i++) {
         for ( j = 0, j < #request.subservices[i].interfaces, j++ ) {
            decorator += "    [ interface "+request.subservices[i].interfaces[j].name+"( request )( response ) ] {\n";
            decorator += "       forward ( request )( response )\n";
            decorator += "    }\n"
         }
      };
      /*end courier generator RequestResponse*/
      /*begin courier generator RequestResponse*/
      for (i = 0, i < #request.subservices, i++) {
         for ( j = 0, j < #request.subservices[i].interfaces, j++ ) {
            decorator += "    [ interface "+request.subservices[i].interfaces[j].name+"( request ) ] {\n";
            decorator += "       forward ( request )\n";
            decorator += "    }\n"
         }
      };
      /*end courier generator RequestResponse*/

      /*begin static content*/
      decorator += " }\n\n";
      decorator += "main {\n";
      decorator += " mock( r )( rs ) {\n";
      decorator += "    rs = void\n";
      decorator += " }\n";
      decorator += "}\n";
      /*end static content*/

      with (filereq) {
         .content = decorator;
         .filename = "couriers/Service"+request+"Courier.ol"
      };
      writeFile@File(filereq)()
   }]
}
