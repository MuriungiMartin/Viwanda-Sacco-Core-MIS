#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50926 "Default Notices Register"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Demand Notice Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Members Register"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                    "Member ID No" := ObjCust."ID No.";
                    "Member Mobile Phone No" := ObjCust."Mobile Phone No";
                    "Member House Group" := ObjCust."Member House Group";
                    "Member House Group Name" := ObjCust."Member House Group Name";
                end;
            end;
        }
        field(3; "Member Name"; Code[50])
        {
        }
        field(4; "Loan In Default"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"));

            trigger OnValidate()
            begin
                if ObjLoans.Get("Loan In Default") then begin
                    //ObjSurestep.FnGetLoanArrearsAmountII("Loan In Default");

                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    "Loan Product" := ObjLoans."Loan Product Type";
                    "Loan Instalments" := ObjLoans.Installments;
                    "Loan Disbursement Date" := ObjLoans."Loan Disbursement Date";
                    "Expected Completion Date" := ObjLoans."Expected Date of Completion";
                    //VarAmountInArrears:=ObjSurestep.FnGetLoanAmountinArrears("Loan In Default");
                    "Amount In Arrears" := ObjLoans."Amount in Arrears";
                    "Days In Arrears" := ObjLoans."Days In Arrears";
                    "Loan Outstanding Balance" := ObjLoans."Outstanding Balance";
                    "Loan Issued" := ObjLoans."Approved Amount";
                end;
            end;
        }
        field(5; "Loan Product"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(6; "Loan Instalments"; Integer)
        {
        }
        field(7; "Loan Disbursement Date"; Date)
        {
        }
        field(8; "Expected Completion Date"; Date)
        {
        }
        field(9; "Amount In Arrears"; Decimal)
        {
        }
        field(10; "Loan Outstanding Balance"; Decimal)
        {
        }
        field(11; "Notice Type"; Option)
        {
            OptionCaption = ' ,1st Demand Notice,2nd Demand Notice,CRB Notice,Debt Collector Notice';
            OptionMembers = " ","1st Demand Notice","2nd Demand Notice","CRB Notice","Debt Collector Notice";
        }
        field(12; "Demand Notice Date"; Date)
        {
        }
        field(13; "User ID"; Code[20])
        {
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; "Email Sent"; Boolean)
        {
        }
        field(16; "SMS Sent"; Boolean)
        {
        }
        field(17; "Auctioneer No"; Code[20])
        {
            TableRelation = Vendor."No." where(Auctioneer = filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Auctioneer No") then begin
                    "Auctioneer  Name" := ObjAccount.Name;
                    "Auctioneer Address" := ObjAccount.Address;
                    "Auctioneer Mobile No" := ObjAccount."Mobile Phone No";
                    "Auctioneer Email" := ObjAccount."E-Mail";
                end;
            end;
        }
        field(18; "Auctioneer  Name"; Code[50])
        {
        }
        field(19; "Auctioneer Address"; Code[50])
        {
        }
        field(20; "Auctioneer Mobile No"; Code[20])
        {
        }
        field(21; "Member ID No"; Code[20])
        {
        }
        field(22; "Member Mobile Phone No"; Code[20])
        {
        }
        field(23; "Loan Issued"; Decimal)
        {
        }
        field(24; "Member House Group"; Code[20])
        {
        }
        field(25; "Member House Group Name"; Code[100])
        {
        }
        field(26; "Days In Arrears"; Integer)
        {
        }
        field(27; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(28; "Auctioneer Email"; Text[50])
        {
        }
        field(29; "Approver User"; Code[100])
        {
        }
        field(30; "Approver Designation"; Text[50])
        {
        }
        field(31; "Approver Signature"; MediaSet)
        {
        }
        field(32; "Approver User II"; Code[100])
        {
        }
        field(33; "Approver Designation II"; Text[50])
        {
        }
        field(34; "Approver Signature II"; MediaSet)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Loan In Default", "Days In Arrears")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Member No", "Member Name", "Loan In Default")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Demand Notice Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Demand Notice Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Demand Notice Date" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjCust: Record "Members Register";
        ObjLoans: Record "Loans Register";
        ObjSurestep: Codeunit "SURESTEP Factory";
        VarAmountInArrears: Decimal;
}

