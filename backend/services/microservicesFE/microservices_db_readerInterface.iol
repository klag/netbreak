// retrieve categories of a microservice

type categoryidlistdata: void {
	.IdCategory: int
} 

type categoryidlistfound: void {
	.CategoryIdListData [0,*]: categoryidlistdata
}

// retrieve category info

type categorydata: void {
	.Name: string
	.Image: string
}

type categoryfound: void {
	.CategoryData: categorydata
}

type categoryid: void {
	.Id: int
}

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

// retrieve last 5 api id

type msreglistdata: void {
	.Name: string
	.Logo: string
}

type lastmsreglistfound: void {
	.MSRegListData [0,*]: msreglistdata
}

type shownumber: void {
	.number: int
}

interface microservices_db_readerInterface {
	RequestResponse:
		retrieve_ms_info( msid )( msfound ),
		retrieve_intf_info( intfid )( intffound ),
		retrieve_interfaces_of_ms( msid )( intfidlistfound ),
		retrieve_ms_from_interface( intfid )( msidfound ),
		retrieve_category_info( categoryid )( categoryfound ),
		retrieve_categories_of_ms( msid )( categoryidlistfound ),
		retrieve_last_registered_ms( shownumber )( lastmsreglistfound )
}