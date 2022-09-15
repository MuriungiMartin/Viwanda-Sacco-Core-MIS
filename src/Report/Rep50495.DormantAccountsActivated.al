
Report 50495 "Dormant Accounts Activated"
{
    RDLCLayout = 'Layouts/DormantAccountsActivated.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Change Request"; "Change Request")
        {
            DataItemTableView = where(Changed = const(true), "Member Account Status(NewValu)" = const(" "));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Captured by", "Capture Date";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(SN; SN)
            {
            }
            column(No_ChangeRequest; "Change Request".No)
            {
            }
            column(Type_ChangeRequest; "Change Request".Type)
            {
            }
            column(Reasonforchange_ChangeRequest; "Change Request"."Reason for change")
            {
            }
            column(Capturedby_ChangeRequest; "Change Request"."Captured by")
            {
            }
            column(CaptureDate_ChangeRequest; "Change Request"."Capture Date")
            {
            }
            column(MemberStatus_ChangeRequest; "Change Request"."Member Account Status")
            {
            }
            column(MemberStatusNew_ChangeRequest; "Change Request"."Member Account Status(NewValu)")
            {
            }
            column(Name_ChangeRequest; "Change Request".Name)
            {
            }
            column(AccountNo_ChangeRequest; "Change Request"."Account No")
            {
            }
            column(ChargeReactivationFee_ChangeRequest; "Change Request"."Charge Reactivation Fee")
            {
            }
            column(VarDormancyDate; Format(VarDormancyDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Account No");

                column(ComputerName_MembersRegister; Customer."Computer Name")
                {
                }
                column(StatusChangeDate_MembersRegister; Customer."Status Change Date")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
                VarLastTransactionDate := 0D;
                //==================================================================================Get Dormancy Date
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."No.", "Change Request"."Account No");
                if ObjAccounts.FindSet then begin
                    if ObjProductType.Get("Change Request"."Account Type") then begin
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Change Request"."Account No");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", '<%1', "Change Request"."Capture Date");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Document No.", '<>%1', 'BALB/F9THNOV2018');
                        if ObjAccountLedger.FindLast then begin
                            VarLastTransactionDate := ObjAccountLedger."Posting Date";
                        end;
                        if VarLastTransactionDate = 0D then begin
                            ObjAccountLedgerHistorical.Reset;
                            ObjAccountLedgerHistorical.SetRange(ObjAccountLedgerHistorical."Account No.", "Change Request"."Account No");
                            ObjAccountLedgerHistorical.SetFilter(ObjAccountLedgerHistorical."Posting Date", '<%1', "Change Request"."Capture Date");
                            if ObjAccountLedgerHistorical.FindLast then begin
                                VarLastTransactionDate := ObjAccountLedgerHistorical."Posting Date";
                            end;
                        end;
                        if VarLastTransactionDate <> 0D then begin
                            VarDormancyDate := CalcDate(ObjProductType."Dormancy Period (M)", VarLastTransactionDate);
                        end;
                    end;
                end;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {

            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        Accname: Code[40];
        SN: Integer;
        Company: Record "Company Information";
        Amount: Decimal;
        ObjAccountLedger: Record "Vendor Ledger Entry";
        ObjProductType: Record "Account Types-Saving Products";
        ObjAccounts: Record Vendor;
        VarLastTransactionDate: Date;
        VarDormancyDate: Date;
        ObjAccountLedgerHistorical: Record "Member Historical Ledger Entry";


    var

}
