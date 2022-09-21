#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516045_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50045 "Destroyed ATM Cards Report"
{
    RDLCLayout = 'Layouts/DestroyedATMCardsReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("ATM Card Applications"; "ATM Card Applications")
        {
            DataItemTableView = where(Destroyed = const(true));
            RequestFilterFields = "Account No", "Order ATM Card", "Card Received", "Card Received On", "Destroyed By";
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
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

            column(UserId; UserId)
            {
            }
            column(EntryNo; EntryNo)
            {
            }
            column(ATMCardFeeCharged_ATMCardApplications; "ATM Card Applications"."ATM Card Fee Charged")
            {
            }
            column(ATMCardFeeChargedOn_ATMCardApplications; Format("ATM Card Applications"."ATM Card Fee Charged On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ATMCardFeeChargedBy_ATMCardApplications; "ATM Card Applications"."ATM Card Fee Charged By")
            {
            }
            column(ATMCardLinked_ATMCardApplications; "ATM Card Applications"."ATM Card Linked")
            {
            }
            column(ATMCardLinkedBy_ATMCardApplications; "ATM Card Applications"."ATM Card Linked By")
            {
            }
            column(ATMCardLinkedOn_ATMCardApplications; Format("ATM Card Applications"."ATM Card Linked On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(RequestType_ATMCardApplications; "ATM Card Applications"."Request Type")
            {
            }
            column(ApplicationDate_ATMCardApplications; Format("ATM Card Applications"."Application Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(CardNo_ATMCardApplications; "ATM Card Applications"."Card No")
            {
            }
            column(DateIssued_ATMCardApplications; Format("ATM Card Applications"."Date Issued", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(DateActivated_ATMCardApplications; "ATM Card Applications"."Date Activated")
            {
            }
            column(DateFrozen_ATMCardApplications; "ATM Card Applications"."Date Frozen")
            {
            }
            column(ReplacementForCardNo_ATMCardApplications; "ATM Card Applications"."Replacement For Card No")
            {
            }
            column(HasOtherAccounts_ATMCardApplications; "ATM Card Applications"."Has Other Accounts")
            {
            }
            column(DateCollected_ATMCardApplications; Format("ATM Card Applications"."Date Collected", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(CardIssuedBy_ATMCardApplications; "ATM Card Applications"."Card Issued By")
            {
            }
            column(ApprovalDate_ATMCardApplications; "ATM Card Applications"."Approval Date")
            {
            }
            column(ReasonforAccountblocking_ATMCardApplications; "ATM Card Applications"."Reason for Account blocking")
            {
            }
            column(ATMExpiryDate_ATMCardApplications; "ATM Card Applications"."ATM Expiry Date")
            {
            }
            column(OrderATMCard_ATMCardApplications; "ATM Card Applications"."Order ATM Card")
            {
            }
            column(OrderedBy_ATMCardApplications; "ATM Card Applications"."Ordered By")
            {
            }
            column(OrderedOn_ATMCardApplications; Format("ATM Card Applications"."Ordered On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(CardReceived_ATMCardApplications; "ATM Card Applications"."Card Received")
            {
            }
            column(ReceivedBy_ATMCardApplications; "ATM Card Applications"."Card Received By")
            {
            }
            column(ReceivedOn_ATMCardApplications; Format("ATM Card Applications"."Card Received On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(AccountCategory_ATMCardApplications; "ATM Card Applications"."Account Category")
            {
            }
            column(IDNo_ATMCardApplications; "ATM Card Applications"."ID No")
            {
            }
            column(No_ATMCardApplications; "ATM Card Applications"."No.")
            {
            }
            column(AccountNo_ATMCardApplications; "ATM Card Applications"."Account No")
            {
            }
            column(BranchCode_ATMCardApplications; "ATM Card Applications"."Branch Code")
            {
            }
            column(AccountType_ATMCardApplications; "ATM Card Applications"."Account Type")
            {
            }
            column(AccountName_ATMCardApplications; "ATM Card Applications"."Account Name")
            {
            }
            column(AccountType; AccountType)
            {
            }
            column(PinReceivedBy_ATMCardApplications; "ATM Card Applications"."Pin Received By")
            {
            }
            column(PinReceivedOn_ATMCardApplications; "ATM Card Applications"."Pin Received On")
            {
            }
            column(Destroyed_ATMCardApplications; "ATM Card Applications".Destroyed)
            {
            }
            column(DestroyedBy_ATMCardApplications; "ATM Card Applications"."Destroyed By")
            {
            }
            column(DestroyedOn_ATMCardApplications; "ATM Card Applications"."Destroyed On")
            {
            }
            column(DestructionApproval_ATMCardApplications; "ATM Card Applications"."Destruction Approval")
            {
            }
            column(DaysInWaiting; DaysInWaiting)
            {
            }
            dataitem(Vendor; Vendor)
            {
                column(ReportForNavId_42; 42) { } // Autogenerated by ForNav - Do not delete
                column(AssignedNo_Vendor; Vendor."Assigned No.")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                EntryNo := EntryNo + 1;
                if ObjAccounts.Get("Account No") then begin
                    if ObjAccountTypes.Get(ObjAccounts."Account Type") then begin
                        AccountType := ObjAccountTypes.Description;
                    end;
                end;
                DaysInWaiting := "ATM Card Applications"."Destroyed On" - "ATM Card Applications"."Application Date";
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
                group(Options)
                {
                    Caption = 'Options';

                }
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
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;

    end;

    var
        Company: Record "Company Information";
        EntryNo: Integer;
        ObjAccounts: Record Vendor;
        AccountType: Code[30];
        ObjAccountTypes: Record "Account Types-Saving Products";
        DaysInWaiting: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516045_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
