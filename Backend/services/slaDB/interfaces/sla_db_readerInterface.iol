// retrieve sla survey info from specific api key

type apikeyid: void {
	.Id: int
}

type slasurveylistdata: void {
	.IdMS: int
	.Timestamp: string
	.ResponseTime: double
	.IsCompliant: bool
}

type slasurveylistfound: void {
	.SlaSurveyListData [0,*]: slasurveylistdata
}

// retrieve sla survey info from specific ms

type msid: void {
	.Id: int
}

type slasurveylistmsdata: void {
	.Timestamp: string
	.ResponseTime: double
	.IsCompliant: bool
}

type slasurveylistmsfound: void {
	.SlaSurveyListMSData [0,*]: slasurveylistmsdata
}

// retrieve sla survey info

type slasurveydata: void {
	.IdSLASurvey: int
	.IdMS: int
	.Timestamp: string
	.ResponseTime: double
	.IsCompliant: bool
}

type slasurveyfound: void {
	.SlaSurveyData: slasurveydata
}

type slasurveyid: void {
	.Id: int
}

// retrieve sla survey iscompliant

type iscompliantdata: void {
	.IsCompliant: bool
}

type iscompliantfound: void {
	.IsCompliantData: iscompliantdata
}

interface sla_db_readerInterface {
	RequestResponse:
		retrieve_apikey_slasurvey_list( apikeyid )( slasurveylistfound ),
		retrieve_ms_slasurvey_list( msid )( slasurveylistmsfound ),
		retrieve_slasurvey_info( slasurveyid )( slasurveyfound ),
		retrieve_slasurvey_iscompliant( slasurveyid )( iscompliantfound )
}