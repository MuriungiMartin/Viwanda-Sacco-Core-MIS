
Report 50488 "Members List 2"
{
    RDLCLayout = 'Layouts/MembersList2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Members Register"; "Members Register")
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
            column(Personal_No; "Members Register"."Payroll No")
            {
            }
            column(Registration_Date; Format("Members Register"."Registration Date"))
            {
            }
            column(Share_Capital; "Members Register"."Shares Retained")
            {
            }
            column(Deposits; "Members Register"."Monthly Contribution")
            {
                AutoCalcField = true;
            }
            column(EMail_MembersRegister; "Members Register"."E-Mail")
            {
            }
            column(No_MembersRegister; "Members Register"."No.")
            {
            }
            column(Name_MembersRegister; "Members Register".Name)
            {
            }
            column(Address_MembersRegister; "Members Register".Address)
            {
            }
            column(PhoneNo_MembersRegister; "Members Register"."Phone No.")
            {
            }
            column(RiskFund_MembersRegister; "Members Register"."Risk Fund")
            {
            }
            column(FOSAAccountNo_MembersRegister; "Members Register"."FOSA Account No.")
            {
            }
            column(SharesRetained_MembersRegister; "Members Register"."Shares Retained")
            {
            }
            column(CurrentShares_MembersRegister; "Members Register"."Current Shares")
            {
            }
            column(Status_MembersRegister; "Members Register".Status)
            {
            }
            column(DividendAmount_MembersRegister; "Members Register"."Dividend Amount")
            {
            }
            column(FOSAShares_MembersRegister; "Members Register"."FOSA Shares")
            {
            }
            column(mobile_number; "Members Register"."Mobile Phone No")
            {
            }
            column(id; "Members Register"."ID No.")
            {
            }
            column(branch; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(category; "Members Register"."Account Category")
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
