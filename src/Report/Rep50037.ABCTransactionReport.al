#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516037_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50037 "ABC Transaction Report"
{
    RDLCLayout = 'Layouts/ABCTransactionReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = where(Posted = filter(true), "Transaction Type" = filter('ABC'));
            RequestFilterFields = "Date Posted", "ABC Transaction Type";
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(No_Transactions; Transactions.No)
            {
            }
            column(AccountNo_Transactions; Transactions."Account No")
            {
            }
            column(Amount_Transactions; Transactions.Amount)
            {
            }
            column(ABCTransactionType_Transactions; Transactions."ABC Transaction Type")
            {
            }
            column(ABCDepositer_Transactions; Transactions."ABC Depositer")
            {
            }
            column(ABCDepositerID_Transactions; Transactions."ABC Depositer ID")
            {
            }
            column(Date; Transactions."Transaction Date")
            {
            }
            column(Time; Transactions."Transaction Time")
            {
            }
            column(Dexcs; Transactions.Description)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAdd; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAdd2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
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
        CompanyInfo: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516037_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
