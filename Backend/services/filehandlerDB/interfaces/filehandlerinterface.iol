type SetFileRequest: void {
	.file: raw
}

type FileMetaData: void {
	.filename: string
	.size: int
}

interface FileHandlerInterface {
RequestResponse:
	setFile( SetFileRequest )( string ),
	filenameExists(string)(bool)
}