#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50497 "Cheque Book Application"
{

    fields
    {
        field(1; "No."; Code[10])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    Noseriesmgt.TestManual(SalesSetup."Cheque Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No." where(Status = filter(Active | Dormant));

            trigger OnValidate()
            begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", "Account No.");
                if ObjVendor.Find('-') then begin


                    if ObjVendor."Cheque Clearing No" = '' then begin
                        if ObjNoSeries.Get then begin

                            ObjNoSeries.TestField(ObjNoSeries."Cheque Book Account Nos");
                            VarDocumentNo := Noseriesmgt.GetNextNo(ObjNoSeries."Cheque Book Account Nos", 0D, true);
                            Message(Format(VarDocumentNo));
                            if VarDocumentNo <> '' then begin
                                ObjVendor."Cheque Clearing No" := VarDocumentNo;
                                ObjVendor.Modify;
                            end;
                        end;
                    end;

                    Name := ObjVendor.Name;
                    "ID No." := ObjVendor."ID No.";
                    "Staff No." := ObjVendor."Personal No.";
                    "Member No." := ObjVendor."BOSA Account No";
                    "Cheque Book Account No." := ObjVendor."Cheque Clearing No";
                end;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; "ID No."; Code[50])
        {
        }
        field(5; "Application Date"; Date)
        {
        }
        field(6; "Cheque Book Account No."; Code[20])
        {
        }
        field(7; "Staff No."; Code[20])
        {
        }
        field(8; "Export Format"; Code[10])
        {
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; "Member No."; Code[10])
        {
        }
        field(11; "Responsibility Centre"; Code[10])
        {
        }
        field(12; "Begining Cheque No."; Code[60])
        {

            trigger OnValidate()
            begin
                ChequeSetUp.Reset;
                ChequeSetUp.SetRange(ChequeSetUp."Cheque Code", "Cheque Book Type");
                if ChequeSetUp.Find('-') then begin

                    Evaluate(BeginNo, "Begining Cheque No.");
                    Evaluate(NoofLF, ChequeSetUp."Number Of Leaf");
                    "End Cheque No." := Format(BeginNo + NoofLF - 1);
                    "End Cheque No." := PadStr('', 6 - (StrLen("End Cheque No.")), '0') + "End Cheque No.";
                end;
            end;
        }
        field(13; "End Cheque No."; Code[60])
        {
        }
        field(14; "Application Exported"; Boolean)
        {
        }
        field(15; "Cheque Register Generated"; Boolean)
        {
            Editable = false;
        }
        field(16; Select; Boolean)
        {

            trigger OnValidate()
            begin
                if "Cheque Book charges Posted" = false then
                    Error('Please Post Cheque book charges before exporting');
            end;
        }
        field(17; "Cheque Book charges Posted"; Boolean)
        {
        }
        field(18; "Cheque Book Type"; Code[10])
        {
            TableRelation = "Cheque Set Up";

            trigger OnValidate()
            begin
                ChApp.Reset;
                ChApp.SetRange(ChApp."Account No.", "Account No.");
                ChApp.SetRange(ChApp.Status, ChApp.Status::Approved);
                if ChApp.Find('+') then begin
                    "Begining Cheque No." := IncStr(ChApp."End Cheque No.");

                end;


                //VALIDATE("Begining Cheque No.");
            end;
        }
        field(68005; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(68006; "Last check"; Code[30])
        {
            CalcFormula = max("Cheques Register"."Cheque No." where("Cheque Book Account No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(68007; "Requested By"; Code[20])
        {

            trigger OnValidate()
            begin
                "Requested By" := UserId;
            end;
        }
        field(68008; "Cheque Book Fee Charged"; Boolean)
        {
        }
        field(68009; "Cheque Book Fee Charged On"; Date)
        {
        }
        field(68010; "Cheque Book Fee Charged By"; Code[20])
        {
        }
        field(68015; "Cheque Book Ordered"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Cheque Book Ordered" = true then begin
                    "Ordered By" := UserId;
                    "Ordered On" := Today;
                end;
                if "Cheque Book Ordered" = false then begin
                    "Ordered By" := '';
                    "Ordered On" := 0D;
                end;
            end;
        }
        field(68016; "Ordered By"; Code[20])
        {
        }
        field(68017; "Ordered On"; Date)
        {
        }
        field(68018; "Cheque Book Received"; Boolean)
        {
        }
        field(68019; "Received By"; Code[20])
        {
        }
        field(68020; "Received On"; Date)
        {
        }
        field(68021; "Listed For Destruction"; Boolean)
        {
        }
        field(68022; Destroyed; Boolean)
        {
            Editable = false;
        }
        field(68023; "Destroyed On"; Date)
        {
            Editable = false;
        }
        field(68024; "Destroyed By"; Code[30])
        {
            Editable = false;
        }
        field(68025; Collected; Boolean)
        {
        }
        field(68026; "Date Collected"; Date)
        {
        }
        field(68027; "Card Issued By"; Code[20])
        {
        }
        field(68028; "Issued to"; Text[70])
        {
        }
        field(68029; "Branch Code"; Code[30])
        {
        }
        field(68030; "Date Issued"; Date)
        {
        }
        field(68031; "Cheque Book Issued to Customer"; Option)
        {
            OptionCaption = 'Owner Collected,Card Sent,Card Issued to';
            OptionMembers = "Owner Collected","Card Sent","Card Issued to";
        }
        field(68032; "Issued By"; Code[30])
        {
        }
        field(68033; "Destruction Approval"; Boolean)
        {
        }
        field(68034; "Member No"; Code[30])
        {
            CalcFormula = lookup(Customer."BOSA Account No." where("ID No." = field("ID No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Account No.", Name)
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Cheque Application Nos");
            Noseriesmgt.InitSeries(SalesSetup."Cheque Application Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;



        "Application Date" := Today;
        "Requested By" := UserId;
    end;

    trigger OnModify()
    begin

        /*IF Status=Status::Approved THEN BEGIN
       IF "Cheque Register Generated"=TRUE THEN
       ERROR('Cheque register has already been generated.');
        END;
        */

    end;

    var
        Vend: Record Vendor;
        Noseriesmgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
        acctypes: Record "Account Types-Saving Products";
        LASTNUMBER: Code[60];
        ChequeSetUp: Record "Cheque Set Up";
        "number of leafs": Code[20];
        ChApp: Record "Cheque Book Application";
        BeginNo: Integer;
        NoofLF: Integer;
        ObjVendor: Record Vendor;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
}

