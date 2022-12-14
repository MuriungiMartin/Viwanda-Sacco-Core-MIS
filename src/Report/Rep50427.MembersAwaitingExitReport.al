#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516427_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50427 "Members Awaiting Exit Report"
{
    RDLCLayout = 'Layouts/MembersAwaitingExitReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where(Status = const("Awaiting Exit"));
            RequestFilterFields = "No.", Name;
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(CurrentShares_MembersRegister; Customer."Current Shares")
            {
            }
            column(OutstandingBalance_MembersRegister; Customer."Outstanding Balance")
            {
            }
            column(FOSAShares_MembersRegister; Customer."FOSA Shares")
            {
            }
            column(BenevolentFund_MembersRegister; Customer."Benevolent Fund")
            {
            }
            column(FOSASharesAccountNo_MembersRegister; Customer."FOSA Shares Account No")
            {
            }
            column(TLoansGuaranteed_MembersRegister; Customer.TLoansGuaranteed)
            {
            }
            column(Dormancy_MembersRegister; Customer.Dormancy)
            {
            }
            column(Name_MembersRegister; Customer.Name)
            {
            }
            column(No_MembersRegister; Customer."No.")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
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
            column(SN; SN)
            {
            }
            column(WithdrawalDate_MembersRegister; Customer."Withdrawal Date")
            {
            }
            column(WithdrawalApplicationDate_MembersRegister; Customer."Withdrawal Application Date")
            {
            }
            column(ReasonForMembershipWithdraw_MembersRegister; Customer."Reason For Membership Withdraw")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
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
            //:= false;
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
        ;

    end;

    var
        Company: Record "Company Information";
        SN: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516427_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
