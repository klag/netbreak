// strutture dati con semplice id

type logininfo: void {
	.Email: string
	.Password: string
}

type adminid: void {
	.Id: int
}

type clientid: void {
	.Id: int
}

type modentryid: void {
	.Id: int
}

type modtypeid: void {
	.Id: int
}

type clienttypeid: void {
	.Id: int
}

// strutture dati con altri dati

type admindata: void {
	.IdAdmin: int
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
}

type clientdata: void {
	.IdClient: int
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
	.Avatar: string
	.Credits: int
}

type clientfullnamedata: void {
	.Name: string
	.Surname: string
}

type typeiddata: void {
	.ClientType: int
}

type entrydata: void {
	.IdEntry: int
	.IdClient: int
	.IdAdmin: int
	.Timestamp: string
	.ModType: int
	.Report: string
}

type modtypedata: void {
	.IdModType: int
	.Name: string
	.Description: string
}

type clienttypedata: void {
	.IdClientType: int
	.Name: string
	.Description: string
}

type basicclientdata: void {
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
	.Avatar: string
	.AboutMe: string
	.Citizenship: string
	.LinkToSelf: string
	.PayPal: string
}

type developerdata: void {
	.IdClient: int
	.AboutMe: string
	.Citizenship: string
	.LinkToSelf: string
	.PayPal: string
}

type entrydataw: void {
	.IdClient: int
	.IdAdmin: int
	.Timestamp: string
	.ModType: int
	.Report: string
}

type userdata: void {
	.IdClient: int
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
	.Avatar: string
	.Credits: int
	.AboutMe: string
	.Citizenship: string
	.LinkToSelf: string
	.PayPal: string
}

interface user_dbInterface {
	RequestResponse:
	    user_exists(logininfo)(bool),
		retrieve_admin_info( adminid )( admindata ),
		retrieve_client_info( clientid )( clientdata ),
		retrieve_client_fullname( clientid )( clientfullnamedata ),
		retrieve_client_type( clientid )( typeiddata ),
		retrieve_moderation_info( modentryid )( entrydata ),
		retrieve_modtype_info( modtypeid )( modtypedata ),
		retrieve_clienttype_info( clienttypeid )( clienttypedata ),
		
		basicclient_registration( basicclientdata )( void ),
		developer_upgrade( developerdata )( void ),
		basicclient_downgrade( clientid )( void ),
		client_moderation( entrydataw )( void ),
		client_update( userdata )( void ),
		client_delete( clientid )( void )
}