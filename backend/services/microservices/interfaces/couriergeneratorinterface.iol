type Service: int {
	.subservices[0, *]: void {
		.location:string
		.protocol:string
		.interfaces[0, *]: string 
	}
}



interface CourierGeneratorInterface {
  RequestResponse:
    generatecourier( Service )( void )
}