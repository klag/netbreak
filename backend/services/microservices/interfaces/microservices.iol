// retrieve microservice from interface

type msiddata: void {
	.IdMS: int
}

type msidfound: void {
	.MSIdData: msiddata
}

// retrieve interfaces of a microservice

type intfidlistdata: void {
	.IdInterface: int
} 

type intfidlistfound: void {
	.IntfIdListData [0,*]: intfidlistdata
}

// retrieve interface info

type intfdata: void {
	.Interf: string
	.Loc: string
	.Protoc: string
}

type intffound: void {
	.IntfData: intfdata
}

type intfid: void {
	.Id: int
}

// retrieve microservice info

type msdata: void {
	.IdMS: int
	.Name: string
	.Description: string
	.Version: int
	.LastUpdate: string
	.IdDeveloper: int
	.Logo: string
	.DocPDF: string
	.DocExternal: string
	.Profit: int
	.IsActive: bool
	.SLAGuaranteed: double
	.Policy: int
}

type msfound: void {
	.MSData: msdata
}

type msid: void {
	.Id: int
}


/*lista di servizi con info per inizializzare outputportgateway*/
type listservices: void {
	.services[0, *]: int {
		.subservices[0, *]: void {
			.location:string
			.protocol:string
			.interfaces[0, *]: string 
		}
	}
}


/*info servizio per aggiunterlo ad apim da front-end */
type aaservice: int {
	.subservices[0, *]: void {
		.location:string
		.protocol:string
		.interfaces[0, *]: string 
	}
	.name: string
	.description: string
	.version: int
	.idDeveloper: string
	.logo: string
	.docpdf: string
	.docexternal: string
	.profit: int
	.isActive: string
	.slaguaranteed: double
	.policy: int

}



interface MSInterface {
	RequestResponse:
	    insert_service(aaservice)(void),
		retrieve_all_ms_info( void )( listservices ),
		retrieve_ms_info( msid )( msfound ),
		retrieve_intf_info( intfid )( intffound ),
		retrieve_interfaces_of_ms( msid )( intfidlistfound ),
		retrieve_ms_from_interface( intfid )( msidfound )
}