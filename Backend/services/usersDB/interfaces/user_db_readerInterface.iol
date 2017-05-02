// retrieve admin info

type admindata: void {
	.IdAdmin: int
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
}

type adminfound: void {
	.AdminData: admindata
}

type adminid: void {
	.Id: int
}

// retrieve client info

type clientdata: void {
	.IdClient: int
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
	.Avatar: string
	.Credits: int
}

type clientfound: void {
	.ClientData: clientdata
}

type clientid: void {
	.Id: int
}

// retrieve client name

type clientfullnamefound: void {
	.Name: string
	.Surname: string
}

// retrieve client type

type typeidfound: void {
	.ClientType: int
}

// retrieve moderation info

type entrydata: void {
	.IdEntry: int
	.IdClient: int
	.IdAdmin: int
	.Timestamp: string
	.ModType: int
	.Report: string
}

type entryfound: void {
	.EntryData: entrydata
}

type modentryid: void {
	.Id: int
}

// retrieve moderation type info

type modtypedata: void {
	.IdModType: int
	.Name: string
	.Description: string
}

type modtypefound: void {
	.ModTypeData: modtypedata
}

type modtypeid: void {
	.Id: int
}

// retrieve client type info

type clienttypedata: void {
	.IdClientType: int
	.Name: string
	.Description: string
}

type clienttypefound: void {
	.ClientTypeData: clienttypedata
}

type clienttypeid: void {
	.Id: int
}

interface user_db_readerInterface {
	RequestResponse:
		retrieve_admin_info( adminid )( adminfound ),
		retrieve_client_info( clientid )( clientfound ),
		retrieve_client_fullname( clientid )( clientfullnamefound ),
		retrieve_client_type( clientid )( typeidfound ),
		retrieve_moderation_info( modentryid )( entryfound ),
		retrieve_modtype_info( modtypeid )( modtypefound ),
		retrieve_clienttype_info( clienttypeid )( clienttypefound )
}