// apikey registration

type apikeydataw: void {
	.IdMS: int
	.IdClient: int
	.Remaining: int
}

// purchase registration

type purchasedata: void {
	.IdAPIKey: int
	.IdClient: int
	.Timestamp: string
	.Price: int
	.Amount: int
}

// apikey remaining update

type apikeyremainingdata: void {
	.IdAPIKey: int
	.Number: int
}

interface transactions_db_writerInterface {
	RequestResponse:
		apikey_registration( apikeydataw )( void ),
		purchase_registration( purchasedata )( void ),
		apikey_remaining_update( apikeyremainingdata )( void )
}