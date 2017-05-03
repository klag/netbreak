// basic client registration

type basicclientdata: void {
	.Name: string
	.Surname: string
	.Email: string
	.Password: string
	.Avatar: string
	.Registration: string
}

// developer upgrade

type developerdata: void {
	.IdClient: int
	.AboutMe: string
	.Citizenship: string
	.LinkToSelf: string
	.PayPal: string
}


// basic client downgrade

type downgradedclient: void {
	.IdClient: int
}

// client moderation

type entrydataw: void {
	.IdClient: int
	.IdAdmin: int
	.Timestamp: string
	.ModType: int
	.Report: string
}

// client update

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

// client delete

type clientid: void {
	.Id: int
}

interface user_db_writerInterface {
	RequestResponse:
		basicclient_registration( basicclientdata )( void ),
		developer_upgrade( developerdata )( void ),
		basicclient_downgrade( downgradedclient )( void ),
		client_moderation( entrydataw )( void ),
		client_update( userdata )( void ),
		client_delete( clientid )( void )
}