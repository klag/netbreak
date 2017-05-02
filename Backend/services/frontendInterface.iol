include "usersDB/interfaces/user_db_readerInterface.iol"
include "microservicesDB/interfaces/microservices_db_readerInterface.iol"

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
		homepage_ms_list( void )( homepagemslistfound )
}