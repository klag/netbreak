include "usersDB/interfaces/user_db_readerInterface.iol"
include "usersDB/interfaces/user_db_writerInterface.iol"
include "microservicesDB/interfaces/microservices_db_readerInterface.iol"

// homepage ms list

type homepagecategorydata: void {
	.Name: string
	.Image: string
}

type homepagemsdata: void {
	.Name: string
	.DeveloperName: string
	.DeveloperSurname: string
	.Logo: string
	.Category [0,*]: homepagecategorydata
}

type homepagemslistfound: void {
	.HomepageMSData [0,*]: homepagemsdata
}

interface frontendInterface { 
	RequestResponse:
		homepage_ms_list( void )( homepagemslistfound ),
		homepage_filter_cat_list( categoryid )( homepagemslistfound )
}