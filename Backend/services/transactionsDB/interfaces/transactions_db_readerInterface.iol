// retrieve apikey info

type apikeydata: void {
	.IdMS: int
	.IdClient: int
	.Remaining: int
}

type apikeyfound: void {
	.APIKeyData: apikeydata
}

type apikeyid: void {
	.Id: int
}

// retrieve purchases list of a client

type purchaseslistdata: void {
	.IdPurchase: int
	.Timestamp: string
	.Price: int
	.Amount: int
} 

type purchaseslistfound: void {
	.PurchasesListData [0,*]: purchaseslistdata
}

type clientid: void {
	.Id: int
}

interface transactions_db_readerInterface {
	RequestResponse:
		retrieve_apikey_info( apikeyid )( apikeyfound ),
		retrieve_purchases_list( clientid )( purchaseslistfound )
}