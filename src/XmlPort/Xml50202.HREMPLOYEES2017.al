#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50202 "HR EMPLOYEES 2017"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Payroll Employee."; "Payroll Employee.")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No; "Payroll Employee."."No.")
                {
                }
                fieldelement(a; "Payroll Employee.".Firstname)
                {
                }
                fieldelement(b; "Payroll Employee.".Lastname)
                {
                }
                fieldelement(c; "Payroll Employee.".Surname)
                {
                }
                fieldelement(dd; "Payroll Employee."."National ID No")
                {
                }
                fieldelement(e; "Payroll Employee.".Department)
                {
                }
                fieldelement(f; "Payroll Employee."."Global Dimension 2")
                {
                }
                fieldelement(g; "Payroll Employee."."Employee Email")
                {
                }
                fieldelement(j; "Payroll Employee."."Bank Account No")
                {
                }
                fieldelement(k; "Payroll Employee."."Bank Name")
                {
                }
                fieldelement(AA; "Payroll Employee."."Branch Name")
                {
                }
                fieldelement(SS; "Payroll Employee."."Joining Date")
                {
                }
                fieldelement(DD; "Payroll Employee."."Job Title")
                {
                }
                fieldelement(FF; "Payroll Employee."."PIN No")
                {
                }
                fieldelement(GG; "Payroll Employee."."NSSF No")
                {
                }
                fieldelement(HH; "Payroll Employee."."NHIF No")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

