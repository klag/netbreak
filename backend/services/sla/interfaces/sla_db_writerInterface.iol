// insert new sla survey 

type slasurveydataw: void {
	.IdAPIKey: int
	.IdMS: int
	.Timestamp: string
	.ResponseTime: string
	.IsCompliant: bool
}

interface sla_db_writerInterface {
	RequestResponse:
		slasurvey_insert( slasurveydataw )( void )
}