type sservice: int {
	.name: string
	
}

interface ClientInterfaceGeneratorInterface {
  RequestResponse:
    generateclientinterface( sservice )( void )
}