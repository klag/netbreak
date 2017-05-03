// strutture dati con semplice id

type msid: void {
	.Id: int
}

type intfid: void {
	.Id: int
}

type categoryid: void {
	.Id: int
}

// strutture dati con altri dati

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

type intfdata: void {
	.Interf: string
	.Loc: string
	.Protoc: string
}

type msiddata: void {
	.IdMS: int
}

type categorydata: void {
	.Name: string
	.Image: string
}

type msdataw: void {
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

type msupdata: void {
	.IdMS: int
	.Name: string
	.Description: string
	.Version: int
	.LastUpdate: string
	.Logo: string
	.DocPDF: string
	.DocExternal: string
	.Profit: int
	.SLAGuaranteed: double
}

type intfdataw: void {
	.IdMS: int
	.Interf: string
	.Loc: string
	.Protoc: string
}

type intfupdata: void {
	.IdInterface: int
	.Interf: string
	.Loc: string
	.Protoc: string
}

type categorydataw: void {
	.IdMS: int
	.IdCategory: int
}

// strutture dati di liste con altri dati

type categoryidlistdata: void {
	.IdCategory: int
} 

type categoryidlist: void {
	.CategoryIdListData [0,*]: categoryidlistdata
}

type msidbycatlistdata: void {
	.IdMS: int
} 

type msidbycatlist: void {
	.MSIdByCatListData [0,*]: msidbycatlistdata
}

type intfidlistdata: void {
	.IdInterface: int
} 

type intfidlist: void {
	.IntfIdListData [0,*]: intfidlistdata
}

type msreglistdata: void {
	.IdMS: int
	.Name: string
	.IdDeveloper: int
	.Logo: string
}

type lastmsreglist: void {
	.MSRegListData [0,*]: msreglistdata
}

type msregbyidlistdata: void {
	.Name: string
	.IdDeveloper: int
	.Logo: string
}

type lastmsregbyidlist: void {
	.MSRegByIdListData [0,*]: msregbyidlistdata
}

// tipi senza riferimento ad una struttura dati del db

type shownumber: void {
	.Number: int
}

type shownumberandidms: void {
	.Number: int
	.IdMS: int
}

interface microservices_dbInterface {
	RequestResponse:
		retrieve_ms_info( msid )( msdata ),
		retrieve_intf_info( intfid )( intfdata ),
		retrieve_interfaces_of_ms( msid )( intfidlist ),
		retrieve_ms_from_interface( intfid )( msiddata ),
		retrieve_msidlist_from_category( categoryid )( msidbycatlist ),
		retrieve_category_info( categoryid )( categorydata ),
		retrieve_categories_of_ms( msid )( categoryidlist ),
		retrieve_last_registered_ms( shownumber )( lastmsreglist ),
		retrieve_last_registered_ms_byid( shownumberandidms )( lastmsregbyidlist ),

		microservice_registration( msdataw )( void ),
		microservice_update( msupdata )( void ),
		interface_registration( intfdataw )( void ),
		interface_update( intfupdata )( void ),
		add_category_to_ms( categorydataw )( void ),
		remove_category_from_ms( categorydataw )( void )
}