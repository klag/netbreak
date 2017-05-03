include "frontendInterface.iol"

include "console.iol"
include "database.iol"

execution { concurrent }

outputPort user_db_readerOutput {
	Location: "socket://localhost:8201"
	Protocol: sodep
	Interfaces: user_db_readerInterface
}

outputPort user_db_writerOutput {
  Location: "socket://localhost:8202"
  Protocol: sodep
  Interfaces: user_db_writerInterface
}

outputPort microservices_db_readerOutput {
	Location: "socket://localhost:8221"
	Protocol: sodep
	Interfaces: microservices_db_readerInterface
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
		shownumber.Number = 9;
		println@Console("Getting last registered microservices")();
		
		retrieve_last_registered_ms@microservices_db_readerOutput( shownumber )( lastmsreglist );
		for( i=0, i<#lastmsreglist.MSRegListData, i++ ) {
      with ( lastmsreglist.MSRegListData[i] ) {
        response.HomepageMSData[i].Name = .Name;
    		response.HomepageMSData[i].Logo = .Logo;
    		msid.Id = .IdMS;
    		devid.Id = .IdDeveloper
    	};
    	retrieve_client_fullname@user_db_readerOutput( devid )( fullname );
    	with( fullname ) {
    		response.HomepageMSData[i].DeveloperName = .Name;
    		response.HomepageMSData[i].DeveloperSurname = .Surname
    	};
    	retrieve_categories_of_ms@microservices_db_readerOutput( msid )( mscategoriesidlist );
    	for( j=0, j<#mscategoriesidlist.CategoryIdListData, j++ ) {
    		categoryid.Id = mscategoriesidlist.CategoryIdListData[j].IdCategory;
    		retrieve_category_info@microservices_db_readerOutput( categoryid )( mscategorydata );
    		for( k=0, k<#mscategorydata.CategoryData, k++ ) {
    			with ( mscategorydata.CategoryData[k] ) {
      			response.HomepageMSData[i].Category[j].Name = .Name;
    				response.HomepageMSData[i].Category[j].Image = .Image
    			}
				}
  		}
 		}
	}]

	[homepage_filter_cat_list( request )( response ) {
		println@Console("Getting last registered microservices with specified category")();
		
		retrieve_msidlist_from_category@microservices_db_readerOutput( request )( msidlist );
		for( i=0, i<#msidlist.MSIdByCatListData, i++ ) {
      with ( msidlist.MSIdByCatListData[i] ) {
        HomepageMSIds[i].Id = .IdMS
      }
    };
    for( i=0, i<#HomepageMSIds, i++ ) {
      shownumberandidms.Number = 2;
      shownumberandidms.IdMS = HomepageMSIds[i].Id;

      retrieve_last_registered_ms_byid@microservices_db_readerOutput( shownumberandidms )( lastmsbyidreglist );
      for( j=0, j<#lastmsbyidreglist.MSRegByIdListData, j++ ) {
        with ( lastmsbyidreglist.MSRegByIdListData[j] ) {
          response.HomepageMSData[i].Name = .Name;
          response.HomepageMSData[i].Logo = .Logo;
          devid.Id = .IdDeveloper
        }
      };

      retrieve_client_fullname@user_db_readerOutput( devid )( fullname );
      with( fullname ) {
        response.HomepageMSData[i].DeveloperName = .Name;
        response.HomepageMSData[i].DeveloperSurname = .Surname
      };
      
      retrieve_categories_of_ms@microservices_db_readerOutput( HomepageMSIds[i] )( mscategoriesidlist );
      for( k=0, k<#mscategoriesidlist.CategoryIdListData, k++ ) {
        categoryid.Id = mscategoriesidlist.CategoryIdListData[k].IdCategory;
        retrieve_category_info@microservices_db_readerOutput( categoryid )( mscategorydata );
        for( l=0, l<#mscategorydata.CategoryData, l++ ) {
          with ( mscategorydata.CategoryData[l] ) {
            response.HomepageMSData[i].Category[l].Name = .Name;
            response.HomepageMSData[i].Category[l].Image = .Image
          }
        }
      }
    }
	}]

  
}