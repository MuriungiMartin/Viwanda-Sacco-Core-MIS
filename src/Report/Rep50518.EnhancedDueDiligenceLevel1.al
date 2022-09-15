Report 50518 "Enhanced Due Diligence-Level1"
{
    RDLCLayout = 'Layouts/EnhancedDueDiligence-Level1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Individual Customer Risk Rate"; "Individual Customer Risk Rate")
        {
            DataItemTableView = where("What is the Customer Category?" = const('"""Politically Exposed Persons (PEPs)"""'));

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
            column(CUSTOMERNETRISKRATING_IndividualCustomerRiskRate; "Individual Customer Risk Rate"."CUSTOMER NET RISK RATING")
            {
            }
            column(CustomerCategoryScore_IndividualCustomerRiskRate; "Individual Customer Risk Rate"."Customer Category Score")
            {
            }
            column(MembershipApplicationNo_IndividualCustomerRiskRate; "Individual Customer Risk Rate"."Membership Application No")
            {
            }
            column(MemberName_IndividualCustomerRiskRate; "Individual Customer Risk Rate"."Member Name")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Membership Application No");
                DataItemTableView = where("Member Risk Level" = filter("High Risk"));
                RequestFilterFields = "No.", Name;
                column(No_MembersRegister; Customer."No.")
                {
                }
                column(MemberRiskLevel_MembersRegister; Customer."Member Risk Level")
                {
                }
                column(Name_MembersRegister; Customer.Name)
                {
                }
                column(IDNo_MembersRegister; Customer."ID No.")
                {
                }
                column(PhoneNo_MembersRegister; Customer."Phone No.")
                {
                }
                column(CreatedBy_MembersRegister; Customer."Created By")
                {
                }
                column(MonthlyTurnOverActual_MembersRegister; Customer."Monthly TurnOver_Actual")
                {
                }
                column(ExpectedMonthlyIncome_MembersRegister; Customer."Expected Monthly Income")
                {
                }
                column(DueDiligenceMeasure_MembersRegister; Customer."Due Diligence Measure")
                {
                }
                column(EmployerName_MembersRegister; Customer."Employer Name")
                {
                }
                column(EmployerCode_MembersRegister; Customer."Employer Code")
                {
                }
                column(Pin_MembersRegister; Customer.Pin)
                {
                }
                column(BusinessName_MembersRegister; Customer."Business Name")
                {
                }
                column(MembersResidence_MembersRegister; Customer."Member's Residence")
                {
                }
                column(ExpectedMonthlyIncomeAmount_MembersRegister; Customer."Expected Monthly Income Amount")
                {
                }
                column(NatureOfBusiness_MembersRegister; Customer."Nature Of Business")
                {
                }
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
                // Variance:="Audit Suspicious Transactions"."Transaction Amount"-"Audit Suspicious Transactions"."Max Credits Allowable";
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
        SN: Integer;
        Variance: Decimal;


    var

}
