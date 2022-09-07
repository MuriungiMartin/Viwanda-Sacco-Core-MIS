#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50423 "Cheque Uploaded Files"
{

    fields
    {
        field(1; UploadedFileId; Integer)
        {
            AutoIncrement = true;
        }
        field(2; UploadedFileName; Text[200])
        {
        }
        field(3; FileStatus; Text[200])
        {
        }
        field(4; CreatedBy; Text[200])
        {
        }
        field(5; CreatedOn; DateTime)
        {
        }
        field(6; ModifiedBy; Text[200])
        {
        }
        field(7; ModifiedOn; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; UploadedFileId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

