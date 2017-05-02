// microservice registration

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

// microservice update

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

// interface registration

type intfdataw: void {
	.IdMS: int
	.Interf: string
	.Loc: string
	.Protoc: string
}

// interface update

type intfupdata: void {
	.IdInterface: int
	.Interf: string
	.Loc: string
	.Protoc: string
}

// add category to ms

type categorydata: void {
	.IdMS: int
	.IdCategory: int
}

interface microservices_db_writerInterface {
	RequestResponse:
		microservice_registration( msdataw )( void ),
		microservice_update( msupdata )( void ),
		interface_registration( intfdataw )( void ),
		interface_update( intfupdata )( void ),
		add_category_to_ms( categorydata )( void ),
		remove_category_from_ms( categorydata )( void )
}