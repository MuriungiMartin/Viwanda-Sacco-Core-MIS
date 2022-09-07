
Report 50526 "EFT Transfers"
{
    RDLCLayout = 'Layouts/EFTTransfers.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("EFT/RTGS Header"; "EFT/RTGS Header")
        {
            column(No_EFTHeaderDetails; "EFT/RTGS Header".No)
            {
            }
            column(NoSeries_EFTHeaderDetails; "EFT/RTGS Header"."No. Series")
            {
            }
            column(Transferred_EFTHeaderDetails; "EFT/RTGS Header".Transferred)
            {
            }
            column(DateTransferred_EFTHeaderDetails; "EFT/RTGS Header"."Date Transferred")
            {
            }
            column(TimeTransferred_EFTHeaderDetails; "EFT/RTGS Header"."Time Transferred")
            {
            }
            column(TransferredBy_EFTHeaderDetails; "EFT/RTGS Header"."Transferred By")
            {
            }
            column(DateEntered_EFTHeaderDetails; "EFT/RTGS Header"."Date Entered")
            {
            }
            column(TimeEntered_EFTHeaderDetails; "EFT/RTGS Header"."Time Entered")
            {
            }
            column(EnteredBy_EFTHeaderDetails; "EFT/RTGS Header"."Entered By")
            {
            }
            column(Remarks_EFTHeaderDetails; "EFT/RTGS Header"."Transaction Description")
            {
            }
            column(PayeeBankName_EFTHeaderDetails; "EFT/RTGS Header"."Payee Bank Name")
            {
            }
            column(BankNo_EFTHeaderDetails; "EFT/RTGS Header"."Bank  No")
            {
            }
            column(SalaryProcessingNo_EFTHeaderDetails; "EFT/RTGS Header"."Salary Processing No.")
            {
            }
            column(SalaryOptions_EFTHeaderDetails; "EFT/RTGS Header"."Salary Options")
            {
            }
            column(Total_EFTHeaderDetails; "EFT/RTGS Header".Total)
            {
            }
            column(TotalCount_EFTHeaderDetails; "EFT/RTGS Header"."Total Count")
            {
            }
            column(RTGS_EFTHeaderDetails; "EFT/RTGS Header".RTGS)
            {
            }
            column(DocumentNoFilter_EFTHeaderDetails; "EFT/RTGS Header"."Document No. Filter")
            {
            }
            column(DateFilter_EFTHeaderDetails; "EFT/RTGS Header"."Date Filter")
            {
            }
            column(Bank_EFTHeaderDetails; "EFT/RTGS Header".Bank)
            {
            }
            dataitem("EFT/RTGS Details"; "EFT/RTGS Details")
            {
                column(DateEntered_EFTDetails; Format("EFT/RTGS Details"."Date Entered"))
                {
                }
                column(TimeEntered_EFTDetails; Format("EFT/RTGS Details"."Time Entered"))
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfo_Address; CompanyInfo.Address)
                {
                }
                column(No_EFTDetails; "EFT/RTGS Details".No)
                {
                }
                column(DateTransferred_EFTDetails; "EFT/RTGS Details"."Date Transferred")
                {
                }
                column(TimeTransferred_EFTDetails; "EFT/RTGS Details"."Time Transferred")
                {
                }
                column(DestinationAccountNo_EFTDetails; "EFT/RTGS Details"."Destination Account No")
                {
                }
                column(DestinationAccountName_EFTDetails; "EFT/RTGS Details"."Destination Account Name")
                {
                }
                column(DestinationAccountType_EFTDetails; "EFT/RTGS Details"."Destination Account Type")
                {
                }
                column(AccountNo_EFTDetails; "EFT/RTGS Details"."Account No")
                {
                }
                column(AccountName_EFTDetails; "EFT/RTGS Details"."Account Name")
                {
                }
                column(AccountType_EFTDetails; "EFT/RTGS Details"."Account Type")
                {
                }
                column(Amount_EFTDetails; "EFT/RTGS Details".Amount)
                {
                }
                trigger OnPreDataItem();
                begin
                    CompanyInfo.Get();
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
                end;

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
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;

    var

}
