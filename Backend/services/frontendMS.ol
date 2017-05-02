include "frontendInterface.iol"

include "console.iol"
include "database.iol"

execution { concurrent }

outputPort user_db_readerOutput {
	Location: "socket://localhost:8201"
	Protocol: sodep
	Interfaces: user_db_readerInterface
}

outputPort user_db_readerJSONOutput {
	Location: "socket://localhost:8101"
	Protocol: http { 
  		//Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
		.response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
		.response.headers.("Access-Control-Allow-Origin") = "*";
		.response.headers.("Access-Control-Allow-Headers") = "Content-Type";
  		.format = "json"
  	}
	Interfaces: user_db_readerInterface
}

outputPort microservices_db_readerOutput {
	Location: "socket://localhost:8221"
	Protocol: sodep
	Interfaces: microservices_db_readerInterface
}

outputPort microservices_db_readerJSONOutput {
	Location: "socket://localhost:8121"
	Protocol: http { 
  		//Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
		.response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
		.response.headers.("Access-Control-Allow-Origin") = "*";
		.response.headers.("Access-Control-Allow-Headers") = "Content-Type";
  		.format = "json"
  	}
	Interfaces: microservices_db_readerInterface
}

inputPort frontendInput {
	Location: "socket://localhost:8200"
	Protocol: sodep
	Interfaces: frontendInterface
	Aggregates: 
		user_db_readerOutput,
		microservices_db_readerOutput
}

inputPort frontendJSONInput {
	Location: "socket://localhost:8100"
	Protocol: http { 
  		//Access-Control-Allow-Origin response header to tell the browser that the content of this page is accessible to certain origins
		.response.headers.("Access-Control-Allow-Methods") = "POST,GET,OPTIONS";
		.response.headers.("Access-Control-Allow-Origin") = "*";
		.response.headers.("Access-Control-Allow-Headers") = "Content-Type";
  		.format = "json"
  	}
	Interfaces: frontendInterface
}

init 
{
	println@Console( "Front-End Microservice started" )()
}

main
{
	[homepage_ms_list( request )( response ) {
		shownumber.Number = 5;
		println@Console("Getting last registered microservices")();
		
		retrieve_last_registered_ms@microservices_db_readerJSONOutput( shownumber )( lastmsreglist );
		for( i=0, i<#lastmsreglist.MSRegListData, i++ ) {
    		with ( lastmsreglist.MSRegListData[i] ) {
    			response.HomepageMSData[i].Name = .Name;
    			response.HomepageMSData[i].Logo = .Logo;
    			msid.Id = .IdMS;
    			devid.Id = .IdDeveloper
    		};
    		retrieve_client_fullname@user_db_readerJSONOutput( devid )( fullname );
    		with( fullname ) {
    			response.HomepageMSData[i].DeveloperName = .Name;
    			response.HomepageMSData[i].DeveloperSurname = .Surname
    		};
    		retrieve_categories_of_ms@microservices_db_readerJSONOutput( msid )( mscategoriesidlist );
    		for( j=0, j<#mscategoriesidlist.CategoryIdListData, j++ ) {
    			categoryid.Id = mscategoriesidlist.CategoryIdListData[j].IdCategory;
    			retrieve_category_info@microservices_db_readerJSONOutput( categoryid )( mscategorydata );
    			for( k=0, k<#mscategorydata.CategoryData, k++ ) {
    				with ( mscategorydata.CategoryData[k] ) {
      					response.HomepageMSData[i].Category[j].Name = .Name;
    					response.HomepageMSData[i].Category[j].Image = .Image
    				}
				}
  			}

 		}
	}]
}