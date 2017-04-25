include "interfaces/clientinterfacegeneratorinterface.iol"

outputPort ClientInterfaceGenerator {
   Location: "socket://localhost:8322"
   Protocol: http 
   Interfaces: ClientInterfaceGeneratorInterface
}

main {
    r = 1;
    r.name = "CalcService";
    generateclientinterface@ClientInterfaceGenerator(r)(rr)
}
