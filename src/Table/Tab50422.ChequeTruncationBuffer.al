#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50422 "Cheque Truncation Buffer"
{

    fields
    {
        field(1; ChequeDataId; Integer)
        {
            AutoIncrement = true;
        }
        field(2; SerialId; Integer)
        {
        }
        field(3; FilePathName; Text[200])
        {
        }
        field(4; RCODE; Code[10])
        {
        }
        field(5; VTYPE; Code[10])
        {
        }
        field(6; AMOUNT; Decimal)
        {
        }
        field(7; ENTRYMODE; Code[10])
        {
        }
        field(8; CURRENCYCODE; Code[10])
        {
        }
        field(9; DESTBANK; Code[10])
        {
        }
        field(10; DESTBRANCH; Code[10])
        {
        }
        field(11; DESTACC; Code[20])
        {
        }
        field(12; CHQDGT; Code[10])
        {
        }
        field(13; PBANK; Code[10])
        {
        }
        field(14; PBRANCH; Code[10])
        {
        }
        field(15; FILLER; Code[10])
        {
        }
        field(16; COLLACC; Code[20])
        {
        }
        field(17; MemberNo; Code[50])
        {
        }
        field(18; MembId; Integer)
        {
        }
        field(19; MembShareId; Integer)
        {
        }
        field(20; SNO; Code[10])
        {
        }
        field(21; PROCNO; Code[10])
        {
        }
        field(22; FIMAGESIZEBW; Integer)
        {
        }
        field(23; FIMAGESIGNBW; Integer)
        {
        }
        field(24; FIMAGESIZE; Integer)
        {
        }
        field(25; FIMAGESIGN; Integer)
        {
        }
        field(26; BIMAGESIZE; Integer)
        {
        }
        field(27; BIMAGESIGN; Integer)
        {
        }
        field(28; FrontBWImage; Blob)
        {
            SubType = Bitmap;
        }
        field(29; FrontGrayScaleImage; Blob)
        {
            SubType = Bitmap;
        }
        field(30; RearImage; Blob)
        {
            SubType = Bitmap;
        }
        field(31; IsFCY; Boolean)
        {
        }
        field(32; Supflag; Code[10])
        {
        }
        field(33; CreatedBy; Text[100])
        {
        }
        field(34; CreatedOn; DateTime)
        {
        }
        field(35; SupervisedBy; Text[100])
        {
        }
        field(36; SupervisedOn; DateTime)
        {
        }
        field(37; ModifiedBy; Text[100])
        {
        }
        field(38; ModifiedOn; DateTime)
        {
        }
        field(39; UploadedFileId; Integer)
        {
        }
        field(40; "Imported to Receipt Lines"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; ChequeDataId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

