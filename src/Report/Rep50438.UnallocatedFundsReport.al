#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516438_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50438 "Unallocated Funds Report"
{
    RDLCLayout = 'Layouts/UnallocatedFundsReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Un-allocated Funds" = filter(< 0));
            RequestFilterFields = "No.", "Employer Code", Gender, "Registration Date", Status, "Current Shares", "Shares Retained";
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }

            column(UserId; UserId)
            {
            }
            column(Personal_No; Customer."Payroll No")
            {
            }
            column(Registration_Date; Format(Customer."Registration Date"))
            {
            }
            column(Share_Capital; Customer."Shares Retained")
            {
            }
            column(Deposits; Customer."Monthly Contribution")
            {
                AutoCalcField = true;
            }
            column(EMail_MembersRegister; Customer."E-Mail")
            {
            }
            column(No_MembersRegister; Customer."No.")
            {
            }
            column(Name_MembersRegister; Customer.Name)
            {
            }
            column(Address_MembersRegister; Customer.Address)
            {
            }
            column(PhoneNo_MembersRegister; Customer."Phone No.")
            {
            }
            column(RiskFund_MembersRegister; Customer."Risk Fund")
            {
            }
            column(FOSAAccountNo_MembersRegister; Customer."FOSA Account No.")
            {
            }
            column(SharesRetained_MembersRegister; Customer."Shares Retained")
            {
            }
            column(CurrentShares_MembersRegister; Customer."Current Shares")
            {
            }
            column(Status_MembersRegister; Customer.Status)
            {
            }
            column(DividendAmount_MembersRegister; Customer."Dividend Amount")
            {
            }
            column(FOSAShares_MembersRegister; Customer."FOSA Shares")
            {
            }
            column(mobile_number; Customer."Mobile Phone No")
            {
            }
            column(id; Customer."ID No.")
            {
            }
            column(branch; Customer."Global Dimension 2 Code")
            {
            }
            column(category; Customer."Account Category")
            {
            }
            column(SN; SN)
            {
            }
            column(UnAllocated; Customer."Un-allocated Funds")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1
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
    //51516438_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
