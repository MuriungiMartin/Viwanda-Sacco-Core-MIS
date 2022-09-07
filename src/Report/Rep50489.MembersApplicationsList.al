
Report 50489 "Members Applications List"
{
    RDLCLayout = 'Layouts/MembersApplicationsList.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Membership Applications"; "Membership Applications")
        {
            RequestFilterFields = "Registration Date", "Employer Code", Status, Gender;

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
            column(No_MembershipApplications; "Membership Applications"."No.")
            {
            }
            column(Name_MembershipApplications; "Membership Applications".Name)
            {
            }
            column(Address_MembershipApplications; "Membership Applications".Address)
            {
            }
            column(PhoneNo_MembershipApplications; "Membership Applications"."Phone No.")
            {
            }
            column(RegistrationDate_MembershipApplications; Format("Membership Applications"."Registration Date"))
            {
            }
            column(EmployerCode_MembershipApplications; "Membership Applications"."Employer Code")
            {
            }
            column(DateofBirth_MembershipApplications; Format("Membership Applications"."Date of Birth"))
            {
            }
            column(EMailPersonal_MembershipApplications; "Membership Applications"."E-Mail (Personal)")
            {
            }
            column(PersonalNo_MembershipApplications; "Membership Applications"."Payroll No")
            {
            }
            column(IDNo_MembershipApplications; "Membership Applications"."ID No.")
            {
            }
            column(MobilePhoneNo_MembershipApplications; "Membership Applications"."Mobile Phone No")
            {
            }
            column(Gender_MembershipApplications; "Membership Applications".Gender)
            {
            }
            column(EmployerName_MembershipApplications; "Membership Applications"."Employer Name")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
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
