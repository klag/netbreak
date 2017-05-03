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

// retrieve microservices list from category

type msidbycatlistdata: void {
	.IdMS: int
} 

type msidbycatlistfound: void {
	.MSIdByCatListData [0,*]: msidbycatlistdata
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

// retrieve last shownumber ms list

type msreglistdata: void {
	.IdMS: int
	.Name: string
	.IdDeveloper: int
	.Logo: string
}

type lastmsreglistfound: void {
	.MSRegListData [0,*]: msreglistdata
}

type shownumber: void {
	.Number: int
}

// retrieve last shownumber ms list by category

type shownumberandidms: void {
	.Number: int
	.IdMS: int
}

type msregbyidlistdata: void {
	.Name: string
	.IdDeveloper: int
	.Logo: string
}

type lastmsregbyidlistfound: void {
	.MSRegByIdListData [0,*]: msregbyidlistdata
}

interface microservices_db_readerInterface {
	RequestResponse:
		retrieve_ms_info( msid )( msfound ),
		retrieve_intf_info( intfid )( intffound ),
		retrieve_interfaces_of_ms( msid )( intfidlistfound ),
		retrieve_ms_from_interface( intfid )( msidfound ),
		retrieve_msidlist_from_category( categoryid )( msidbycatlistfound ),
		retrieve_category_info( categoryid )( categoryfound ),
		retrieve_categories_of_ms( msid )( categoryidlistfound ),
		retrieve_last_registered_ms( shownumber )( lastmsreglistfound ),
		retrieve_last_registered_ms_byid( shownumberandidms )( lastmsregbyidlistfound )
}