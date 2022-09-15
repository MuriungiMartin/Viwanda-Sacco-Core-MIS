
Report 50488 "Members List 2"
{
    RDLCLayout = 'Layouts/MembersList2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Employer Code", Gender, "Registration Date", Status, "Current Shares", "Shares Retained";

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
            trigger OnPreDataItem();
            begin
                Company.Get();
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
        ;

    end;

    var
        Company: Record "Company Information";


    var
}
